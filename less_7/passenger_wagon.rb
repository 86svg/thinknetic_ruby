class PassengerWagon < Wagon
  attr_reader :total_size, :take_seats
  def initialize(type = :passenger, total_size)
    @total_size = total_size
    @take_seats = 0
    super
  end

  def taken_seats
    @take_seats += 1 if @take_seats < @total_size
  end

  def free_seats
    @total_size - @take_seats
  end

end
