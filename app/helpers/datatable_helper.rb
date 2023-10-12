module DatatableHelper
  def datatable_tag(objects, options = {})
    options = default_options(options)

    content_tag :div, class: "datatable" do
      concat table(objects, options)
    end
  end

private

  def default_options(options)
    {
      actions: [:edit, :delete]
    }.merge(options)
  end

  def table(objects, options)
    columns = options.delete(:columns)
    actions = options.delete(:actions)
    content_tag :table, class: "table table-hover" do
      concat (content_tag :thead do thead(columns, actions) end)
      concat (content_tag :tbody, class: "table-success" do tbody(objects, columns, actions) end)
    end
  end

  def thead(columns, action = false)
    content_tag :tr do
      columns.each do |column|
        column = column.values.first if column.is_a? Hash
        column = column.call() if column.is_a? Proc
        concat (content_tag :th, column)
      end
      concat (content_tag :th, "") if action
    end
  end

  def tbody(objects, columns, actions = false)
    objects.each do |object|
      concat (content_tag :tr do
        columns.each do |column|
          column = column.keys.first if column.is_a? Hash
          concat (content_tag :td do content_tag :div, object[column] end)
        end
        concat (content_tag :td, class: "actions" do actions(object, actions) end) if actions
      end)
    end
  end

  def actions(object, actions)
    actions.each do |action|
      case action
      when :edit
        link = url_for(action: "edit", id: object)
        concat (link_to link, class: "btn btn-sm btn-link" do icon_tag("pencil-square") end)
      when :delete
        concat (content_tag :button, class: "btn btn-sm btn-link" do icon_tag("trash") end)
      end
      concat (action.call(object)) if action.is_a? Proc
    end
  end
end