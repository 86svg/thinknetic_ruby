# frozen_string_literal: true

require_relative 'accessors'
require_relative 'validation'

class Wagon
  include Manufacturer
  include Accessors
  include Validation
  attr_reader :type, :total_size, :take_size

  attr_accessor_with_history :total_size
  strong_attr_accessor :type, Symbol

  validate :type, :type, Symbol
  validate :total_size, :type, Integer

  def initialize(type, total_size)
    @type = type
    @total_size = total_size
    @take_size = 0
    validate!
  end

  def free_size
    @total_size - @take_size
  end

  # def validate!
  #   raise "выберите тип вагона #{type}" if type != :cargo && type != :passenger
  # end
end
