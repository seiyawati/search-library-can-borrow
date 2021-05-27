require_relative '../config'
require_relative 'api_client'

class CalilBookAPIClient < APIClient
  def initialize(isbn, system_id)
    @isbn = isbn
    @system_id = system_id
    @base_url = 'https://api.calil.jp/check'
  end

  private

  def request_parameters
    "?appkey=#{CALIL_API_KEY}&isbn=#{@isbn}&systemid=#{@system_id}&format=json&callback=no"
  end
end
