class Ride < ApplicationRecord
  belongs_to :requester, class_name: "User", foreign_key: :requester_id
  belongs_to :driver, class_name: "User", foreign_key: :driver_id, optional: true
  belongs_to :vehicle, foreign_key: :vehicle_id, required: false

  scope :unclaimed, -> { where(claimed: false) }
  scope :incomplete, -> { where(completed: false) }
  scope :unarchived, -> { where(archived_at: nil) }

  validate :pickup_time_cannot_be_in_the_past
  validates :origin, :destination, :pickup_time, :number_of_passengers, presence: true

  after_update :send_claimed_email
  after_update :send_archived_email, if: :saved_change_to_archived_at?
  after_update :send_completed_emails, if: :saved_change_to_completed?

  def send_claimed_email
    if saved_change_to_claimed?
      if claimed == true
        RidesMailer.ride_claimed_email(self).deliver_later
        self.schedule_ride_incomplete_email
      else
        RidesMailer.ride_unclaimed_email(self).deliver_later
      end
    end
  end

  def send_archived_email
    unless archived_at == nil
      RidesMailer.archived_ride_email(self).deliver_later
    end
  end

  def send_completed_emails
    unless completed == false
      RidesMailer.driver_completed_email(self).deliver_later
      RidesMailer.requester_completed_email(self).deliver_later
    end
  end

  def pickup_time_cannot_be_in_the_past
    unless claimed_changed? || completed_changed? || archived_at_changed?
      if pickup_time.present? && pickup_time < DateTime.current
        errors.add(:pickup_time, "can't be in the past")
      end
    end
  end

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

  def archived?
    archived_at != nil
  end

  def unarchived?
    archived_at == nil
  end

  def schedule_ride_incomplete_email
    if self.completed==false
      RidesMailer.ride_incomplete_email(self).deliver_later
    end
  end
  handle_asynchronously :schedule_ride_incomplete_email, :run_at => Proc.new {|ride| ride.pickup_time + 24.hours}, :queue => "ride_incomplete_email"
end