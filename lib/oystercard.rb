class Oystercard
  attr_reader :balance
  attr_reader :entry_station

  MAX_BALANCE = 30
  MINIMUM_FARE = 1

  def initialize
    @balance = 5
  end

  def top_up(amount)
    raise "Over the limit of #{MAX_BALANCE}" if balance + amount > MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    raise 'Insufficient funds' if balance < MINIMUM_FARE

    @in_journey = true

    @entry_station = station
  end

  def touch_out
    @in_journey = false
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
