class Ride < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :driver, class_name: "User", foreign_key: :driver_id, optional: true
end