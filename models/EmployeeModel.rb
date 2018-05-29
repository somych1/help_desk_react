class Employee  < ActiveRecord::Base
	has_many :orders
	has_many :drivers, through: :orders
	has_secure_password
end