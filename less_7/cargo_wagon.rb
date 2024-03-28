class CargoWagon < Wagon
  attr_reader :total_size, :fill_volume
  def initialize(type = :cargo, total_size)
    super
    @total_size = total_size
    @fill_volume = 0
  end

  def filling_volume
    @fill_volume += 1 if fill_volume <= free_volume
  end

  def free_volume
    @total_size - @fill_volume
  end
end
