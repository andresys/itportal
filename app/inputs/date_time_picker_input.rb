class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, wrapper_options.merge(class: 'input-group', 'data-target-input': 'nearest', id: "#{object_name}_#{attribute_name}")) do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat div_button
    end
  end

  def input_html_options
    options = {class: ['form-control', 'datetimepicker-input'], data: {target: "##{object_name}_#{attribute_name}", toggle: 'datetimepicker'}, autocomplete: 'off'}
    merger = proc { |key, v1, v2| if Hash === v1 && Hash === v2; v1.merge(v2, &merger); elsif Array === v1 && Array === v2; v1 + v2; else v2; end }
    super.merge(options, &merger)
  end

  def div_button
    template.content_tag(:div, class: 'btn btn-secondary', data: {target: "##{object_name}_#{attribute_name}", toggle: 'datetimepicker'} ) do
      template.icon_tag('calendar-check')
    end
  end
end