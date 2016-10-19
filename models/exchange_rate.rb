require ('active_support')
require ('httparty')

class ExchangeRate

  attr_reader(:i, :amount, :from, :to)

  def initialize(options)
    @i = options['i'].to_i
    @amount = options['amount'].to_f
    @from_ccy = options['from']
    @to_ccy = options['to']
  end

  def parse_data()
    received = HTTParty.get("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
    data = received["Envelope"]["Cube"]["Cube"]
    return data
  end

  def parsed_data()
    data = self.parse_data()
    return data
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