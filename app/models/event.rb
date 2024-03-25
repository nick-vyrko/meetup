# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user, optional: false
  has_many :tickets, inverse_of: :event

  validates :name, :total_tickets, :datetime, :latitude, :longitude, presence: true

  scope :upcoming, -> { where(datetime: Time.current..) }
end
