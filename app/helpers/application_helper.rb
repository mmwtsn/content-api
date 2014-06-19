module ApplicationHelper
  def user_requested?(controller, action, id)
    if params[:controller] == controller && params[:action] == action && params[:id] == id
      true
    end
  end

  def admin
    if request.original_fullpath != '/cloud-computing/us/en/solutions-gaming.html'
      true
    end
  end

  def preview
    if request.original_fullpath == '/cloud-computing/us/en/solutions-gaming.html'
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
