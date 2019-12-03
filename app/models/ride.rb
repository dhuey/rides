class Ride < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :driver, class_name: "User", foreign_key: :driver_id, optional: true

  def create_with_requester(user)
    self.requester_id= user.id
    self.requested_at= DateTime.now
    return false unless self.save
    true
  end
end