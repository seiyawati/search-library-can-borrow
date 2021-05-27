require_relative 'api_client'

class GoogleBookAPIClient < APIClient
  def initialize(book_name)
    @book_name = book_name
    @base_url = "https://www.googleapis.com/books/v1/volumes"
  end

  private

  def request_parameters
    "?q=#{@book_name}"
  end
end
