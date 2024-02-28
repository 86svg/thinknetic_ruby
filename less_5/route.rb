class Route
  include InstanceCounter
  attr_accessor :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_tintermediate_station(station)
    stations.insert(-2, station)
  end

  def remove_tintermediate_station
    stations.delete_at(-2)
  end
end
