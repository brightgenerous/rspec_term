# encoding: utf-8
require 'rspec/core/formatters/base_formatter'
require 'fileutils'
require 'digest/md5'
require 'open-uri'

class RSpecTerm::Formatters::BackgroundFormatter < RSpec::Core::Formatters::BaseFormatter

  def initialize *args
    super nil

    @config = args.first
  end

  private

  def init
    return self if @inited

    @tmp_dir = @config.tmp_dir.to_s.strip
    @tmp_dir = '.' if @tmp_dir.empty?
    FileUtils.mkdir_p @tmp_dir unless File.exists? @tmp_dir

    @success_tmp = url_to_tmp @tmp_dir, @config.success_url
    @running_tmp = url_to_tmp @tmp_dir, @config.running_url
    @failure_tmp = url_to_tmp @tmp_dir, @config.failure_url
    @nothing_tmp = url_to_tmp @tmp_dir, @config.nothing_url

    @inited = true
    self
  end

  def url_to_tmp tmp_dir, url
    if url
      "#{tmp_dir}/#{Digest::MD5.hexdigest(url).to_s}"
    else
      nil
    end
  end

  public

  # if RSpec version is 2.14,
  #   then args are expected_example_count
  # if RSpec version is 3.0
  #   then args are Notifications::StartNotification
  def start *args
    return unless iterm?

    init

    unless @error_message
      _file = set_file @config.running_file, @config.running_url, @running_tmp
      _file ||= ''
      change_background _file
    end
  rescue => e
    @error_message = e.inspect
  end

  # if RSpec version is 2.14,
  #   then args are duration, example_count, failure_count, pending_count
  # if RSpec version is 3.0
  #   then args are Notifications::SummaryNotification
  def dump_summary *args
    return unless iterm?

    if args.count == 4
      notification = Struct.new(:duration, :example_count, :failure_count, :pending_count).new *args
    else
      notification = args.first
    end
    _dump_summary notification
    p @error_message if @error_message
  end

  private

  def _dump_summary notification
    init

    if notification.example_count == 0
      _file = set_file @config.nothing_file, @config.nothing_url, @nothing_tmp
      _file ||= ''
      change_background _file
      return
    end

    unless @error_message
      (file, url, tmp) = if notification.failure_count == 0
        coverage = nil
        if @config.coverage and (coverage = @config.coverage.call)
          file = if @config.coverage_file
                   @config.coverage_file.call coverage
                 end || @config.success_file
          url = if @config.coverage_url
                  @config.coverage_url.call coverage
                end || @config.success_url
          tmp = url_to_tmp @tmp_dir, url
          [file, url, "#{tmp}"]
        else
          [@config.success_file, @config.success_url, "#{@success_tmp}"]
        end
      else
        [@config.failure_file, @config.failure_url, "#{@failure_tmp}"]
      end
      _file = set_file file, url, tmp
      _file ||= ''
      change_background _file
    end
  rescue => e
    @error_message = e.inspect
  end

  def set_file file, url, tmp
    file = file.path if file and file.is_a? File
    url = url.path if url and url.is_a? File
    tmp = tmp.path if tmp and tmp.is_a? File
    return file if file and File.exists? file
    File.delete tmp if tmp and File.zero? tmp
    return tmp if File.exists? tmp
    return tmp unless url and tmp

    open tmp, 'wb' do |f|
      open url do |data|
        f.write data.read
      end
    end
    tmp
  end

  def iterm?
    return @iterm unless @iterm.nil?
    (ret, pattern) = if @config.process
                       [`ps -e`, @config.process]
                     else
                       [`ps -e | grep "Term"`, /\/iTerm\z/]
                     end
    @iterm = if ret.is_a? String
               ret.each_line.any? do |line|
                 words = line.strip.split(/\s+/)
                 next if words.count < 4
                 if pattern.is_a? String
                   words[3] == pattern
                 else
                   words[3] =~ pattern
                 end
               end
             else
               false
             end
  end

  def change_background file
    cmd = <<-EOS
            /usr/bin/osascript <<-EOF
              tell application "iTerm"
                tell the current terminal
                  tell the current session
                    set background image path to "#{file}"
                  end tell
                end tell
              end tell
            EOF
         EOS
    `#{cmd}`
  end

end

