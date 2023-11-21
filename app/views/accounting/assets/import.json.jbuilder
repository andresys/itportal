
json.id @job.job_id
json.url jobs_path(@job.job_id)
json.status ActiveJob::Status.get(@job.job_id).status