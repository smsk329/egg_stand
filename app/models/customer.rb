class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :genre_relations

  has_one_attached :customer_image

  def get_customer_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
      customer_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    # ゲストログイン時にemailを基準に探す。該当するemailがなければ作成する。
    find_or_create_by!(email: 'guest@test.com', name: 'guest') do |customer|
      # ゲストユーザーにはパスワードをランダムに付与する
      customer.password = SecureRandom.urlsafe_base64
    end
  end

end
