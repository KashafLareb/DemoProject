class User < ApplicationRecord
  has_many :comments
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return nil unless user.present?
    user.valid_password?(password) ? user : nil
  end
  
end
