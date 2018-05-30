class OrderController < ApplicationController
	
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

	# get all arders
	get '/' do
		if session[:diver]
			@order = Order.where(driver_id: session[:driver_id])
		else
			@order = Order.where(employee_id: session[:employee_id])
		end
		{
			success: true,
			order: @order
		}.to_json
	end

	# new order
	post '/' do
		order = Order.new
		order.title = @payload[:title]

		if session[:diver]
			order.driver_id = session[:driver_id]
		else
			order.employee_id = session[:employee_id]
		end

		# order.comment = @payload[:comment]
		order.description = @payload[:description]
		# order.stating = @payload[:stating]
		# order.ending = @payload[:ending]
		# order.completed = @payload[:completed]
		order.save
		{
			success: true,
			order: order
		}.to_json
	end

	put '/id' do
		order = Order.find(params[:id])
		order.title = @payload[:title]
		order.driver_id = @payload[:driver_id]
		order.employee_id = @payload[:employee_id]
		order.comment = @payload[:comment]
		order.description = @payload[:description]
		# order.starting = @payload[:stating]
		# order.ending = @payload[:ending]
		order.completed = @payload[:completed]
		order.save
	end

	delete '/id' do
		order = Order.find(params[:id])
		order.destroy
		{
			success: true,
			message: 'order destroyed'
		}.to_json
	end




end