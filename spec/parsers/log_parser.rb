# frozen_string_literal: true

require 'log_parser'
require 'spec_helper'

RSpec.describe LogParser do
  subject { described_class.call(log) }

  let(:log) { 'spec/fixtures/sample.log' }
  let(:page_views) { { '/help_page/1' => 3, '/contact' => 2, '/home' => 1 } }
  let(:unique_views) { { '/help_page/1' => 2, '/contact' => 2, '/home' => 1 } }

  it 'return page view count' do
    expect(subject.page_views).to eq(page_views)
  end

  it 'return uniq view count' do
    expect(subject.unique_views).to eq(unique_views)
  end
end
