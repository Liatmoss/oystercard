require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'balance increases by 2 when top_up(2) is called' do
      expect { subject.top_up(2) }.to change { subject.balance }.by 2
    end
  end

  describe '#top_up' do
    it 'should raise an error if balance exceeds maximum balance' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance - subject.balance)
      expect { subject.top_up 1 }.to raise_error "Over the limit of #{maximum_balance}"
    end
  end

  describe '#touch_out' do
    it 'reduces balance by minimum amount when touch_out is called' do
      expect { subject.touch_out }.to change { subject.balance }.by -Oystercard::MINIMUM_FARE
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
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'raises error when touch_in is called with balance < minimum balance' do
      subject.balance.times do
        subject.touch_in(station)
        subject.touch_out
      end
      expect { subject.touch_in(station) }.to raise_error 'Insufficient funds'
    end
  end

  let(:station){ double :station }

  it 'stores entry station after touch in' do
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'forgets entry station on touch out' do
    subject.touch_in(station)
    subject.touch_out
    expect(subject.entry_station).to be nil
  end

end
