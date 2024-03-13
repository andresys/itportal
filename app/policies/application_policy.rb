# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    return true if user.has_any_role? :superadmin, :admin
    false
  end

  def show?
    return true if user.has_any_role? :superadmin, :admin
    false
  end

  def create?
    return true if user.has_any_role? :superadmin, :admin
    false
  end

  def new?
    create?
  end

  def update?
    return true if user.has_any_role? :superadmin, :admin
    false
  end

  def edit?
    update?
  end

  def destroy?
    return true if user.has_any_role? :superadmin, :admin
    false
  end

  def method_missing(method_name, *args, &block)
    if method_name.to_s.end_with?("?")
      return true if user.has_any_role? :superadmin, :admin
      false
    else
      super(method_name, *args, &block)
    end
  end

  def respond_to?(method_name, include_private = false)
    method_name.to_s.end_with?('?') || super
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
