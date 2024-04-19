# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(total_size, type = :cargo)
    super
  end

  def filling_volume
    @take_size += 1 if @take_size < @total_size
  end
end
