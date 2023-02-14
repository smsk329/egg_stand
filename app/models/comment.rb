class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :shop

  validates :post_comment, presence: true, length:{maximum:200}
end
