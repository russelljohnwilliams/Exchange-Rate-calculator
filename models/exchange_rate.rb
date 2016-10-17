require ('active_support')
require ('httparty')

class ExchangeRate

  def initialize
    received = HTTParty.get("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
    @data = received["Envelope"]["Cube"]["Cube"]
  end
  
  def parse_data()
    return @data
  end

end