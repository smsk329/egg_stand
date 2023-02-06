class Shop < ApplicationRecord
  has_one_attached :shop_image
  belongs_to :customer

  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      shop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      shop_image.variant(resize_to_limit: [width, height]).processed
  end

end
