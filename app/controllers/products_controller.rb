class ProductsController < ApplicationController
  def create
    @scenario = Scenario.friendly.find(params[:scenario_id])
    @product = @scenario.products.create(products_params)
    @products = Product.all

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @scenario = Scenario.find(params[:scenario_id])
    @product = @scenario.products.find(params[:id])

    @product.destroy

    respond_to do |format|
      format.js {render nothing: true}
    end
  end

  def search
    @scenario_name = params[:scenario_name]
    @results = JSON.generate(ProductAPI.search_products(params[:product]))

    respond_to do |format|
      format.js
    end
  end

  private

  def products_params
    params.permit(:product_id, :name, :description, :icon_url)
  end
end
