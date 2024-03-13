class ApprovedPolicy < ApplicationPolicy
  def create?
    return true if user.has_role? :admin, User
    super
  end

  def destroy?
    return true if user.has_role? :admin, User
    super
  end
end