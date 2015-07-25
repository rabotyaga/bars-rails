module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type.to_sym
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-warning"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def include_analytics
    return '' unless Rails.env.production?
    return render 'layouts/analytics'
  end

  def include_metrika
    return '' unless Rails.env.production?
    return render 'layouts/metrika'
  end
end
