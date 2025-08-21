class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blog_posts, dependent: :destroy
  
  # Admin functionality
  scope :admins, -> { where(admin: true) }
  scope :non_admins, -> { where(admin: false) }
  
  def admin?
    admin
  end
  
  def make_admin!
    update!(admin: true)
  end
  
  def revoke_admin!
    update!(admin: false)
  end
end
