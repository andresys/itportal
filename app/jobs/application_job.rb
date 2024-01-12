class ApplicationJob < ActiveJob::Base
  include ActiveJob::Status
  
  queue_as :default

  attr_accessor :job

  before_enqueue do |job|
    job.status[:status] = :queued
    job_type = self.class.name.gsub(/::/, '/')
        .gsub(/([0-9A-Z]+)([0-9A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([0-9A-Z])/,'\1_\2')
        .tr("-", "_").downcase.gsub(/_job$/, "").to_sym
    Job.create(job_type: job_type, job_id: @job_id)
  end

  before_perform do |job|
    job.status[:status] = :working
    Job.find_by(job_id: @job_id)&.update(start_time: DateTime.now)
  end

  after_perform do |job|
    job.status[:status] = :completed
    Job.find_by(job_id: @job_id)&.update(end_time: DateTime.now, status: job.status.to_h)
  end

  rescue_from(Exception) do |e|
    status[:status] = :failed
    status[:exception] = { class: e.class, message: e.message }
    Job.find_by(job_id: @job_id)&.update(end_time: DateTime.now, status: status.to_h)
    raise e
  end

protected
  def set_step step
    status[:step] = (status[:step] || []).push({time: DateTime.now, name: step})
    p step
  end
end
