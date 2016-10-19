require ('httparty')
require ('xmlsimple')
require ('open-uri')
require ('net/http')

class ExchangeRate

  attr_reader(:i, :amount, :from, :to)

  def initialize(options)
    @i = options['i'].to_i
    @amount = options['amount'].to_f
    @from_currency = options['from']
    @to_currency = options['to']
  end

  def start()
    url = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
    response = Net::HTTP.get_response(URI.parse(url.to_s))
    if response.code == "200"
      self.get_xr_data()
    else
      self.parse_data()
    end
  end

  def get_xr_data()
    data = open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml").read
    local_file = File.open("data.xml", "w")
    local_file.write(data)
    local_file.close
    self.parse_data
  end

  def parse_data()
    local_file = XmlSimple.xml_in('data.xml')
    return local_file["Cube"][0]["Cube"]
  end

  def find_currency_rate(currency)
    @data = self.parse_data()
    cube = @data[@i]["Cube"]
    index_num = cube.find{ |element| element["currency"] == currency}
    i = cube.index(index_num)
    rate = cube[i]["rate"].to_f
    return rate
  end

  def calculate_rate()
    from_rate = self.find_currency_rate(@from_currency)
    to_rate = self.find_currency_rate(@to_currency)
    step_one = @amount / from_rate
    result = step_one * to_rate
    return @amount, @from_currency, @to_currency, result
  end

end