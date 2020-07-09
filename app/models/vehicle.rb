class Vehicle < ApplicationRecord
  def easy_name
    "#{self.year} #{self.color} #{self.make} #{self.model}"
  end
end
