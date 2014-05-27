class ScenariosController < ApplicationController
  def create
    @page = Page.find(params[:page_id])
    @scenario = @page.scenarios.create(scenario_params)
    redirect_to page_path(@page)
  end

  private
  def scenario_params
    params.require(:scenario).permit(:quote, :pitch)
  end
end
