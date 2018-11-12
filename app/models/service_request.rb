class ServiceRequest < ApplicationRecord
has_many :service_request_users
has_many :users, through: :service_request_users
belongs_to :requestor
end
