class ImportEmployeesJob < ApplicationJob
  def perform(*args)
    set_step "Import employees from HTTP service"
    data = PhonebookImportService.call("/api/v1/contacts?from=0&limit=1000") {|step| set_step step}

    if data.respond_to?(:any?) && data.any?
      set_step "Parsing data from JSON"
      employees = employees_from(data['contacts'])

      set_step "Save materials to database"
      Employee.import employees, ignore: true
    end
  end

private 

  def employees_from(employees)
    progress.total = employees.count

    employees.map do |employee|
      progress.increment

      update_finded_employee(employee) || Employee.new(employee_params employee)
    end
  end

  def update_finded_employee employee
    finded = Employee.find_by(code: !employee['id'].blank? && employee['id'] || nil)
    finded&.update(employee_params employee)
    finded
  end

  def employee_params employee
    name = employee['name'].strip.gsub(/( +-+|-+ +|^-+|-+$)/, '').gsub(/ {2,}/, ' ')
    return {
      name: !name.blank? && name || nil,
      code: !employee['id'].blank? && employee['id'] || nil
    }
  end
end