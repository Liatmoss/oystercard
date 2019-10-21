class Oystercard
  attr_reader :balance

  MAX_BALANCE = 30

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Over the limit of #{MAX_BALANCE}" if balance + amount > MAX_BALANCE

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
