class MaterialPolicy < ApplicationPolicy
  def index?
    return true if user.has_role? :admin, Material
    return true if user.has_role? :member, Material
    super
  end

  def show?
    return true if user.has_role? :admin, Material
    return true if user.has_role? :member, Material
    super
  end

  def create?
    return true if user.has_role? :admin, Material
    super
  end

  def update?
    return true if user.has_role? :admin, Material
    super
  end

  def destroy?
    return true if user.has_role? :admin, Material
    super
  end
end