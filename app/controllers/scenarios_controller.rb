class ScenariosController < ApplicationController
  before_action :get_requested_scenario, only: [:edit, :update, :destroy]

  def create
    @page = Page.find(params[:page_id])
    @scenario = @page.scenarios.create(scenario_params)
    redirect_to page_path(@page)
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
    params.require(:scenario).permit(:quote, :pitch)
  end

  def get_requested_scenario
    @scenario = Scenario.find(params[:id])
  end
end
