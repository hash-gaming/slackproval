module ApplicationHelper

  def errors_for(object)
    if object.errors.any?
      content_tag(:article, class: "message is-danger") do
        concat(content_tag(:div, class: "message-header") do
          concat "#{pluralize(object.errors.count, "error")} prohibited this #{object.class.name.downcase} from being saved:"
        end)
        concat(content_tag(:div, class: "message-body") do
          concat(content_tag(:ul, class: 'mb-0') do
            object.errors.full_messages.each do |msg|
              concat content_tag(:li, msg)
            end
          end)
        end)
      end
    end
  end
end
