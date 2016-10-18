require ('active_support')
require ('httparty')

class ExchangeRate

  attr_reader(:i, :amount, :from, :to)

  def initialize(options)
    received = HTTParty.get("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
    @data = received["Envelope"]["Cube"]["Cube"]
    
    @i = options['i'].to_i
    @amount = options['amount'].to_f
    @from_ccy = options['from']
    @to_ccy = options['to']
  end
  
  def parse_data()
    return @data
  end

  def get_index_of_from_ccy()
    cube = @data[@i]["Cube"]
    find_from_index = cube.find{ |element| element["currency"] == @from_ccy}
    x = cube.index(find_from_index)
    from_amount = cube[x]["rate"].to_f
    return from_amount
  end

  def get_index_of_to_ccy()
    cube = @data[@i]["Cube"]
    find_to_index = cube.find{ |element| element["currency"] == @to_ccy}
    y = cube.index(find_to_index)
    to_amount = cube[y]["rate"].to_f
    return to_amount
  end

  def at()
    from_amount = self.get_index_of_from_ccy()
    to_amount = self.get_index_of_to_ccy()

    step_one = @amount / from_amount
    step_two = step_one * to_amount

    return "index number: ", @i, "amount to exchange: ", @amount, "currency & rate to exchanghe from: ", @from_ccy, from_amount, "currency & rate to exchanghe to: ", @to_ccy, to_amount, "final exchange rate amount: ", step_two
  end

end