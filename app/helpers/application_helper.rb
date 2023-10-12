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
        if icon.is_a? Hash
          icon, icon_type, icon_options = icon.delete(:name), icon.delete(:type), icon
          icon, icon_type = icon_options.delete(:svg), "svg" if icon_options.key?(:svg)
        end
        concat (content_tag :span, class: "nav-icon" do
          icon_tag icon, icon_type, icon_options
        end) if icon
        concat (content_tag :span, name, class: "nav-link-text")
        concat (content_tag :span, class: "submenu-arrow" do
          icon_tag "chevron-down"
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

  def icon_tag(icon, icon_type = nil, icon_options = {})
    icon_type ||= "bootstrap"
    icon_options ||= {}
    case icon_type
    when "bootstrap"
      file = File.read("node_modules/bootstrap-icons/icons/#{icon}.svg")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css 'svg'
      icon_options.each do |k,v|
        svg[k] = v
      end
      doc.to_html.html_safe
    when "svg"
      raw icon
    else
      "Unknown icon type"
    end
  end
end
