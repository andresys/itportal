class NumberInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, wrapper_options.merge(class: 'input-group')) do
      template.concat minus_button
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat plus_button
    end
  end

  def input_html_options
    super.merge({class: 'form-control text-center', autocomplete: 'off'})
  end

  def minus_button
    template.content_tag(:div, class: 'btn btn-secondary minus') do
      template.icon_tag('dash-lg')
    end
  end

  def plus_button
    template.content_tag(:div, class: 'btn btn-secondary plus') do
      template.icon_tag('plus-lg')
    end
  end
end