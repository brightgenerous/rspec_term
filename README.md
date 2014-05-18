# RspecTerm
###### ver 0.2.0

RSpecの実行中や、テスト結果によってiTermの背景画像を変更する ruby gem です。  
RSpec2, RSpec3に対応しています。

## Installation

Add this line to your application's Gemfile:

    gem 'rspec_term'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_term

## Usage

spec/spec_helper.rb ファイルに以下を記述します


    require 'rspec_term'

    RSpecTerm.configure do |config|

      #dir = File.expand_path(File.join('../', 'images'), File.dirname(__FILE__))
      #config.success_file = "#{dir}/success.jpg"
      #config.running_file = "#{dir}/running.jpg"
      #config.failure_file = "#{dir}/failure.jpg"
      #config.nothing_file = "#{dir}/nothing.jpg"

      config.success_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/success.jpg'
      config.running_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/running.jpg'
      config.failure_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/failure.jpg'
      config.nothing_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/nothing.jpg'
      config.tmp_dir = '/tmp/rspec_term'

    end

#### 基本的な使い方

* `success_file` : テストがエラーなしで終了した場合に表示される画像のファイル。`success_url`よりも優先される。  
* `running_file` : テスト実行中表示される画像のファイル。`running_url`よりも優先される。  
* `failure_file` : テストがエラーありで終了した場合に表示される画像のファイル。`failure_url`よりも優先される。  
* `nothing_file` : 行うべきテストがなかった場合に表示される画像のファイル。`nothing_url`よりも優先される。  
* `success_url` : テストがエラーなしで終了した場合に表示される画像のURL。  
* `running_url` : テスト実行中表示される画像のURL。  
* `failure_url` : テストがエラーありで終了した場合に表示される画像のURL。  
* `nothing_url` : 行うべきテストがなかった場合に表示される画像のURL。  
* `tmp_dir` : URLの画像を保存するディレクトリ。URLから生成したハッシュをファイル名として保存する。すでにファイルが存在する場合は再度ダウンロードしない。


## Contributing

1. Fork it ( http://github.com/<my-github-username>/rspec_term/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
