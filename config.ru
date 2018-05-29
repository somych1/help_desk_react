require 'sinatra/base'
require 'sinatra/activerecord'

# controllers
require './controllers/ApplicationController'
require './controllers/EmployeeController'
require './controllers/DriverController'
require './controllers/OrderController'

# models
require './models/EmployeeModel'
require './models/DriverModel'
require './models/OrderModel'




# routes
map ('/'){
	run ApplicationController
}

map ('/emp'){
	run EmployeeController
}

map ('/driver'){
	run DriverController
}

map ('/orders'){
	run OrderController
}