# frozen_string_literal: true

require 'spec_helper'
require_relative '../queen_threat.rb'

RSpec.describe QueenThreat, type: :domain do
  TESTS = [{ problem: [0, 1, 2], solution: { '0,0' => 1, '1,1' => 2, '2,2' => 1 } },
           { problem: [0, 2, 4, 1], solution: {} },
           { problem: [3, 2, 1, 0], solution: { '0,3' => 1, '1,2' => 2, '2,1' => 2, '3,0' => 1 } }].freeze
  #    @t = [ 1,0,0,0,
  #           0 1,0,0,
  #          0,0,1,0,
  #          0,0,0,1]

  describe 'find_all ' do
    TESTS.each do |t|
      it "for #{t.fetch(:problem)}" do
        expect(QueenThreat.new(queen_positions: t.fetch(:problem)).find_all).to eq t.fetch(:solution)
      end
    end
  end
end
