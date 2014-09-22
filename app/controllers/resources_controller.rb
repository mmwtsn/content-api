class ResourcesController < ApplicationController
  respond_to :html, :js

  before_action :authenticate_user!
  before_action :set_solution, only: [:new, :create]
  before_action :set_resource, only: [:edit, :update, :destroy]

  def new
    @resource = Resource.new
  end

  def create
    @resource = @solution.resources.create!(resource_params)

    respond_to do |format|
      format.js
      format.html { redirect_to solution_path(@solution) }
    end
  end

  def edit
  end

  def update
    @resource.update(resource_params)
  end

  def destroy
    @resource.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to solution_path(@resource.solution_id) }
    end
  end

  private
  def resource_params
    params.require(:resource).permit(:body, :url)
  end

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def set_solution
    @solution = Solution.friendly.find(params[:solution_id])
  end
end
