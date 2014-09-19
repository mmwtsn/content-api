class ScenariosController < ApplicationController
  respond_to :html, :js

  before_action :authenticate_user!
  before_action :set_solution, only: [:new, :create]
  before_action :set_scenario, only: [:edit, :show, :update, :destroy]

  require "#{Rails.root}/lib/product_api"

  def new
    @scenario = Scenario.new
  end

  def create
    @scenario = @solution.scenarios.create(scenario_params)
  end

  def show
    @product = Product.new
    @products = Scenario.friendly.find(params[:id]).products
  end

  def edit
  end

  def update
    if @scenario.update(scenario_params)
      redirect_to solution_path(@scenario.solution_id)
    else
      render 'edit'
    end
  end

  def destroy
    @scenario.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to solution_path(@scenario.solution_id)}
    end
  end

  private

  def scenario_params
    params.require(:scenario).permit(:name, :quote, :pitch, :avatar, :solution_id)
  end

  def set_solution
    @solution = Solution.friendly.find(params[:solution_id])
  end

  def set_scenario
    @scenario = Scenario.friendly.find(params[:id])
  end
end
