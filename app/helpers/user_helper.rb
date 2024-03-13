module UserHelper
  def role_tag role
    tag.div class: "text-truncate" do
      tag.span role_name(role), class: "badge text-secondary bg-secondary-subtle d-block text-truncate"
    end
  end

  def role_name role
    role_name = role.name
    role_name = :admin if role_name == 'superadmin' && !(current_user.has_role? :superadmin)
    
    role_name = I18n.t("global.roles.#{role_name}")
    role_name = I18n.t("global.roles.resource_role", role: role_name, resource: t("global.roles.models.#{role.resource_type}", default: role.resource_type)) if role.resource_type
    role_name = I18n.t("global.roles.resource_role_id", role: role_name, resource: t("global.roles.models.#{role.resource_type}", default: role.resource_type), id: role.resource_id) if role.resource_id
    
    role_name
  end

  def user_item_tag title, value = nil, options = {}
    # case args
    # in [String => value, Proc => action, Hash => options]
    # in [String => value, Proc => action]
    # in [String => value, Hash => options]
    # in [Proc => action, Hash => options]
    # in [Proc => action]
    # in [String => value]
    # in [Hash => options]
    # in []
    # end

    action = options.delete(:action)
    css_class = options.delete(:class)
    icon = options.delete(:icon)

    tag.div class: ["item", css_class].join(' ') do
      concat (tag.div class: "item-label" do
        concat(fa_icon icon, class: "me-2") if icon
        concat(tag.strong title)
      end)
      concat (tag.div class: "row justify-content-between align-items-center" do
        concat (tag.div class: "col" do
          tag.div class: "item-data" do
            block_given? ? yield : value || ''
          end
        end)
        concat (tag.div class: "col-auto text-end" do
          action.call
          # link_to "Change", "#", class: "btn-sm btn-outline-secondary"
        end if action)
      end)
    end
  end

  def card_tag title, options = {}
    css_class = options.delete(:class)
    icon = options.delete(:icon) || "pencil-square"
    footer = options.delete(:footer)

    tag.div class: "app-card app-card-account shadow-sm d-flex flex-column align-items-streach" do
      concat (card_header title, icon)
      concat (tag.div class: "app-card-body px-4 w-100" do
        yield if block_given?
      end)
      concat (tag.div footer, class: "app-card-footer p-3 mt-auto" if footer)
    end
  end

  def panel_tag options = {}
    css_class = options.delete(:class)

    tag.div class: "app-card app-card-account shadow-sm d-flex flex-column align-items-streach" do
      tag.div class: "app-card-body p-3#{css_class && ' ' + css_class}" do
        yield if block_given?
      end
    end
  end

  private

  def card_header title, icon
    tag.div class: "card-header p-3" do
      tag.div class: "row align-items-center gx-3" do
        concat (tag.div class: "col-auto" do
          tag.div class: "app-icon-holder" do
            bs_icon icon
          end if icon
        end)
        concat (tag.div class: "col" do
          tag.h4 title, class: "app-card-title"
        end)
      end
    end
  end
end