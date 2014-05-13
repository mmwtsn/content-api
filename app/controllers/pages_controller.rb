class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    Page.create!(page_params)
    redirect_to pages_path
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update(page_params)
      redirect_to @page
    else
      render 'edit'
    end
  end

  private
  def page_params
    params[:page].permit(:title, :body)
  end
end
