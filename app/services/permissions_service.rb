class PermissionsService
  def initialize(user, controller, action)
    @_user = user || User.new
    @_controller = controller
    @_action = action
  end

  def allow?
    if user.platform_admin?
      platform_admin_permissions
    elsif user.business_owner?
      business_owner_permissions
    elsif user.business_admin?
      business_admin_permissions
    else
      registered_user_permissions
    end
  end

  private
  def action
    @_action
  end

  def controller
    @_controller
  end

  def user
    @_user
  end

  def registered_user_permissions
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_category" && action == "show"
    return true if controller == "charity/recipients" && action == "show"
  end

  def business_admin_permissions
    return true if controller == "admin/needs" && action == "index"
    return true if controller == "admin/dashboards" && action == "show"
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_category" && action == "show"
    return true if controller == "charity/recipients" && action == "show"
  end

  def business_owner_permissions
    return true if controller == "admin/dashboard" && action == "show"
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_category" && action == "show"
    return true if controller == "charity/recipients" && action == "show"
  end

  def platform_admin_permissions
    return true if controller == "admin/dashboard" && action == "show"
    return true if controller == "sessions" && action == "new"
    return true if controller == "sessions" && action == "create"
    return true if controller == "users" && action == "new"
    return true if controller == "users" && action == "create"
    return true if controller == "users" && action == "edit"
    return true if controller == "users" && action == "update"
    return true if controller == "users" && action == "show"
    return true if controller == "cart" && action == "index"
    return true if controller == "cart_items" && action == "create"
    return true if controller == "cart_items" && action == "update"
    return true if controller == "cart_items" && action == "destroy"
    return true if controller == "donations" && action == "new"
    return true if controller == "donations" && action == "index"
    return true if controller == "donations" && action == "show"
    return true if controller == "donations" && action == "create"
    return true if controller == "homes" && action == "show"
    return true if controller == "charities" && action == "index"
    return true if controller == "charities" && action == "show"
    return true if controller == "causes" && action == "show"
    return true if controller == "needs_category" && action == "show"
    return true if controller == "charity/recipients" && action == "show"
  end
end
