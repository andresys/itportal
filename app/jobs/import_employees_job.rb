class ImportEmployeesJob < ApplicationJob
  def perform(*args)
    status.update(step: "Import employees from HTTP service")
    p "Import employees from HTTP service"

    data = PhonebookImportService.call("/api/v1/contacts?from=0&limit=1000") {|step| status.update(step: step)}
    if data.respond_to?(:any?) && data.any?
      status.update(step: "Parsing data from JSON")
      p "Parsing data from JSON"
      employees = employees_from(data['contacts'])
      status.update(step: "Save materials to database")
      p "Save materials to database"

      Employee.import employees, ignore: true
      status.update(step: "Ok")
      p "Ok"
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
    finded = Employee.find_by("code = ?", employee['id'])
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