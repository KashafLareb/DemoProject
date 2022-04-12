class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments.kept
    @discarded_comments = @article.comments.discarded
  end
  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:content, :article_id))
    @comment.user_id = @user.id
    @comment.save
    #redirect_to article_path(@article)
  end

  def undiscard
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.undiscard
    redirect_to article_comments_url(@article), notice: "Comment was successfully recovered."
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    authorize! :destroy, @comment
    if @comment.discarded?
      @comment.destroy
      redirect_to article_comments_url(@article), notice: "Permanently deleted the comment!"
    else
      @comment.discard
      redirect_to article_comments_url(@article), notice: "discarded your comment successfully!"
    end
  end
end
