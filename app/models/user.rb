class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true

  validates :email, uniqueness: true
  validates :phone_number, uniqueness: true
  validates :nationality, presence: true, if: :international?

  scope :driver, -> { where(international: false) }

  def driver?
    !international?
  end
end
