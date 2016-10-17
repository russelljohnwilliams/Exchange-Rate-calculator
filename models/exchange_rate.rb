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

  def exchange_rate(params)
    i = params["index_number"].to_i
    amount = params["amount"].to_f
    from_ccy = params["from"]
    to_ccy = params ["to"]
    cube = @data[i]["Cube"]


    find_from_index = cube.find{ |element| element["currency"] == from_ccy}
    x = cube.index(find_from_index)
    from_amount = cube[x]["rate"].to_f

    find_to_index = cube.find{ |element| element["currency"] == to_ccy}
    y = cube.index(find_to_index)
    to_amount = cube[y]["rate"].to_f


    # cube.each { |element|  currency = element["currency"] }

    return "index number: ", i, "amount to exchange: ", amount, "currency & rate to exchanghe from: ", from_ccy, from_amount, "currency & rate to exchanghe to: ", to_ccy, to_amount
  end

end