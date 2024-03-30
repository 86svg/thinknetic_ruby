class CargoWagon < Wagon
  def initialize(type = :cargo, total_size)
    super
  end

  def filling_volume
    @take_size += 1 if @take_size < @total_size
  end
end
