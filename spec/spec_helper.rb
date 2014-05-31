# encoding: utf-8
require 'simplecov'
SimpleCov.start do
  add_filter do |file|
    not file.filename =~ /^#{SimpleCov.root}\/lib/
  end
end

require 'rspec_term'

RSpecTerm.configure do |config|

#  dir = File.expand_path(File.join('../', 'images'), File.dirname(__FILE__))
#  config.success_file = "#{dir}/success.jpg"
#  config.running_file = "#{dir}/running.jpg"
#  config.failure_file = "#{dir}/failure.jpg"
#  config.nothing_file = "#{dir}/nothing.jpg"

  config.success_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/success.jpg'
  config.running_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/running.jpg'
  config.failure_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/failure.jpg'
  config.nothing_url = 'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/nothing.jpg'
  config.tmp_dir = '/tmp/rspec_term'

  config.coverage do
    SimpleCov.result.covered_percent
  end

  config.coverage_url do |coverage|
    case coverage
    when 70..100
      'https://raw.githubusercontent.com/brightgenerous/rspec_term/master/images/coverage_100.jpg'
    end
  end

end

