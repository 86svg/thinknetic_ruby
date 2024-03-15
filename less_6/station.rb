class Station
  include InstanceCounter
  attr_reader :trains, :name
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def self.all_stations
    @@stations
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select {|train| train.type == type}
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'введите название станции' if name.empty?
  end

end
