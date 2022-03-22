class Category < ApplicationRecord
  has_many :articles, dependent: :destroy

  def to_s
    self.category_name
  end

end
