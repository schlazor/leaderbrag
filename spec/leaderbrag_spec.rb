# frozen_string_literal: true

require 'leaderbrag/standings'

describe Leaderbrag::Standings do
  it 'has standings' do
    expect(Leaderbrag::Standings.new.update).not_to be_nil
  end
end
