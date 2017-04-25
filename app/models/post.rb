class Post < ApplicationRecord
  belongs_to :usuario
  has_many :attachment
  validates :titulo, presence: true, uniqueness: true
end
