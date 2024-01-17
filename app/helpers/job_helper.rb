module JobHelper
  def job_logs job
    return unless job.status
    status = []
    status << {time: job.start_time, name: 'Starting a job'} if job.start_time
    status += job.status['step'].kind_of?(Array) ? job.status['step'] : [job.status['step']]
    status << {time: job.end_time, name: 'Finishing the job'} if job.end_time

    tag.div class: "text-truncate" do
      status.each do |s|
        concat log_string s
      end
    end
  end

  def job_current_log_step job
    return unless job.status
    status = []
    status << {time: job.start_time, name: 'Starting a job'} if job.start_time
    status += job.status['step'].kind_of?(Array) ? job.status['step'] : [job.status['step']]
    status << {time: job.end_time, name: 'Finishing the job'} if job.end_time

    tag.div class: "text-truncate" do
      log_string status.last, date_format: "%H:%M:%S"
    end
  end

  def job_progress job
    return unless job.status
    progress = job.status['progress'].to_i
    total = job.status['total'].to_i
    procent = progress * 100 / total if total > 0 && progress <= total
    tag.div class: "progress", style: "height: 1px" do
      tag.div class: "progress-bar", style: "width: #{procent}%"
    end if job.status['status'] == 'working'
  end

  def job_status job
    return unless job.status
    case job.status['status']
      when 'failed'
        tag.span class: "text-danger" do
          bs_icon "exclamation-triangle-fill"
        end
      when 'completed'
        tag.span class: "text-success" do
          bs_icon "check-circle-fill"
        end
      # when 'working'
      #   tag.div class: "d-flex align-items-center" do
      #     tag.span class: "spinner-border spinner-border-sm text-secondary" do
      #       tag.span "Loading...", class: "visually-hidden"
      #     end
      #   end
    end
  end

private
  def log_string s, options = {}
    include_time = (v = options.delete(:include_time)).nil? && true || false
    date_format = options.delete(:date_format) || "%d.%m.%Y %H:%M:%S"
    s = s.symbolize_keys if s.kind_of?(Hash)
    tag.div class: "text-truncate" do
      if s.kind_of?(Hash)
        s[:time] = DateTime.parse(s[:time]) if s[:time].kind_of?(String)
        concat tag.small s[:time] && l(s[:time].localtime, format: date_format), class: "me-2" if include_time
        concat tag.small s[:name]
      else
        tag.small s
      end
    end
  end
end