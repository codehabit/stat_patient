module ApplicationHelper
  def select2_for(options = {})
    field_name, field_type, label_method, input_field_name, object_type = options[:field_name], options[:field_type], options[:label_method], options[:input_field_name], options[:object_type]
    if input_field_name.nil? && object_type.present?
      input_field_name = "#{object_type}[#{field_name}_id]"
    end
    error_class = (@case.present? && @case.errors[field_name].present?) ? "has-error" : ""
    content_tag(:div, class: "form-group #{error_class}") do
      content_tag(:label, class: "control-label col-sm-2", for: "message_subject") do
        options[:label] || field_name.to_s.humanize
      end +
      content_tag(:div, class: "col-sm-10") do
        placeholder = options[:label] || field_name.to_s.humanize
        if field_type == Patient
          collection = @current_practitioner.practice_patients.decorate
        elsif !options.has_key? :collection
          collection = field_type.all.decorate
        end



        #############################################################
        # NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE    #
        # refactor the above collection logic to just use the below #
        #############################################################
        if options.has_key? :collection
          collection = options[:collection]
        end

        select_tag(input_field_name, options_from_collection_for_select(collection, :id, label_method), {placeholder: "Select a #{placeholder}", include_blank: true, data: {role: 'select2'}}) +
        if error_class.present?
          message = "You must select a #{field_name}"
          content_tag(:span, message, class: "help-block")
        end
      end
    end
  end
end

