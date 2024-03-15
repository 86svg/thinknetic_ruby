class Wagon
  include Manufacturer
  attr_reader :type
  def initialize(manufacturer, type)
    @manufacturer = manufacturer
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise "выберите тип вагона #{type}" if type != :cargo && type != :passenger
  end

end
