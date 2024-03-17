require_relative 'validation'

class Wagon
  include Manufacturer
  attr_reader :type
  def initialize(type)
    @type = type
    validate!
  end

  def validate!
    raise "выберите тип вагона #{type}" if type != :cargo && type != :passenger
  end

end
