class Comment < ApplicationRecord
  include Discard::Model
  belongs_to :article
  belongs_to :user
  has_rich_text :content
  validates :content, presence: true, length: { minimum: 5 }

  def to_s
    self.content
  end
  
end
