require('sinatra')
require('sinatra/contrib/all')
require_relative('models/exchange_rate')

get "/test" do
  exchange_rate = ExchangeRate.new(params)
  exchange_rate.get_url_data()
  @data = exchange_rate.parsed_data()
  erb(:test)
end

post '/result' do
  exchange_rate = ExchangeRate.new(params)
  @result = exchange_rate.at()
  erb( :result)
end
