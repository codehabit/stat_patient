module ApplicationHelper
  def select2_for(options = {})
    field_name, field_type, label_method, input_field_name, object_type = options[:field_name], options[:field_type], options[:label_method], options[:input_field_name], options[:object_type]
    if input_field_name.nil? && object_type.present?
      input_field_name = "#{object_type}[#{field_name}_id]"
    end
    error_class = (@message.present? && @message.errors[field_name].present?) ? "has-error" : ""
    content_tag(:div, class: "form-group #{error_class}") do
      content_tag(:label, class: "control-label col-sm-2", for: "message_subject") do
        field_name.to_s.capitalize
      end +
      content_tag(:div, class: "col-sm-10") do
        select_tag(input_field_name, options_from_collection_for_select(field_type.all.decorate, :id, label_method), {placeholder: "Select a #{field_name}", include_blank: true, data: {role: 'select2'}}) +
        if error_class.present?
          message = "You must select a #{field_name}"
          content_tag(:span, message, class: "help-block")
        end
      end
    end
  end
end

