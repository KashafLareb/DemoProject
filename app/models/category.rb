class Category < ApplicationRecord
  has_many :articles, dependent: :destroy
  validates :category_name,
                  presence: true, 
                  uniqueness: true,
                  length: { in: 5..25 }
  validates :description, 
                  presence: true, 
                  uniqueness: true, 
                  length: { in: 6..80 }

  def to_s
    self.category_name
  end
  
end
