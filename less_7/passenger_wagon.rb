class PassengerWagon < Wagon

  def initialize(type = :passenger, total_size)
    super
  end

  def taken_seats
    @take_size += 1 if @take_size < @total_size
  end
end
