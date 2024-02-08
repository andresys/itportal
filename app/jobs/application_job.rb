# require 'sidekiq-scheduler'

class ApplicationJob < ActiveJob::Base
  include ActiveJob::Status
  # include Sidekiq::Job
  
  queue_as :default

  before_enqueue do |job|
    job.status[:status] = :queued
    job_type = self.class.name.gsub(/::/, '/')
        .gsub(/([0-9A-Z]+)([0-9A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([0-9A-Z])/,'\1_\2')
        .tr("-", "_").downcase.gsub(/_job$/, "").to_sym
    Job.create(job_type: job_type, job_id: @job_id)
  end

  before_perform do |active_job|
    active_job.status[:status] = :working
    job = Job.find_by(job_id: @job_id)
    job&.update(start_time: DateTime.now)
    ActionCable.server.broadcast "job_channel", { job_id: @job_id,
      job_item: ApplicationController.render(partial: "jobs/job_item", locals: { job: job }),
      job_progress: ApplicationController.helpers.job_progress(Job.find_by(job_id: job_id)),
      job_action: ApplicationController.render(partial: "jobs/job_action", locals: { job: job })
    }
  end

  after_perform do |active_job|
    active_job.status[:status] = :completed
    job = Job.find_by(job_id: @job_id)
    job&.update(end_time: DateTime.now, status: active_job.status.to_h)
    ActionCable.server.broadcast "job_channel", { job_id: @job_id,
      job_item: ApplicationController.render(partial: "jobs/job_item", locals: { job: job }),
      job_progress: ApplicationController.helpers.job_progress(Job.find_by(job_id: job_id)),
      job_action: ApplicationController.render(partial: "jobs/job_action", locals: { job: job })
    }
  end

  rescue_from(Exception) do |e|
    status[:status] = :failed
    status[:exception] = { class: e.class, message: e.message }
    job = Job.find_by(job_id: @job_id)
    job&.update(end_time: DateTime.now, status: status.to_h)
    ActionCable.server.broadcast "job_channel", { job_id: @job_id,
      job_item: ApplicationController.render(partial: "jobs/job_item", locals: { job: job }),
      job_progress: ApplicationController.helpers.job_progress(Job.find_by(job_id: job_id)),
      job_action: ApplicationController.render(partial: "jobs/job_action", locals: { job: job })
    }
    raise e
  end

protected
  def set_step step
    status[:step] = (status[:step] || []).push({ time: DateTime.now, name: step })
    p step
    job = Job.find_by(job_id: job_id)
    current_step = ApplicationController.helpers.job_current_log_step(job)
    messages = ApplicationController.render(partial: 'jobs/log', locals: {job: job})
    ActionCable.server.broadcast "job_channel", { job_id: job_id, step: current_step, messages: messages }
  end

  def set_progress total = nil
    if total
      progress.total = total
    else
      progress.increment
    end
    procent = (status[:progress]&.to_i * 100 || 0) / status[:total]&.to_i if status[:total]&.to_i > 0
    ActionCable.server.broadcast "job_channel", { job_id: job_id, procent: procent || 0 }
  end
end
