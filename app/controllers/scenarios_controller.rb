class ScenariosController < ApplicationController
  def create
    @page = Page.find(params[:page_id])
    @scenario = @page.scenarios.create(scenario_params)
    redirect_to page_path(@page)
  end

  def edit
    @scenario = Scenario.find(params[:id])
  end

  def update
    @scenario = Scenario.find(params[:id])

    if @scenario.update(scenario_params)
      redirect_to page_path(@scenario.page_id)
    else
      render 'edit'
    end
  end

  def destroy
    @scenario = Scenario.find(params[:id])
    @scenario.destroy

    redirect_to page_path(@scenario.page_id)
  end

  private
  def scenario_params
    params.require(:scenario).permit(:quote, :pitch)
  end
end
