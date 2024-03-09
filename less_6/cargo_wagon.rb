class CargoWagon < Wagon
  def initialize(manufacturer)
    @type = :cargo
    super(manufacturer)
  end
end
