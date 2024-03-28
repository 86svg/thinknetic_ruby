require_relative 'validation'

class Wagon
  include Manufacturer
  include Validation
  attr_reader :type, :total_size
  def initialize(type, total_size)
    @type = type
    validate!
  end

  def validate!
    raise "выберите тип вагона #{type}" if type != :cargo && type != :passenger
  end

end
