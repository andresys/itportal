class UserPolicy < ApplicationPolicy
  def index?
    return true if user.has_role? :admin, User
    return true if user.has_role? :member, User
    super
  end

  def show?
    return true if user.has_role? :admin, User
    return true if user.has_role? :member, User
    super
  end

  def create?
    return true if user.has_role? :admin, User
    super
  end

  def update?
    return true if user.has_role? :admin, User
    super
  end

  def destroy?
    return false if record&.respond_to?(:has_role?) && record.has_role?(:superadmin) && User.with_role(:superadmin).count == 1
    return false if record == user
    return true if user.has_role? :admin, User
    super
  end

  def create_approved?
    return false if record&.respond_to?(:approved) && record.approved
    create?
  end

  def destroy_approved?
    return false unless record&.respond_to?(:approved) && record.approved
    destroy?
  end
end