require('sinatra')
require('sinatra/contrib/all')
require_relative('models/exchange_rate')

get "/" do
  exchange_rate = ExchangeRate.new(params)
  # exchange_rate.get_url_data()
  # @data = exchange_rate.parsed_data()
  @data = exchange_rate.start()
  erb(:exchange_rate)
end

post '/result' do
  exchange_rate = ExchangeRate.new(params)
  @result = exchange_rate.at()
  erb( :result)
end
