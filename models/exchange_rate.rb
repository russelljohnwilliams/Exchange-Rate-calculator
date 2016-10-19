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
    @from_ccy = options['from']
    @to_ccy = options['to']
  end

  def start()
    url = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
    res = Net::HTTP.get_response(URI.parse(url.to_s))
    if res.code == "200"
      self.get_url_data()
    else
      self.parse_data()
    end
  end

  def get_url_data()
    data = open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml").read
    somefile = File.open("data.xml", "w")
    somefile.write(data)
    somefile.close
    self.parse_data
  end

  def parse_data()
    data = XmlSimple.xml_in('data.xml')
    return data["Cube"][0]["Cube"]
  end

  def get_rate_of_from_ccy()
    @data = self.parse_data()
    cube = @data[@i]["Cube"]
    find_from_index = cube.find{ |element| element["currency"] == @from_ccy}
    int = cube.index(find_from_index)
    from_rate = cube[int]["rate"].to_f
    return from_rate
  end

  def get_rate_of_to_ccy()
    @data = self.parse_data()
    cube = @data[@i]["Cube"]
    find_to_index = cube.find{ |element| element["currency"] == @to_ccy}
    int = cube.index(find_to_index)
    to_rate = cube[int]["rate"].to_f
    return to_rate
  end

  def at()
    from_rate = self.get_rate_of_from_ccy()
    to_rate = self.get_rate_of_to_ccy()

    step_one = @amount / from_rate
    result = step_one * to_rate

    return @amount, @from_ccy, from_rate, @to_ccy, to_rate, result
  end

end