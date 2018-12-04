class Requestor < ApplicationRecord
  has_many :service_requests
  has_many :users, through: :service_requests
end
