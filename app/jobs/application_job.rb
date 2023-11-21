class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  around_enqueue do |job, block|
    existing_queued_jobs = list_queued_jobs(job.class, job.queue_name, job.arguments)
    if existing_queued_jobs.size == 0
        block.call # this will enqueue your job
    else
        puts "job not enqueue because already queued (#{job.class}, #{job.queue_name}, #{job.arguments})"
    end
  end

  def list_queued_jobs(job_class, queue_name,  arguments)
    found_jobs = []
    queues = Sidekiq::Queue.all
    queues.each do |queue|
        queue.each do |job|
            job.args.each do |arg|
                 found_jobs << job if arg['job_class'].to_s == job_class.to_s && arg['queue_name'] == queue_name && arg['arguments'] == arguments
            end
        end
    end
    return found_jobs
  end
end
