require('sinatra')
require('sinatra/contrib/all')
require_relative('models/exchange_rate')

get "/" do
  exchange_rate = ExchangeRate.new()
  @data = exchange_rate.parse_data()
  erb(:exchange_rate)
end