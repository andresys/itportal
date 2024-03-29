#require "securerandom"

module ApplicationHelper
  def nav_item_tag(name, link, options = {})
    active = true if link && /#{link}/ =~ request.path
    active = options.delete(:active) if options.key?(:active)
    icon = options.delete(:icon)
    submenu = block_given? && "submenu-#{SecureRandom.hex(6)}"
    content_tag :li, class: ["nav-item", submenu && "has-submenu" || nil].compact.join(" ") do
      options.merge!(class: ["nav-link", submenu && "submenu-toggle" || nil, active && "active" || nil].compact.join(" "))
      options.merge!('data-bs-toggle': "collapse", 'aria-expanded': active, 'data-bs-target': "##{submenu}") if submenu
      concat (link_to link || "#", options do
        concat (content_tag :span, class: "nav-icon" do
          bs_icon icon
        end) if icon
        concat (content_tag :span, name, class: "nav-link-text")
        concat (content_tag :span, class: "submenu-arrow" do
          bs_icon "chevron-down"
        end) if submenu
      end)
      concat (content_tag :div, id: submenu, class: ["collapse submenu", active && "show" || nil].compact.join(" ") do
        content_tag :ul, class: "submenu-list list-unstyled" do
          yield
        end
      end) if block_given?
    end
  end

  def sub_item_tag(name, link, options = {})
    active = true if link && /#{link}/ =~ request.path
    active = options.delete(:active) if options.key?(:active)
    content_tag :li, options.merge(class: "submenu-item") do
      link_to name, link || "#", class: ["submenu-link", active && "active" || nil].compact.join(" ")
    end
  end

  def status_tag(code)
    status = { '101.36' => 'on_balance', "101.34" => 'on_balance', '21.36' => 'out_balance', '21.34' => 'out_balance', '102.00' => 'storage', '02.3' => 'disposal' }[code]
    colors = { 'on_balance' => 'bg-success', 'out_balance' => 'bg-warning', 'storage' => 'bg-danger', 'disposal' => 'bg-warning' }
    content_tag :span, Asset.human_enum_name(:statuses, status), class: ["badge", colors[status]].join(' ') if status
  end

  def full_title(page_title)
    base_title = "itPortal"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def page_title title, back_url = nil, &block
    tag.div class: "d-flex flex-column d-sm-block mb-4 justify-content-between" do
      icon = bs_icon 'chevron-left', '1.2em'
      concat tag.div class: "order-2 float-end d-flex gap-2 flex-wrap", &block
      concat (tag.div class: "order-1 d-flex align-items-center flex-nowrap mb-2 mb-sm-0" do
        concat link_to icon, back_url, class: "btn btn-outline-secondary me-2" if back_url
        concat tag.h1 title, class: "app-page-title mb-0 text-truncate"
      end)
    end
  end

  def setting_section_tag title, description = nil
    tag.div class: "row g-4 settings-section mb-3" do
      concat (tag.div class: "col-12 col-md-4" do
        concat tag.h3 title.html_safe, class: "section-title" if title
        concat tag.div description.html_safe, class: "section-intro" if description
      end)
      concat (tag.div class: "col-12 col-md-8 mt-1 mt-sm-4" do
        tag.div class: "app-card app-card-settings shadow-sm p-4" do
          tag.div class: "app-card-body" do
            yield if block_given?
          end
        end
      end)
    end
  end

  def popover_tag content = "", options = {}
    css_class = options.delete(:class) || ''
    placement = options.delete(:placement) || "top"
    tag.span class: css_class, data: { bs_container: "body", bs_toggle: "popover", bs_trigger: "hover focus", bs_placement: placement, bs_content: content } do
      bs_icon "info-circle"
    end
  end
end
