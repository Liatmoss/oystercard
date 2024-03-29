require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance
  attr_reader :exit_station, :entry_station
  attr_reader :journey_history

  def initialize
    @balance = 5
    @journey_history = {}
  end

  def top_up(amount)
    raise "Cannot top up, balance will exceed #{MAX_BALANCE} Pounds" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Cannot touch in, insufficent funds" if balance < MIN_BALANCE
    @journey_history[:entry_station] = station
  end

  def touch_out(station)
    deduct_fare(MIN_BALANCE)
    @journey_history[:exit_station] = station
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end
end
