module ApplicationHelper
  def user_requested?(controller, action, id)
    if params[:controller] == controller && params[:action] == action && params[:id] == id
      true
    end
  end

  def admin_view?
    if request.original_fullpath != '/cloud-computing/us/en/solutions-gaming.html'
      true
    end
  end

  def gaming_scenario?
    if !admin_view?
      true
    end
  end
end
