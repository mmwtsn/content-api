class ProductsController < ApplicationController
  def create
    @scenario = Scenario.find(params[:scenario_id])
    @product = @scenario.products.create(products_params)

    redirect_to scenario_path(@scenario)
  end

  private

  def products_params
    params.require(:product).permit(:product_id)
  end
end
