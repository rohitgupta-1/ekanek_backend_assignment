class UserFile < ApplicationRecord
  belongs_to :user
  has_one_attached :uploaded_file

  validates :title, :uploaded_file, presence: true
end
