class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end
  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:content, :article_id))
    @comment.user_id = @user.id
    @comment.save
    #redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
end
