# frozen_string_literal: true
require_relative 'validation'
class CargoTrain < Train

  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, Symbol
  validate :wagons, :presence

  def initialize(number, type = :cargo, wagons = [])
    super
  end
end
