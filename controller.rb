require('sinatra')
require('sinatra/contrib/all')
require_relative('models/exchange_rate')

get "/" do
  @test = "Hello World!"
  erb(:exchange_rate)
end