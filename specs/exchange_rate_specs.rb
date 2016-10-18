require('minitest/autorun')
require_relative('../models/exchange_rate')

class TestExchangeRate < MiniTest::Test

  def setup
    @exchange_rate = ExchangeRate.new(0, 5, 1, 2)
    assert_equal(10, @exchange_rate.at())
  end

end