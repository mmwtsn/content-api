class ProductsController < ApplicationController
  respond_to :js

  def create
    @scenario = Scenario.friendly.find(params[:scenario_id])
    @product  = @scenario.products.create(products_params)
    @scenario_name = params[:scenario_id]
  end

  def destroy
    @scenario = Scenario.friendly.find(params[:scenario_id])
    @product  = @scenario.products.find(params[:id])

    @product.destroy
  end

  def search
    @scenario_name = params[:scenario_name]
    @search_query  = params[:product]
    @results       = JSON.generate(ProductAPI.search_products(params[:product]))
  end

  private

  def products_params
    params.permit(:product_id, :name, :description, :icon_url)
  end
end
