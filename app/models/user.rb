# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
