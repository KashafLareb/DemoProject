class Api::V1::ArticlesController < Api::V1::ApiController
  before_action :set_article, only: %i[ show edit update destroy ]
  #before_action :authenticate_user!
  before_action :authenticate

  # GET /articles or /articles.json
  def index
    @articles = Article.all
    render json: @articles, status: :ok
  end

  # GET /articles/1 or /articles/1.json
  def show
    render json: @article, status: :ok
  end

  # GET /articles/new
  def new
    authorize! :create, @article
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    authorize! :update, @article
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :category_id)
    end
end