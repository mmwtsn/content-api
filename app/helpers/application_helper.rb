module ApplicationHelper

  def format_icon_url(url)
    if url =~ /http/
      sanitized_url = url
    else
      sanitized_url = "http://ibm.com#{url}"
    end

    return sanitized_url
  end

  def id_selector(object)
    make_id(dom_id(object))
  end

  def collection_class_selector(object)
    make_class(dom_class(object).pluralize)
  end

  def class_selector(object)
    make_class(dom_class(object))
  end

  def individual_resource_selector(object)
    if object.class == Product
      "#{products_container_class(object.scenario)} .product"
    else
      "#{collection_class_selector(object)} #{class_selector(object)}.card"
    end
  end

  def make_class(string)
    ".#{string}"
  end

  def make_id(string)
    "##{string}"
  end

  def products_container(scenario)
    "products #{scenario.name.parameterize}-products"
  end

  # TODO - I'm rushing, this is a mess.

  def products_container_class(scenario)
    make_class(products_container(scenario).split(' ').join('.'))
  end

  def show_new_resource_selector(object)
    ".show_#{dom_id(object.class.new)}"
  end

  def new_resource_wrapper(object)
    ".new_#{object.class.to_s.parameterize}_wrapper"
  end

  def plural_resource_name(object)
    object.class.to_s.pluralize.downcase
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
