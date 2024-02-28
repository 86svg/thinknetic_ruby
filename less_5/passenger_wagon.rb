class PassengerWagon < Wagon
  def initialize(manufacturer)
    @type = :passenger
    super(manufacturer)
  end
end
