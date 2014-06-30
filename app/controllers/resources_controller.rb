class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requested_resource, only: [:edit, :update, :destroy]

  def create
    @page = Page.find(params[:page_id])
    @resource = @page.resources.create!(resource_params)

    respond_to do |format|
      format.js
      format.html { redirect_to page_path(@page) }
    end
  end

  def edit
  end

  def update
    if @resource.update(resource_params)
      redirect_to page_path(@resource.page_id)
    else
      render 'edit'
    end
  end

  def destroy
    @resource.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to page_path(@resource.page_id) }
    end
  end

  private
  def resource_params
    params.require(:resource).permit(:body, :url)
  end

  def get_requested_resource
    @resource = Resource.find(params[:id])
  end
end
