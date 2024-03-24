# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :event, optional: false
  belongs_to :user, optional: false
end
