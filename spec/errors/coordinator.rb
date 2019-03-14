# frozen_string_literal: true

require 'coordinator'
require 'spec_helper'

RSpec.describe Coordinator do
  context 'when no arguments' do
    before { ARGV.replace [] }
    let(:expected_message) do
      'We need file to work with, so, please, specify atleast 1!\n e.g. ruby log_parser.rb file1 file2'
    end

    it 'shows no arg error' do
      expect { Coordinator.call }.to output(expected_message).to_stdout
    end
  end
end
