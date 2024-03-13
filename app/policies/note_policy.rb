class NotePolicy < ApplicationPolicy
  def index?
    return true if user.has_role? :admin, Note
    return true if user.has_role? :member, Note
    super
  end

  def show?
    return true if user.has_role? :admin, Note
    return true if user.has_role? :member, Note
    super
  end

  def create?
    return true if user.has_role? :admin, Note
    return true if user.has_role? :member, Note
    return true if user.has_role? :member, Asset
    return true if user.has_role? :member, Material
    super
  end

  def update?
    return true if user.has_role? :admin, Note
    super
  end

  def destroy?
    return true if user.has_role? :admin, Note
    super
  end
end