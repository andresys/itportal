class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  around_perform :around_job
  attr_accessor :job

  rescue_from(StandardError) do |exception|
    @job.update(end_time: DateTime.now, status: exception.message)
  end

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  # around_enqueue do |job, block|
  #   existing_queued_jobs = list_queued_jobs(job.class, job.queue_name, job.arguments)
  #   if existing_queued_jobs.size == 0
  #       block.call # this will enqueue your job
  #   else
  #       puts "job not enqueue because already queued (#{job.class}, #{job.queue_name}, #{job.arguments})"
  #   end
  # end

  # def list_queued_jobs(job_class, queue_name,  arguments)
  #   found_jobs = []
  #   queues = Sidekiq::Queue.all
  #   queues.each do |queue|
  #       queue.each do |job|
  #           job.args.each do |arg|
  #                found_jobs << job if arg['job_class'].to_s == job_class.to_s && arg['queue_name'] == queue_name && arg['arguments'] == arguments
  #           end
  #       end
  #   end
  #   return found_jobs
  # end

private
  def around_job
    job_type = self.class.name.gsub(/::/, '/')
                .gsub(/([0-9A-Z]+)([0-9A-Z][a-z])/,'\1_\2')
                .gsub(/([a-z\d])([0-9A-Z])/,'\1_\2')
                .tr("-", "_").downcase.gsub(/_job$/, "").to_sym
    @job = Job.create(start_time: DateTime.now, job_type: job_type, job_id: @job_id)
    yield
    @job.update(end_time: DateTime.now)
  end
end
