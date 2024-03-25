# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookedTicketsCounter do
  subject { described_class.new(event) }
  let(:redis) { instance_double('Redis') }
  let(:event) { build_stubbed(:event) }
  let(:list_key) { "#{event.id}/booked_tickets" }

  before do
    allow(RedisCurrent).to receive(:connection).and_return(redis)
  end

  describe '.increase_counter' do
    it 'pushes the number of elements that equal to the value passed' do
      expect(redis).to receive(:rpush).with(list_key, Array.new(10, 1))

      subject.increase_counter(10)
    end
  end

  describe '.count' do
    it 'returns length of the list' do
      expect(redis).to receive(:llen).with(list_key).and_return(1)

      expect(subject.count).to eq(1)
    end
  end
end
