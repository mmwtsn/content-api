class ScenariosController < ApplicationController
  respond_to :js

  before_action :authenticate_user!
  before_action :set_solution, only: [:new, :create]
  before_action :set_scenario, only: [:edit, :update, :destroy]

  require "#{Rails.root}/lib/product_api"

  def new
    @scenario = Scenario.new
  end

  def create
    @scenario = @solution.scenarios.create(scenario_params)
  end

  def edit
  end

  def update
    @scenario.update(scenario_params)
  end

  def destroy
    @scenario.destroy
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
