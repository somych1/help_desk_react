class DriverController < ApplicationController

	before do
	    payload_body = request.body.read
	    if(payload_body != "")
	      @payload = JSON.parse(payload_body).symbolize_keys
	    end
	end

	post '/register' do
	  	driver = Driver.new

	  	driver.name = @payload[:name]
	  	driver.username = @payload[:username]
	  	driver.password = @payload[:password]
	  	driver.truck_num = @payload[:truck_num]
	  	driver.make = @payload[:make]
	  	driver.model = @payload[:model]
	  	driver.year = @payload[:year]

	  	driverExist = Driver.find_by username: driver.username
	  	if driverExist
	  		{
	  			success: false,
	  			message: "username already taken, try again"
	  		}.to_json
	  	else
		  	driver.save
		  	session[:logged_in] = true
		  	session[:name] = driver.name
		  	session[:username] = driver.username
		  	session[:driver_id] = driver.id
		  	session[:truck] = driver.truck_num
		  	session[:make] = driver.make
		  	session[:model] = driver.model
		  	session[:year] = driver.year
		  	session[:driver] = true
		  	{
		  		success: true,
		  		user_id: driver.id,
			  	username: driver.username,
		  		message: 'you are logged in and you have a cookie attached to all the responses'
	  		}.to_json
		end
	  	
	end

	post '/login' do
	  	username = @payload[:username]
	  	password = @payload[:password]
	  	driver = Driver.find_by username: username
	  	if driver && driver.authenticate(password)
	  		session[:logged_in] = true
	  		session[:name] = driver.name
	  		session[:username] = username
	  		session[:employee_id] = driver.id
	  		session[:truck] = driver.truck_num
		  	session[:make] = driver.make
		  	session[:model] = driver.model
		  	session[:year] = driver.year
		  	session[:driver] = true
		  	{
		  		success: true,
		  		driver_name: driver.name,
		  		driver_id: driver.id,
		  		username: username,
		  		message: 'Login succsesful'
		  	}.to_json
	  	else
	  		{
	  			success: false,
	  			message: 'Invalid Username or password'
	  		}.to_json
	  	end
  	end

  	get '/logout' do
	  	session.destroy
	  	{
	  		success: true,
	  		message: "you are logged out"
	  	}.to_json
  	end

  	put '/:id' do
	    driver = Driver.find(params[:id])
	    driver.name = @payload[:name]
	    driver.username = @payload[:username]
	    driver.password = @payload[:password]
	    driver.truck_num = @payload[:truck_num]
	  	driver.make = @payload[:make]
	  	driver.model = @payload[:model]
	  	driver.year = @payload[:year]

	    driverExist = Driver.find_by username: driver.username
	  	if driverExist
	  		{
	  			success: false,
	  			message: "username already taken, try again"
	  		}.to_json
	  	else
		  	driver.save
		  	{
		  		success: true,
		  		message: 'Driver was successfuly updated'
	  		}.to_json
		end

  	end

end