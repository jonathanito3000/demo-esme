class Post < ApplicationRecord
  belongs_to :usuario
  validates :titulo, presence: true, uniqueness: true
end
