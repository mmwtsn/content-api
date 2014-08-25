module ApplicationHelper

  def format_icon_url(url)
    if url =~ /http/
      sanitized_url = url
    else
      sanitized_url = "http://ibm.com#{url}"
    end

    return sanitized_url
  end

  def container_class
    if edit?
      'card-container'
    end
  end

  def new?
    if action_name == 'new'
      true
    end
  end

  def edit?
    if action_name == 'edit'
      true
    end
  end
end
