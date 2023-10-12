class JsonInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_html_options[:type] ||= input_type
    template.content_tag(:div, id: gen_id(:wrap)) do
      input_keys.map do |key, val|
        template.content_tag(:div, class: 'input-group form-group') do
          template.concat @builder.text_field(nil, input_html_options.merge(value: key, name: "#{object_name}[#{attribute_name}][keys][]", id: nil))
          template.concat @builder.text_field(nil, input_html_options.merge(value: val, name: gen_name(key), id: gen_id(:val)))
          template.concat "<div class=\"input-group-append\"><button type=\"button\" class=\"btn btn-outline-secondary\" id=\"\"><span aria-hidden=\"true\">&times;</span></button></div>".html_safe
        end
      end.join.html_safe
    end +
    template.content_tag(:div, class: 'form-group float-right') do
      template.concat template.button_tag(t("add_field"), type: "button", class: "btn btn-link btn-sm", id: gen_id(:add) )
      template.concat template.javascript_tag <<-script
        $(function() {
            $('##{gen_id(:wrap)}>div button').click(function() {
              if($('##{gen_id(:wrap)}>div').length > 1) {
                $(this).closest('div.input-group').remove();  
              }
            });
            $('##{gen_id(:add)}').on('click', function() {
              $last = $('##{gen_id(:wrap)}>div:last-of-type').clone();
              [$key, $val] = $last.find('input').attr('value', '');
              $($key).change(function(){$val.name = '#{object_name}[#{attribute_name}]['+this.value+']'});
              $($val).attr('name', '#{object_name}[#{attribute_name}][]');
              $last.find('button').click(function() {
                if($('##{gen_id(:wrap)}>div').length > 1) {
                  $(this).closest('div.input-group').remove();  
                }
              });
              $('##{gen_id(:wrap)}').append($last);
            });
        });
      script
    end
  end

  def input_type
    :text   
  end

  def input_html_options
    super.merge({class: 'form-control'})
  end

  def label_html_options
    super.merge({for: gen_id(:val)})
  end

private

  def input_keys
    options[:keys].map{|k| [k, nil]}.to_h.merge(object.public_send(attribute_name) || {})
  end

  def gen_name(key)
    "#{object_name}[#{attribute_name}][#{key}]"
  end

  def gen_id(key)
    gen_name(key).gsub(/\W/, '_')
  end
end