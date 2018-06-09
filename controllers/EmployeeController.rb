class EmployeeController < ApplicationController

	before do
	    payload_body = request.body.read
	    if(payload_body != "")
	      @payload = JSON.parse(payload_body).symbolize_keys
	    end
	 #    if !session[:logged_in]
	 #      	halt 200, {
	 #        	success: false,
	 #        	message: 'you are not loged in'
	 #      	}.to_json
		# end
	end

	get '/' do
		employees = Employee.all
		{
			success: true,
			employees: employees
		}.to_json
	end


	post '/register' do
	  	employee = Employee.new

	  	employee.name = @payload[:name]
	  	employee.username = @payload[:username]
	  	employee.password = @payload[:password]
	  	employee.manager = @payload[:manager]

	  	employeeExist = Employee.find_by username: employee.username
	  	if employeeExist
	  		{
	  			success: false,
	  			message: "username already taken, try again"
	  		}.to_json
	  	else
		  	employee.save
		  	session[:logged_in] = true
		  	session[:name] = employee.name
		  	session[:username] = employee.username
		  	session[:employee_id] = employee.id
		  	session[:manager] = employee.manager
		  	session[:driver] = false
		  	{
		  		success: true,
		  		user_id: employee.id,
			  	username: employee.username,
			  	manager: employee.manager,
		  		message: 'you are logged in and you have a cookie attached to all the responses'
	  		}.to_json
		end
	  	
	end

	post '/login' do
	  	username = @payload[:username]
	  	password = @payload[:password]
	  	employee = Employee.find_by username: username
	  	if employee && employee.authenticate(password)
	  		session[:logged_in] = true
	  		session[:name] = employee.name
	  		session[:username] = username
	  		session[:employee_id] = employee.id
	  		session[:manager] = employee.manager
		  	session[:driver] = false
		  	{
		  		success: true,
		  		employee_name: employee.name,
		  		employee_id: employee.id,
		  		username: username,
		  		manager: employee.manager,
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

	get '/:id' do
		employee = Employee.find(params[:id])
		{
			success: true,
			employee: employee
		}.to_json
	end
end