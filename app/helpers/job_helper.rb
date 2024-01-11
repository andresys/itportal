module JobHelper
  def job_status job
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
    tag.small "[#{job.status['progress']} / #{job.status['total']}]" if job.status['progress']
  end
end