require_relative 'station'
require_relative 'oystercard'


class Journey

  def initialize(card, entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
    @card = card
  end

  def complete?
    
  end

end
