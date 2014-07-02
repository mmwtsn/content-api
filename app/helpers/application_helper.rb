module ApplicationHelper
  def user_requested?(controller, action, id)
    if params[:controller] == controller && params[:action] == action && params[:id] == id
      true
    end
  end
  def preview
    if params[:controller] == 'pages' && params[:action] == 'preview'
      true
    end
  end

  def admin
    unless preview
      true
    end
  end

  def format_icon_url(url)
    if url =~ /http/
      sanitized_url = url
    else
      sanitized_url = "http://ibm.com#{url}"
    end

    return sanitized_url
  end
end
