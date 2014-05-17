# encoding: utf-8

module RSpecTerm

  autoload :Configure, 'rspec_term/configure'

  autoload :Formatters, 'rspec_term/formatters'

  def self.configure &block
    Configure.configure &block
  end

end

RSpec.configure do |config|
  formatter = RSpecTerm::Formatters::BackgroundFormatter.new RSpecTerm::Configure.instance
  config.reporter.register_listener(formatter, :start, :dump_summary)
end

