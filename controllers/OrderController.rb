class OrderController < ApplicationController
	
	before do
	    payload_body = request.body.read
	    if(payload_body != "")
	      	@payload = JSON.parse(payload_body).symbolize_keys
	    end

	    if !session[:logged_in]
	      	halt 200, {
	        	success: false,
	        	message: 'you are not loged in'
	      	}.to_json
		end
	end

	# get all orders
	get '/' do
		# binding.pry
		if session[:driver]
			order = Order.where(driver_id: session[:driver_id])
		elsif session[:manager]
			order = Order.all
		else 
			order = Order.where(employee_id: session[:employee_id])
		end
		{
			success: true,
			order: order
		}.to_json
	end

	# orders by emploee id
	get '/employee/:employee_id' do
		orders = Order.where(employee_id: params[:employee_id])
		{
			success: true,
			orders: orders
		}.to_json
	end

	# order detail
	get '/:id' do
		order = Order.find(params[:id])
		{
			success: true,
			order: order
		}.to_json
	end

	# new order
	post '/' do
		# binding.pry
		order = Order.new
		order.title = @payload[:title]

		if session[:manager]
			order.driver_id = session[:driver_id]
			order.employee_id = @payload[:employee_id]
		else
			order.driver_id = session[:driver_id]
		end
		order.comment = @payload[:comment]
		order.description = @payload[:description]
		order.completed = @payload[:completed]
		# order.stating = @payload[:stating]
		# order.ending = @payload[:ending]
		order.save
		{
			success: true,
			order: order
		}.to_json
	end

	put '/:id' do
		order = Order.find(params[:id])
		if session[:manager]
			order.description = @payload[:description]
			order.employee_id = @payload[:employee_id]
		end
		order.comment = @payload[:comment]
		order.completed = @payload[:completed]
		employee = order.employee_id
		if employee === nil
			{
				success: false,
				message: 'Choose Employee'
			}.to_json
		else
			order.save
			{
				success: true,
				order: order
			}.to_json
		end
	end

	delete '/:id' do
		order = Order.find(params[:id])
		order.destroy
		{
			success: true,
			message: 'order destroyed'
		}.to_json
	end




end