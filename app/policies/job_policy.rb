class JobPolicy < ApplicationPolicy
  def index?
    return true if user.has_role? :admin, Job
    return true if user.has_role? :member, Job
    super
  end

  def show?
    return true if user.has_role? :admin, Job
    return true if user.has_role? :member, Job
    super
  end

  def create?
    return true if user.has_role? :admin, Job
    super
  end

  def update?
    return true if user.has_role? :admin, Job
    super
  end

  def destroy?
    return true if user.has_role? :admin, Job
    super
  end
end