class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requested_resource, only: [:edit, :update, :destroy]

  def create
    @page = Page.find(params[:page_id])
    @resource = @page.resources.create!(resource_params)
    redirect_to page_path(@page)
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

    redirect_to page_path(@resource.page_id)
  end

  private
  def resource_params
    params.require(:resource).permit(:body, :url)
  end

  def get_requested_resource
    @resource = Resource.find(params[:id])
  end
end
