require( 'minitest/autorun' )
require_relative( '../models/exchange_rate' )

class TestExchangeRate < MiniTest::Test

  def setup
    options = {
      'i' => "0",
      'amount' => "10",
      'from_ccy' => "GBP",
      'to_ccy' => "USD"
    }

    @exchange_rate = ExchangeRate.new(options)

    # }

    # @exchange_rate = ExchangeRate.new( options )
  end

  def test_Exchange_rate_calculation()
    amount = 5
    from_rate = 2
    to_rate = 4
    assert_equal( 10 , @exchange_rate.at() )
  end
    

end    
