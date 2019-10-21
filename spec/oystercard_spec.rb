require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'returns 0 when balance is called' do
      expect(subject.balance).to eq(0)
    end

    it 'balance increases by 2 when top_up(2) is called' do
      subject.top_up(2)
      expect(subject.balance).to eq 2
    end
  end

  describe '#top_up' do
    it 'should raise an error if balance exceeds maximum balance' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error "Over the limit of #{maximum_balance}"
    end
  end

  describe '#touch_out' do
    it 'reduces balance by minimum amount when touch_out is called' do
      subject.top_up(5)
      expect { subject.touch_out }.to change { subject.balance }.by -Oystercard::MINIMUM_FARE
    end
  end

  describe '#in_journey?' do
    it 'Returns false when in_journey? is called' do
      expect(subject).not_to be_in_journey
    end

    it 'can touch in' do
      subject.top_up(20)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'can touch out' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'raises error when touch_in is called with balance < minimum balance' do
      expect { subject.touch_in }.to raise_error 'Insufficient funds'
    end
  end
end
