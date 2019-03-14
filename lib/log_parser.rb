# frozen_string_literal: true

class LogParser
  def self.call(file_path)
    new(file_path).call
  end

  def initialize(file_path)
    @file_path = file_path
    @file_data = File.read(@file_path)
    @processed_data = Hash.new([])
  end

  def call
    parse_log
    self
  end

  def parse_log
    @file_data.each_line do |line|
      line_data = line.split(' ')
      page = line_data[0]
      ip = line_data[1]
      @processed_data[page] = [@processed_data[page], ip].flatten.compact
    end
  end

  def page_views
    res = @processed_data.each_with_object({}) do |(k, v), memo|
      memo[k] = v.count
    end
    res.sort_by { |_, v| -v }.to_h
  end

  def unique_views
    res = @processed_data.each_with_object({}) do |(k, v), memo|
      memo[k] = v.uniq.count
    end
    res.sort_by { |_, v| -v }.to_h
  end
end
