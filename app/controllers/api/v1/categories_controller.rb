class Api::V1::CategoriesController < Api::V1::ApiController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate
  # GET /categories or /categories.json
  def index
    @categories = Category.all
    render json: @categories, status: :ok
  end

  # GET /categories/1 or /categories/1.json
  def show
    render json: @category, status: :ok
  end

  # GET /categories/new
  def new
    authorize! :create, @category
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    authorize! :update, @category
  end

  # POST /categories or /categories.json
  def create
    authorize! :create, @category
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    authorize! :update, @category
    if @category.update(category_params)
        render json: @category, status: :ok 
    else
      render json: @category.errors, status: :unprocessable_entity 
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    authorize! :destroy, @category
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:category_name, :description)
    end
end
