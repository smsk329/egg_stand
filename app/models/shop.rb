class Shop < ApplicationRecord
  has_one_attached :shop_image
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :genre_relations, dependent: :destroy
  has_many :genres, through: :genre_relations
  
  validates :title, presence: true
  validates :body, presence: true,length:{maximum:200}
  validates :open_time, presence: true
  validates :close_time, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :holiday, presence: true
  validates :mood, presence: true

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

# ransackで検索するカラムを指定
  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

end
