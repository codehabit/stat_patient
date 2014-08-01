module PrescriptionOrdersHelper

  def le obj, attr, opts = {}
    content_tag :div, class: 'row rx-print' do 
      content_tag(:div, opts[:label] || attr.to_s.titleize, :class => 'col-sm-4 rx-attr-name') +
      content_tag(:div, obj.send(attr), class: 'col-sm-8')
    end
  end
end
