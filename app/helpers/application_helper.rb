# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success
      'alert-success'
    when :error
      'alert-danger'
    when :alert
      'alert-warning'
    when :notice
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def include_analytics
    return '' unless Rails.env.production?
    render 'layouts/analytics'
  end

  def include_metrika
    return '' unless Rails.env.production?
    render 'layouts/metrika'
  end

  def bidiWrap(string, ltr)
    if ltr
      "\u202A" + string + "\u202C"
    else
      "\u202B" + string + "\u202C"
    end
  end
end
