class PagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @page = Page.new
  end
  
  def show
    @pages = Page.all
  end

  def create
    Page.create!(params[:page].permit(:title, :body))
    redirect_to pages_path
  end
end
