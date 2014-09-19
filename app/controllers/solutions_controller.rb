class SolutionsController < ApplicationController
  respond_to :html, :js

  before_action :authenticate_user!, except: [:preview]
  before_action :set_solution, only: [:show, :preview, :edit, :update, :destroy]

  def index
    @solutions = Solution.order(id: :desc).all
  end

  def new
    @solution = Solution.new
  end

  def create
    @solution = Solution.create(solution_params)
  end

  def edit
  end

  def show
  end

  def preview
    # TODO - This creeped in from a feature prototype; it needs refactoring
    solution  = @solution
    resources = solution.resources
    scenarios = solution.scenarios
    products  = []

    scenarios.each do |scenario|
      scenario.products.each do |product|
        products << product
      end
    end

    data = {
      'solution'  => solution,
      'resources' => resources,
      'scenarios' => scenarios,
      'products'  => products,
    }

    respond_to do |format|
      format.html { render layout: 'preview' }
      format.json { render json: data }
    end
  end

  def update
    @solution.update(solution_params)
  end

  def destroy
    @solution.destroy
    redirect_to Solutions_path
  end

  private
  def solution_params
    params[:Solution].permit(:name, :title, :body, :header, :published)
  end

  def set_solution
    @solution = Solution.friendly.find(params[:id])
  end
end
