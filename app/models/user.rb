# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :events, inverse_of: :user
  has_many :tickets, inverse_of: :user

  validates :name, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
