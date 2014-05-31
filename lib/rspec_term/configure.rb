# encoding: utf-8
require 'singleton'

class RSpecTerm::Configure

  include Singleton

  attr_accessor :running_file, :running_url,
                :success_file, :success_url,
                :failure_file, :failure_url,
                :nothing_file, :nothing_url,
                :tmp_dir,
                :process

  def self.configure &block
    block.call instance if block_given?
    instance
  end

  def coverage &block
    if block_given?
      @coverage = block
      self
    else
      @coverage
    end
  end

  def coverage_file &block
    if block_given?
      @coverage_file = block
      self
    else
      @coverage_file
    end
  end

  def coverage_url &block
    if block_given?
      @coverage_url = block
      self
    else
      @coverage_url
    end
  end

end

