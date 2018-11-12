class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages

  has_many :user_locations

  has_many :locations, through: :user_locations

  has_many :service_request_users
  has_many :service_requests, through: :service_request_users

  has_many :requestors, through: :service_requests
end
