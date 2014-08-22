class PagesController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!, except: [:preview]
  before_action :get_requested_page, only: [:show, :preview, :edit, :update, :destroy]

  def index
    @pages = Page.order(id: :desc).all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.create(page_params)
  end

  def edit
  end

  def show
  end

  def preview
    # TODO - This creeped in from a feature prototype; it needs refactoring
    solution  = @page
    resources = solution.resources
    scenarios = solution.scenarios
    products  = []

    scenarios.each do |scenario|
      scenario.products.each do |product|
        products << product
      end
    end

    data = {
      'solution'  => solution,
      'resources' => resources,
      'scenarios' => scenarios,
      'products'  => products,
    }

    respond_to do |format|
      format.html { render layout: 'preview' }
      format.json { render json: data }
    end
  end

  def update
    @page.update(page_params)
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

  private
  def page_params
    params[:page].permit(:name, :title, :body, :header, :published)
  end

  def get_requested_page
    @page = Page.friendly.find(params[:id])
  end
end
