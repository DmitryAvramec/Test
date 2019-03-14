# frozen_string_literal: true

require_relative 'log_parser'
require_relative 'errors_sender'

class Coordinator
  def self.call
    check_arguments
    new.call
  end

  def self.check_arguments
    ErrorsSender.no_arguments if ARGV.empty?
  end

  def call
    ErrorsSender.no_persistent_files unless check_files
    perform
  end

  def perform
    @persistent_files.each do |file|
      print "\n\n----------------------------\n"
      print "FILE:   #{file}\n"
      print "----------------------------\n"
      parser = LogParser.call(file)
      print_data(parser)
    end
  end

  def print_data(parser)
    print 'Unique views:'
    parser.page_views.each { |k, v| print "\n#{k}  #{v}" }
    print "\n-------------\n"
    print 'Page views:'
    parser.unique_views.each { |k, v| print "\n#{k}  #{v}" }
  end

  def check_files
    persistent_files
    missing_files
    if @missing_files.any? && @persistent_files.any?
      ErrorsSender.missing_files(@missing_files)
    end
    @persistent_files.any?
  end

  def persistent_files
    @persistent_files ||= ARGV.select { |arg| File.file? arg }
  end

  def missing_files
    @missing_files ||= ARGV.reject { |arg| File.file? arg }
  end
end
