require ('active_support')
require ('httparty')

class ExchangeRate

  def parse_data()
    @data = HTTParty.get("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
    return @data
  end

end