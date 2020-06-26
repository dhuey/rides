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
  scope :international, -> { where(international: true) }

  def self.email_list
    User.international.where(email_interest: true).pluck(:email)
  end

  def driver?
    !international?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def unverified?
    !driver_verified?
  end
end
