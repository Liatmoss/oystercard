class Oystercard

attr_reader :balance

MAX_BALANCE = 30

def initialize
  @balance = 0
end

def top_up(amount)
  fail "Over the limit of #{MAX_BALANCE}" if balance + amount > MAX_BALANCE
  @balance += amount
end

end
