class RolePolicy < ApplicationPolicy
  def index?
    return true if user.has_role? :admin, User
    return true if user.has_role? :member, User
    super
  end

  def create?
    return true if user.has_role? :admin, User
    super
  end

  def destroy?
    return true if user.has_role? :admin, User
    super
  end
end