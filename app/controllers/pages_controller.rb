class PagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @page = Page.new
  end
  
  def show
    @pages = Page.all
  end

  def create
    Page.create!(page_params)
    redirect_to pages_path
  end

  private
  def page_params
    params[:page].permit(:title, :body)
  end
end
