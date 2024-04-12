# frozen_string_literal: true

require_relative 'validation'

class Wagon
  include Manufacturer
  include Validation
  attr_reader :type, :total_size, :take_size

  def initialize(type, total_size)
    @type = type
    @total_size = total_size
    @take_size = 0
    validate!
  end

  def free_size
    @total_size - @take_size
  end

  def validate!
    raise "выберите тип вагона #{type}" if type != :cargo && type != :passenger
  end
end
