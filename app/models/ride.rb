class Ride < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :driver, class_name: "User", foreign_key: :driver_id, optional: true

  scope :unclaimed, -> { where(claimed: false) }
  scope :incomplete, -> { where(completed: false) }

  def create_with_requester(user)
    self.requester_id= user.id
    self.requester_gender= user.gender
    self.requested_at= DateTime.now
    return false unless self.save
    true
  end

  def unclaimed?
    claimed == false
  end

  def incomplete?
    completed == false
  end

  def formatted_pickup_time
    self.pickup_time.strftime("%b %d, %Y at %l:%M %P")
  end

  def short_pickup_time
    self.pickup_time.strftime("%m/%d at %l:%M %P")
  end
end