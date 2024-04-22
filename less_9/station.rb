# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include InstanceCounter
  include Accessors
  include Validation
  attr_reader :trains, :name

  attr_accessor_with_history :name

  validate :name, :presence
  validate :name, :format#, /^[A-Z][a-z]+$/

  def initialize(name)
    @name = name
    @trains = []
    validate!
    stations << self
    register_instance
  end

  def self.all_stations
    stations
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def all_trains(&block)
    @trains.each(&block)
  end

  # def validate!
  #   raise 'введите название станции' if name.nil?
  #   raise 'название станции не может быть пустым' if name.empty?
  # end

  private

  def stations
    @stations ||= []
  end
end
