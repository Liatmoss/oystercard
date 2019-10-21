require 'oystercard'

describe Oystercard do

  it 'returns 0 when balance is called' do
    expect(subject.balance).to eq(0)
  end

end
