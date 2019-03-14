# frozen_string_literal: true

class ErrorsSender
  class << self
    def no_persistent_files
      abort "We can't find any of files you provide to us"
    end

    def missing_files(files)
      print "We can't get this files(or mb they don't exist): #{files}\n"
    end

    def no_arguments
      abort "We need file to work with, so, please, specify atleast 1!\n e.g. ruby log_parser.rb file1 file2"
    end
  end
end
