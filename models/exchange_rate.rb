# require ('active_support')
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
    res = Net::HTTP.get_response(URI.parse(url.to_s))
    if res.code == "200"
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

  def from_currency_rate()
    @data = self.parse_data()
    cube = @data[@i]["Cube"]
    from_index_num = cube.find{ |element| element["currency"] == @from_currency}
    int = cube.index(from_index_num)
    from_rate = cube[int]["rate"].to_f
    return from_rate
  end

  def to_currency_rate()
    @data = self.parse_data()
    cube = @data[@i]["Cube"]
    to_index_num = cube.find{ |element| element["currency"] == @to_currency}
    int = cube.index(to_index_num)
    to_rate = cube[int]["rate"].to_f
    return to_rate
  end

  def calculate_rate()
    from_rate = self.from_currency_rate()
    to_rate = self.to_currency_rate()

    step_one = @amount / from_rate
    result = step_one * to_rate

    return @amount, @from_currency, from_rate, @to_currency, to_rate, result
  end

end