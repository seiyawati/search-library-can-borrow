require_relative 'api_client'
require_relative '../config'

class CalilLibraryAPIClient < APIClient
  def initialize(location)
    @location = location
    @base_url = 'https://api.calil.jp/library'
  end

  private

  def request_parameters
    "?appkey=#{CALIL_API_KEY}&geocode=#{@location.longitude},#{@location.latitude}&limit=50&format=json&callback="
  end
end
