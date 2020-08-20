class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  has_many :vehicles, dependent: :destroy

  validates :first_name, :last_name, :phone_number, :gender, presence: true, if: :active?
  validates :email, presence: true, uniqueness: true
  validates :phone_number, uniqueness: true, if: :active?
  validates :nationality, presence: true, if: :international_and_active?
  validates :ministry, presence: true, if: :driver_and_active?
  validate :accepted_tac
  validate :valid_driver_check

  scope :driver, -> { where(international: false) }
  scope :international, -> { where(international: true) }
  scope :unverified, -> { where(driver_verified: false) }

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

  def active?
    status == 'active'
  end

  def international_and_active?
    self.international? && self.active?
  end

  def driver_and_active?
    self.driver? && self.active?
  end

  def accepted_tac
    if self.active?
      unless self.accept_tac == true
        errors.add(:base, "You must accept the terms and conditions")
      end
    end
  end

  def valid_driver_check
    if self.active? && self.driver?
      unless self.valid_driver == true
        errors.add(:base, "You must certify that you have a valid driver's license and insurance")
      end
    end
  end

  def signup_completed?
    unless self.first_name? && self.last_name? && self.phone_number?
      return false
    end
    if self.international?
      unless self.nationality?
        return false
      end
    else
      unless self.ministry?
        return false
      end
    end
    true
  end
end
