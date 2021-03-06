# encoding: utf-8

module RSpecTerm

  autoload :Configure, 'rspec_term/configure'

  autoload :Formatters, 'rspec_term/formatters'

  def self.configure &block
    Configure.configure &block if block_given?
    Configure.configure
  end

end

RSpec.configure do |config|
  formatter = RSpecTerm::Formatters::BackgroundFormatter.new RSpecTerm.configure
  config.reporter.register_listener(formatter, :start, :dump_summary)
end

