class ApplicationController < Sinatra::Base
	require 'bundler'
	Bundler.require()
	# require './config/environments'
	
  register Sinatra::CrossOrigin

  ActiveRecord::Base.establish_connection(
	    :adapter => 'postgresql',
	    :database => 'shop'
	)

  # ENV['API_KEY']

  use Rack::Session::Cookie,  :key => 'rack.session',
                              :path => '/',
                              :secret => 'secret'

  use Rack::MethodOverride
  set :method_override, true

  # require 'open-uri'

	get '/' do
		{
      success: false,
      message: "Please consult the API documentation"
    }.to_json
	end

	not_found do
    halt 404
  end

  configure do
    enable :cross_origin
  end #cross-origin
  set :allow_origin, :any
  set :allow_methods, [:get, :post,:delete, :put, :options]

  options '*' do
    p "opi"
    response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE'
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  end
end