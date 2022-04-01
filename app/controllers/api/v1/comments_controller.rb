class Api::V1::CommentsController < Api::V1::ApiController
  before_action :authenticate
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    render json: @comments, status: :ok
  end
  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:content, :article_id))
    @comment.user_id = @user.id
    if @comment.save
      render json: @comment.content["body"], status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    render json: "Destroyed comment: #{@comment.id} on the article: #{@article.title}", status: :ok
  end
end
