class ImportEmployeesJob < ApplicationJob
  def perform(*args)
    set_step "Import employees from HTTP service"
    data = PhonebookImportService.call("/api/v1/contacts?from=0&limit=1000") {|step| set_step step}

    return unless data.respond_to?(:any?) && data.any?

    progress.total = data.count
    job = Job.find_by(job_id: @job_id)
    ids = []
    histories = []
    
    set_step "Parsing data from JSON and save employees to database"
    
    data['contacts'].each do |employee|
      progress.increment

      values = employee_params employee
      if finded = Employee.find_by(code: values[:code])
        values.delete_if {|k,v| v == finded[k]}
        if values.any?
          histories << JobHistory.new(job: job, record: finded, action: 'change', values: finded.slice(values.keys))
          finded.update(values)
        end
        ids << finded.id
      else
        created = Employee.create(values)
        histories << JobHistory.new(job: job, record: created, action: 'add')
        ids << created.id
      end
    end

    set_step "Removing removed employees from database"
    removed_employees = Employee.where(delete_mark: false).where.not(id: ids)
    removed_employees.each { |employee| histories << JobHistory.new(job: job, record: employee, action: 'remove') }
    removed_employees.update_all(delete_mark: true)

    set_step "Saving employees histories"
    JobHistory.import histories
  end

private 
  def employee_params employee
    name = employee['name'].strip.gsub(/( +-+|-+ +|^-+|-+$)/, '').gsub(/ {2,}/, ' ')
    return {
      name: !name.blank? && name || nil,
      code: !employee['id'].blank? && employee['id'] || nil
    }
  end
end