require_relative 'location'
require_relative 'calil_library_api_client'

class Library
  attr_reader :name, :address, :telephone, :url, :systemid, :libkey

  def self.generated_from(address)
    location = Location.generated_from(address)

    results = CalilLibraryAPIClient.new(location).get_request

    libraries = []
    results.each do |result|
      libraries << Library.new(
        result['formal'],
        result['address'],
        result['tel'],
        result['url_pc'],
        result['systemid'],
        result['libkey']
      )
    end
    libraries
  end

  def initialize(name, address, telephone, url, systemid, libkey)
    @name = name
    @address = address
    @telephone = telephone
    @url = url
    @systemid = systemid
    @libkey = libkey
  end
end
