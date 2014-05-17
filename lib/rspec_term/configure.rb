# encoding: utf-8
require 'singleton'

class RSpecTerm::Configure

  include Singleton

  attr_accessor :running_file, :running_url,
                :success_file, :success_url,
                :failure_file, :failure_url,
                :nothing_file, :nothing_url,
                :tmp_dir

  def self.configure &block
    block.call instance
  end

end

