module ApplicationHelper
  def user_requested?(controller, action, id)
    if params[:controller] == controller && params[:action] == action && params[:id] == id
      true
    end
  end

  def gaming_scenario?
    if user_requested?('pages', 'show', 1)
      true
    end
  end

  def admin_view?
    if params[:controller] == 'pages'
      true
    end
  end
end
