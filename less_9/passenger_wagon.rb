# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(total_size, type = :passenger)
    super
  end

  def taken_seats
    @take_size += 1 if @take_size < @total_size
  end
end
