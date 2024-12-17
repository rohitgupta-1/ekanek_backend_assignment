class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Association with UserFile
  has_many :user_files, dependent: :destroy
end
