require_relative 'station'


class Journey

  def initialize(station)
    @station = station
  end

  def journey_start
    @journey_start = true
  end

end
