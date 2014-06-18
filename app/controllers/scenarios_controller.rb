class ScenariosController < ApplicationController
  require "#{Rails.root}/lib/product_api"

  before_action :authenticate_user!
  before_action :build_page, only: [:new, :create]
  before_action :build_scenario, only: [:edit, :show, :update, :destroy]

  def new
    @scenario = Scenario.new
  end

  def create
    @scneario = Scenario.new(scenario_params)

    if @scneario.save
      redirect_to page_path(@page)
    else
      render 'new'
    end
  end

  def show
    @products = ProductAPI.fetch_products
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
    redirect_to page_path(@scenario.page_id)
  end

  private

  def scenario_params
    params.require(:scenario).permit(:quote, :pitch, :avatar, :page_id)
  end

  def build_page
    @page = Page.find(params[:page_id])
  end

  def build_scenario
    @scenario = Scenario.find(params[:id])
  end
end
