class PassengerTrain < Train
  def initialize(number, type = :passenger, wagons = [])
    @type = :passenger

    super
  end
end
