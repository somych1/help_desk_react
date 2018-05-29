class Driver < ActiveRecord::Base
	has_many :orders
	has_many :employees, through: :orders
	has_secure_password
end