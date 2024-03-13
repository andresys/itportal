class AssetPolicy < ApplicationPolicy
  def index?
    return true if user.has_role? :admin, Asset
    return true if user.has_role? :member, Asset
    super
  end

  def show?
    return true if user.has_role? :admin, Asset
    return true if user.has_role? :member, Asset
    super
  end

  def create?
    return true if user.has_role? :admin, Asset
    super
  end

  def update?
    return true if user.has_role? :admin, Asset
    super
  end

  def destroy?
    return true if user.has_role? :admin, Asset
    super
  end
end