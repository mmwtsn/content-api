module ApplicationHelper

  def format_icon_url(url)
    if url =~ /http/
      sanitized_url = url
    else
      sanitized_url = "http://ibm.com#{url}"
    end

    return sanitized_url
  end

  def model_name(object)
    object.class.name.downcase
  end

  def new_object_path(object, parent_object)
    case object
    when 'solution'
      new_solution_path
    when 'scenario'
      new_solution_scenario_path(parent_object)
    when 'resource'
      new_solution_resource_path(parent_object)
    else
      raise "Helper new_object_path does not accept object '#{object}'"
    end
  end

  def container_class
    if edit?
      'card_container'
    end
  end

  def parent_form
    if new?
      '.new_scenario'
    elsif edit?
      '.edit_scenario'
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
