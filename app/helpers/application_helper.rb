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
    status = { '101.36' => 'on_balance', "101.34" => 'on_balance', '21.36' => 'out_balance', '21.34' => 'out_balance', '102' => 'storage' }[code]
    colors = { 'on_balance' => 'bg-success', 'out_balance' => 'bg-warning', 'storage' => 'bg-danger' }
    content_tag :span, t(status), class: ["badge", colors[status]].join(' ') if status
  end

  def page_title title, back_url = nil, &block
    tag.div class: "d-flex flex-column flex-sm-row mb-4 justify-content-between" do
      icon = bs_icon 'chevron-left', '1.2em'
      concat (tag.div class: "d-flex align-items-center flex-nowrap mb-2 mb-sm-0" do
        concat link_to icon, back_url, class: "btn app-btn-secondary me-2" if back_url
        concat tag.h1 title, class: "app-page-title mb-0 text-truncate"
      end)
      concat tag.div class: "d-flex gap-2", &block
    end
  end
end
