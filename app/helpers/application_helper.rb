# frozen_string_literal: true

module ApplicationHelper
  def active_link_to(text = nil, path = nil, **options, &)
    path ||= text

    options[:class] = 'inactive-link'
    options[:class] = class_names(options[:class], options[:active_class] || 'active-link') if current_page?(
      path, check_parameters: false
    ) || (options[:optional_path] && current_page?(options[:optional_path], check_parameters: false))
    return link_to(path, options, &) if block_given?

    link_to text, path, options
  end
end
