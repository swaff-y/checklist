# frozen_string_literal: true

require_relative '../lib/version'

RSpec.describe Checklist::Version do
  let(:subject) { Checklist::Version }
  it { expect(subject.version).to eq '0.0.0' }
end
