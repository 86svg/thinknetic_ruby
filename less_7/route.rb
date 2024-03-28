require_relative 'validation'

class Route
  include InstanceCounter
  attr_accessor :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
    register_instance

  end

  def add_tintermediate_station(station)
    stations.insert(-2, station)
  end

  def remove_tintermediate_station
    stations.delete_at(-2)
  end

  def validate!
    raise 'укажите начальную и конечную станции' if stations.size < 2
  end
end
