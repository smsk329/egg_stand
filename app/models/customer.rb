class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :genre_relation

  has_one_attached :customer_image

  def get_customer_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
      customer_image.variant(resize_to_limit: [width, height]).processed
  end

end
