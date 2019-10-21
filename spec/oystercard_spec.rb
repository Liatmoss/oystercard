require 'oystercard'

describe Oystercard do

  it 'returns 0 when balance is called' do
    expect(subject.balance).to eq(0)
  end

  it 'balance increases by 2 when top_up(2) is called' do
    subject.top_up(2)
    expect(subject.balance).to eq 2
  end

  it 'should raise an error if balance exceeds maximum balance'do
    maximum_balance = Oystercard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect { subject.top_up 1 }.to raise_error "Over the limit of #{maximum_balance}"
  end

end
