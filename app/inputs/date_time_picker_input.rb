class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, wrapper_options.merge(class: 'input-group', 'data-target-input': 'nearest', id: "#{object_name}_#{attribute_name}")) do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat div_button
    end
  end

  def input_html_options
    super.merge({class: 'form-control datetimepicker-input', data: {target: "##{object_name}_#{attribute_name}", toggle: 'datetimepicker'}, autocomplete: 'off'})
  end

  def div_button
    template.content_tag(:div, class: 'btn btn-secondary', data: {target: "##{object_name}_#{attribute_name}", toggle: 'datetimepicker'} ) do
      template.icon_tag('calendar-check')
    end
  end
end