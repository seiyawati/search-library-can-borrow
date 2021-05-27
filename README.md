# Search Library Tool

借りたい本の蔵書があって貸出可の状態である、あなたの現在地から近い図書館の情報を検索することができるアプリケーションです。 

## 作成動機

「図書館に行ってみたら借りたい本が貸出中だった」、「近隣の図書館についてまとめて詳しく知りたい」などといった問題を解決することを目的として作りました。

## フロー

第一引数で指定した書籍の名前をパラメータにISBNを取得します。  
ISBNとは図書および資料の識別用に設けられた国際規格コードの一種のことです。  
次に、取得したISBNをパラメータにその書籍が蔵書されている図書館リストを取得します。  
コマンドライン第二引数で取得した住所をパラーメータに近くの図書館リストを取得します。  
この近くの図書館リストの中で、目当ての本の蔵書があり、貸出可の状態の図書館を出力します。

## 設計

ディレクトリ構成
- classes/api_client.rb
- classes/geocode_api_client.rb
- classes/google_book_api_client.rb
- classes/calil_library_api_client.rb
- classes/calil_book_api_client.rb
- classes/location.rb
- classes/isbn.rb
- classes/lobrary.rb
- classes/book.rb
- exceptions/exceptions.rb
- config.rb
- search_library_tool.rb

外部API
- カーリル(https://calil.jp/)  
  図書館検索API  
  ISBNから蔵書がある図書館を検索  
  緯度経度から近隣の図書館を検索  
  APIキーの取得をする必要あり、フリーで使えます。

- Google Books API(https://developers.google.com/books/docs/overview)  
  本の名前から詳細情報を取得できて、その中にISBNも入っています。  
  フリーで使えます。

- Geocoding API(https://developers.google.cn/maps/documentation/geocoding/overview?hl=ja)  
  住所→座標 変換API  
  APIキーを取得する必要あり、一定のリクエスト数までフリーで使えます。

## 使用方法

カーリルとGoogle Cloud Platformで取得したAPIキーを環境変数に格納する。  
お使いのシェルで（ex. bin/bash）  
```
vim ~/.bashrc
```
.bashrcに環境変数を格納する
```
export CALIL_API_KEY="あなたのAPIキー"
export GOOGLE_API_KEY="あなたのAPIキー"
```
反映させる  
```
source ~/.bashrc
```

パラーメータに以下のコマンドライン引数を使用します。
- 第1引数：借りたい本の名前（ex. リーダブルコード）
- 第2引数：現在地の住所（ex. 東京都港区六本木一丁目）


コマンドライン引数のルール
- 正式な本の名前を入力してください。
- 住所はなるべく詳細に書いた方がより入力した住所から近い図書館が検索されます。

実行コマンド(ex)
```
ruby search_library_tool.rb リーダブルコード 東京都港区六本木
```

実行結果(ex)
```
東京都周辺で「嫌われる勇気」が貸し出し可能な図書館
....検索結果が表示されるまでしばらくお待ちください。
--------------------------------------------------------------
日本大学文理学部図書館
住所：東京都世田谷区桜上水3-25-40
TEL：03-5317-9280
URL：http://www.chs.nihon-u.ac.jp/opac/
--------------------------------------------------------------
--------------------------------------------------------------
女子美術大学・女子美術大学短期大学部杉並図書館
住所：東京都杉並区和田1-49-8
TEL：03-5340-4514
URL：http://library.joshibi.ac.jp/
--------------------------------------------------------------
--------------------------------------------------------------
国士舘大学中央図書館
住所：東京都世田谷区世田谷4-28-1
TEL：03-5481-3216
URL：https://www.kokushikan.ac.jp/education/libraly/
--------------------------------------------------------------
```

ヘルプコマンド
```
ruby search_library_tool.rb help
```
