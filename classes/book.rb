require_relative 'calil_book_api_client'

class Book
  attr_reader :status, :libkey

  RETRY_LIMIT_COUNT = 10
  RETRY_WAIT_TIME = 3

  def self.generated_from(isbn, systemid)
    RETRY_LIMIT_COUNT.times do |count|
      @results = CalilBookAPIClient.new(isbn, systemid).get_request

      break if @results['continue'] == 0

      raise 'retry error' if @results['continue'] == 1 && count == (RETRY_LIMIT_COUNT - 1)

      sleep RETRY_WAIT_TIME
    end

    Book.new(
      @results['books'][isbn][systemid]['status'],
      @results['books'][isbn][systemid]['libkey']
    )
  end

  def initialize(status, libkey)
    @status = status
    @libkey = libkey
  end
end
