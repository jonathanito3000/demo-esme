class Friendship < ApplicationRecord
  belongs_to :usuario
  belongs_to :friend, class_name: "Usuario"
end
