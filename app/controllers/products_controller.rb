class ProductsController < ApplicationController
  def create
    @scenario = Scenario.find(params[:scenario_id])
    @product = @scenario.products.create(products_params)

    redirect_to scenario_path(@scenario)
  end

  def destroy
    @scenario = Scenario.find(params[:scenario_id])
    @product = @scenario.products.find(params[:id])

    @product.destroy
    redirect_to scenario_path(@scenario)
  end

  def search
    @products = ProductAPI.search_products(params[:product])

    respond_to do |format|
      format.js
    end
  end

  private

  def products_params
    params.require(:product).permit(:product_id)
  end
end
