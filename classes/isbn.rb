require_relative 'google_book_api_client'
require_relative '../exceptions/exceptions'

class Isbn
  include Exceptions

  attr_reader :value

  def self.generated_from(book_name)
    results = GoogleBookAPIClient.new(book_name).get_request
    raise GoogleBookAPIError, '対象の本の情報を取得できませんでした。' if results['totalItems'] == 0

    new(
      results['items'][0]['volumeInfo']['industryIdentifiers'][0]['identifier']
    )
  end

  def initialize(value)
    @value = value
  end
end
