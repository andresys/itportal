module JobHelper
  def job_logs job
    status = job.status['step']
    if status.kind_of?(Array)
      status = status.map do |s|
        tag.div do
          if s.kind_of?(Hash)
            concat tag.small l(DateTime.parse(s['time']).localtime, format: "%d.%m.%Y %H:%M:%S"), class: "me-2"
            concat tag.small s['name']
          else
            tag.small s
          end
        end
      end.join
    else
      status = tag.small status
    end
    status.html_safe
  end

  def job_progress job
    progress = job.status['progress'].to_i
    total = job.status['total'].to_i
    procent = progress * 100 / total if total > 0 && progress <= total
    tag.div class: "progress", style: "height: 1px" do
      tag.div class: "progress-bar", style: "width: #{procent}%"
    end if job.status['status'] == 'working'
  end

  def job_status job
    case job.status['status']
      when 'failed'
        tag.span class: "text-danger" do
          bs_icon "exclamation-triangle-fill"
        end
      when 'completed'
        tag.span class: "text-success" do
          bs_icon "check-circle-fill"
        end
      when 'working'
        tag.div class: "d-flex align-items-center" do
          tag.span class: "spinner-border spinner-border-sm text-secondary" do
            tag.span "Loading...", class: "visually-hidden"
          end
        end
    end
  end
end