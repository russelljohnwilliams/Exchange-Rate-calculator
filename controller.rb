require('sinatra')
require('sinatra/contrib/all')
require_relative('models/exchange_rate')

get "/" do
  exchange_rate = ExchangeRate.new(params)
  @data = exchange_rate.parse_data()
  erb(:exchange_rate)
end

post '/result' do
  exchange_rate = ExchangeRate.new(params)
  @result = exchange_rate.at()
  erb( :result)
end
