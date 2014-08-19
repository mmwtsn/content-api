class ScenariosController < ApplicationController
  before_action :authenticate_user!
  before_action :build_page, only: [:create]
  before_action :build_scenario, only: [:edit, :show, :update, :destroy]

  require "#{Rails.root}/lib/product_api"

  def create
    @page = Page.find(params[:page_id])
    @scenario = @page.scenarios.create!(scenario_params)

    respond_to do |format|
      format.js
      format.html { redirect_to page_path(@page) }
    end
  end

  def show
    @product = Product.new
    @products = Scenario.friendly.find(params[:id]).products
  end

  def edit
  end

  def update
    if @scenario.update(scenario_params)
      redirect_to page_path(@scenario.page_id)
    else
      render 'edit'
    end
  end

  def destroy
    @scenario.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to page_path(@scenario.page_id)}
    end
  end

  private

  def scenario_params
    params.require(:scenario).permit(:name, :quote, :pitch, :avatar, :page_id)
  end

  def build_page
    @page = Page.friendly.find(params[:page_id])
  end

  def build_scenario
    @scenario = Scenario.friendly.find(params[:id])
  end
end
