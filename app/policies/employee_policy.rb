class EmployeePolicy < ApplicationPolicy
  def index?
    return true if user.has_role? :admin, Employee
    return true if user.has_role? :member, Employee
    super
  end

  def show?
    return true if user.has_role? :admin, Employee
    return true if user.has_role? :member, Employee
    super
  end

  def create?
    return true if user.has_role? :admin, Employee
    super
  end

  def update?
    return true if user.has_role? :admin, Employee
    super
  end

  def destroy?
    return true if user.has_role? :admin, Employee
    super
  end
end