class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_requested_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
  end

  def create
    Page.create!(page_params)
    redirect_to pages_path
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def show
  end

  def update
    if @page.update(page_params)
      redirect_to @page
    else
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

  private
  def page_params
    params[:page].permit(:title, :body, :header, :published)
  end

  def get_requested_page
    @page = Page.find(params[:id])
  end
end
