require 'oystercard'

describe Oystercard do

  it 'returns 0 when balance is called' do
    expect(subject.balance).to eq(0)
  end

  it 'balance increases by 2 when top_up(2) is called' do
    subject.top_up(2)
    expect(subject.balance).to eq 2
  end

end
