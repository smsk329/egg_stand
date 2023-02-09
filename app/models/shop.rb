class Shop < ApplicationRecord
  has_one_attached :shop_image
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :genre_relations

  enum mood: { quiet: 0, active: 1 }

  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      shop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      shop_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end
