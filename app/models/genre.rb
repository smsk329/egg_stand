class Genre < ApplicationRecord
  has_many :genre_relations, dependent: :destroy
  has_many :shops, through: :genre_relations
end
