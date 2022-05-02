class LikesController < ApplicationController
  
  def create
    if current_user == nil
      flash[:alert] = "You need to sign in for liking an article!"
      redirect_to article_path(params[:article_id])
    elsif already_liked?
      @like = Like.where(user_id: current_user.id, article_id: @article.id)
      @like.destroy_all
    else
      @article = Article.find(params[:article_id])
      @like = Like.create
      @like.article_id=@article.id
      @like.user_id=current_user.id
      @like.save
      
    end
  end
  def already_liked?
    @article = Article.find(params[:article_id])
    Like.where(user_id: current_user.id, article_id: @article.id).exists?
  end
end
