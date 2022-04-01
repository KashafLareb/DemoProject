class Article < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_rich_text :content
  validates :title, presence: true, uniqueness: true, length: { in: 5..30 }

  def total_likes
    likes.count
  end

  def liking_users
    self.likes.map { |like| {Liked_by: User.find(like.user_id).email,
                             At: like.created_at.to_formatted_s(:short) } }
  end

  def total_comments
    comments.count
  end

  def all_comments
    self.comments.map { |comment| {Comment: comment.content["body"],
                                   By: User.find(comment.user_id).email, 
                                   At: comment.created_at.to_formatted_s(:short)} }
  end
  
end
