require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station){ double :station}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journeys){ {entry_station: entry_station, exit_station: exit_station} }

  describe '#top_up' do
    it 'balance increases by 2 when top_up(2) is called' do
      expect { subject.top_up(2) }.to change { subject.balance }.by 2
    end

    it 'raises an error when the maximum balance is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      expect { oystercard.top_up(max_balance) }.to raise_error RuntimeError
    end
  end

  describe '#touch_out' do
    it 'reduces balance by minimum amount when touch_out is called' do
      expect { subject.touch_out(station) }.to change { subject.balance }.by -Oystercard::MIN_BALANCE
    end
  end

  describe '#in_journey?' do
    it 'Returns false when in_journey? is called' do
      expect(subject).not_to be_in_journey
    end

    it 'can touch in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'can touch out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it 'remembers the exit station after touch out' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard.exit_station).to eq station
    end

  end

  describe '#touch_in' do
    it 'raises error when touch_in is called with balance < minimum balance' do
      subject.balance.times do
        subject.touch_in(station)
        subject.touch_out(station)
      end
      expect { subject.touch_in(station) }.to raise_error 'Cannot touch in, insufficent funds'
    end
  end

  it 'stores entry station after touch in' do
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'forgets entry station on touch out' do
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.entry_station).to eq nil
  end

  it 'expect journey_history to include station information' do
    oystercard.top_up(5)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journey_history).to include journeys
  end

end
