class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :speed
  attr_reader :number, :type, :wagons, :current_station, :route
  @@trains = []

  NUMBER_FORMAT = /^[\w]{3}-?[\w]{2}$/i

  def initialize(number, type, wagons = [])
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @@trains[number]
    register_instance
    validate!
  end

  def self.find(number)
    @@trains[number]
  end

  def speed_up(speed)
    self.speed += speed
  end

  def brake
    self.speed = 0
  end

  def add_wagons(wagon)
    wagons << wagon if speed == 0 && type == wagon.type
  end

  def remove_wagons
    if wagons.size > 0 && speed == 0
      wagons.delete_at(-1)
    end
  end

  def set_route(route)
    @route = route
    @current_station = @route.stations.first
  end

  def move_forward
    current_station_index = station_index(@current_station)

    if current_station_index == @route.stations.size - 1
      stations
    else
      @current_station = @route.stations[current_station_index + 1]
    end
  end

  def move_backward
    current_station_index = station_index(@current_station)
    if current_station_index.zero?
      stations
    else
      @current_station = @route.stations[current_station_index - 1]
    end
  end

  def station_index(station)
    @route.stations.index(station)
  end

  def next_station
    @current_station = @route.stations[current_station_index + 1]
  end

  def previous_station
    @current_station = @route.stations[current_station_index - 1]
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'введите номер поезда' if number.nill?
    raise 'введите правильный формат номера' if number !~ NUMBER_FORMAT
    raise 'выберите тип поезда' if type != :cargo && type != :passenger
    raise 'задайте количество вагонов' if wagons.nil?
  end
end
