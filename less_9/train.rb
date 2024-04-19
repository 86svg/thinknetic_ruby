# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'accessors'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Accessors
  include Validation
  attr_accessor :speed
  attr_reader :number, :type, :wagons, :current_station, :route

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/i.freeze

  attr_accessor_with_history :speed
  strong_attr_accessor :name, String

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, Symbol
  validate :wagons, :presence

  def initialize(number, type, wagons = [])
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    validate!
    register_instance
  end

  def self.find(number)
    @@trains.select { |train| train.number == number }
  end

  def speed_up(speed)
    self.speed += speed
  end

  def brake
    self.speed = 0
  end

  def add_wagons(wagon)
    wagons << wagon if speed.zero? && type == wagon.type
  end

  def remove_wagons
    return unless wagons.size.positive? && speed.zero?

    wagons.delete_at(-1)
  end

  def get_route(route)
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

  def all_wagons(&block)
    @wagons.each(&block)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise 'введите номер поезда' if number.empty?
    raise 'введите правильный формат номера' if number !~ NUMBER_FORMAT
    raise "выберите тип поезда, (выбран #{type})" if type != :cargo && type != :passenger
    raise 'задайте количество вагонов' if wagons.nil?
  end
end
