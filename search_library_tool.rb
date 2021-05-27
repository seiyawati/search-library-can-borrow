require_relative 'classes/isbn'
require_relative 'classes/book'
require_relative 'classes/library'

class SearchLibraryTool
  include Exceptions

  def self.usage
    puts <<~TEXT
      ~~~~~~~~~~~~~~~~~~~~~~使い方~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      第1引数：借りたい本の名前（ex. リーダブルコード）
      第2引数：現在地の住所（ex. 東京都港区六本木一丁目）
    TEXT
  end

  def initialize(book_name, address)
    @book_name = book_name
    @isbn = Isbn.generated_from(book_name).value
    @address = address
    @surround_libraries = Library.generated_from(address)
  end

  def run
    display_headline
    find_available_libraries
    display_available_libraries
  end

  private

  def display_headline
    puts <<~TEXT
      #{@address}周辺で「#{@book_name}」が貸し出し可能な図書館
      ....検索結果が表示されるまでしばらくお待ちください。
    TEXT
  end

  def find_available_libraries
    @available_libraries = []

    @surround_libraries.each do |library|
      book = Book.generated_from(@isbn, library.systemid)

      if ['OK,', 'Cache'].include?(book.status) && book.libkey[library.libkey] == '貸出可'
        @available_libraries << library
      end
    end

    @available_libraries
  end

  def display_available_libraries
    if @available_libraries.length == 0
      puts <<~TEXT
        #{@address}の近くの図書館に「#{@book_name}」の蔵書はありませんでした。
      TEXT
      return
    end

    @available_libraries.each do |library|
      puts <<~TEXT
        --------------------------------------------------------------
        #{library.name}
        住所：#{library.address}
        TEL：#{library.telephone}
        URL：#{library.url}
        --------------------------------------------------------------
      TEXT
    end
  end
end

if __FILE__ == $0
  return SearchLibraryTool.usage if ARGV[0] == 'help'

  raise ArgumentError, 'コマンドライン引数の数が正しくありません。' if ARGV.length != 2

  search_library = SearchLibraryTool.new(ARGV[0], ARGV[1])
  search_library.run
end
