require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Main
  MENU = [
    { id: 1, title: 'Создать станцию' },
    { id: 2, title: 'Создать поезд' },
    { id: 3, title: 'Создать маршрут' },
    { id: 4, title: 'Добавить, удалить станцию' },
    { id: 5, title: 'Назначить маршрут поезду' },
    { id: 6, title: 'Добавить вагон к поезду' },
    { id: 7, title: 'Отцепить вагон у поезда' },
    { id: 8, title: 'Переместить поезд по маршруту вперед (назад)' },
    { id: 9, title: 'Просмотреть список поездов на станции' },
    { id: 0, title: 'Выход' }
  ]

  def initialize
    @stations = []
    @passenger_trains = []
    @cargo_trains = []
    @routes = []
  end

  def start
    loop do
      show_menu
      make_choice
      take_action

      break if @choice.zero?
    end
  end

  private

  def show_menu
    MENU.each { |item| puts "#{item[:id]}. #{item[:title]} \n" }
  end

  def make_choice
    @choice = gets.chomp.to_i
  end

  def take_action
    case @choice
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    when 4 then change_stations
    when 5 then assign_route
    when 6 then attach_wagon
    when 7 then unhook_wagon
    when 8 then move_train
    when 9 then train_list
    end
  end

  def create_station
    puts 'Введите имя станции:'
    name_station = gets.chomp.downcase
    station = Station.new(name_station)
    @stations << station
  end

  def create_train
    puts 'Укажите номер поезда'
    number = gets.chomp
    puts number
    puts 'Укажите типа поезда: 1. пассажирский; 2. грузовой'
    train_type = gets.chomp.to_i

    if train_type == 1
      train = PassengerTrain.new(number)
      @passenger_trains << train

      puts 'поезд успешно создан'
    elsif train_type == 2
      train = CargoTrain.new(number)
      @cargo_trains << train

      puts 'поезд успешно создан'
    else
      puts 'недопустимый вариант ввода'
    end
  end

  def create_route
    if @stations.size < 2
      puts 'недостаточно станций'
    else
      puts 'выберите станции чтобы создать маршрут'

      show_stations_list

      puts 'введите номер начальной станции'
      first_station = gets.chomp.to_i - 1

      puts 'введите номер конечной станции'
      last_station = gets.chomp.to_i - 1

      route = Route.new(@stations[first_station], @stations[last_station])
      @routes << route
    end
  end

  def change_stations
    if @routes.empty?
      puts 'создайте маршрут'
    else
      puts 'Выберите маршрут в который хотите добавить станцию: '

      show_routes_list

      way_choice = gets.chomp.to_i - 1
      change_stations = @routes[way_choice]

      puts 'Выберите действие: 1. Добавить станцию. 2. Удалить станцию'
      stations_choice = gets.chomp.to_i

      if stations_choice == 1
        puts 'Выберите станцию, которую хотели бы добавить в маршрут: '

        show_stations_list

        add_station = gets.chomp.to_i - 1
        station_to_add = @stations[add_station]

        if change_stations.stations.include?(station_to_add)
          puts 'Станция уже есть в маршруте.'
        else
          change_stations.add_tintermediate_station(station_to_add)
        end
      elsif stations_choice == 2
        if change_stations.stations.size > 2
          change_stations.remove_tintermediate_station
        else
          puts 'В маршруте нет станций для удаления'
        end
      else
        puts 'неверный ввод'
      end
    end
  end

  def assign_route
    puts 'Какому типу поезда Вы хотите добавить маршрут? 1. Пассажирский; 2. Грузовой'
    train_type = gets.chomp.to_i

    if train_type == 1
      if @passenger_trains.empty?
        puts 'Создайте пассажирский поезд'
      else
        puts 'Выберите поезд, которому хотите добавить маршрут: '
        train_number = gets.chomp.to_i - 1

        puts 'Выберите маршрут, который хотите присвоить выбранному поезду: '
        show_routes_list
        route_to_train = gets.chomp.to_i - 1

        @passenger_trains[train_number].set_route(@routes[route_to_train])
        puts 'Поезду присвоен маршрут.'
      end
    elsif train_type == 2
      if @cargo_trains.empty?
        puts 'Создайте грузовой поезд'
      else
        puts 'Выберите поезд, которому хотите добавить маршрут: '
        show_cargo_trains_list
        train_number = gets.chomp.to_i - 1

        puts 'Выберите маршрут, который хотите присвоить выбранному поезду: '
        show_routes_list
        route_to_train = gets.chomp.to_i - 1

        @cargo_trains[train_number].set_route(@routes[route_to_train])
        puts 'Поезду присвоен маршрут.'
      end
    else
      puts 'неверный ввод'
    end
  end

  def attach_wagon
    puts 'Какому типу поезда вы хотите прицепить вагон? 1. Пассажирский; 2. Грузовой'
    train_type = gets.chomp.to_i

    if train_type == 1
      if @passenger_trains.empty?
        puts 'создайте поезд'
      else
        puts 'К какому поезду Вы хотите присоединить вагон?'
        show_passenger_trains_list
      end

      train_to_attach_number = gets.chomp.to_i-1
      wagon_to_attach = PassengerWagon.new
    @passenger_trains[train_to_attach_number].add_wagons(wagon_to_attach)
    elsif train_type == 2
      if @cargo_trains.empty?
        puts 'создайте поезд'
      else
        puts 'К какому поезду Вы хотите присоединить вагон?'
        show_cargo_trains_list
      end

      train_to_attach_number = gets.chomp.to_i-1
      wagon_to_attach = CargoWagon.new
      @cargo_trains[train_to_attach_number].add_wagons(wagon_to_attach)
    end
  end

  def unhook_wagon
    puts 'у какого  типa поезда вы хотите отцепить вагон? 1. Пассажирский; 2. Грузовой'
    train_type = gets.chomp.to_i

    if train_type == 1
      if @passenger_trains.empty?
        puts 'создайте поезд'
      else
        puts 'у какого поезда вы хотите отцепить вагон?'
        show_passenger_trains_list
      end

      remove_wagons = gets.chomp.to_i - 1
      @passenger_trains[remove_wagons].remove_wagons
      puts "вагон отцеплен"
    elsif train_type == 2
      if @cargo_trains.empty?
        puts 'создайте поезд'
      else
        puts 'у какого поезда вы хотите отцепить вагон?'
        show_cargo_trains_list
      end

      remove_wagons = gets.chomp.to_i - 1
      @cargo_trains[remove_wagons].remove_wagons
      puts 'вагон отцеплен'
    end
  end

  def move_train
    puts 'Выберите тип поезда: 1. Пассажирский; 2. Грузовой: '
    train_type = gets.chomp.to_i

    if train_type == 1
      if @passenger_trains.empty?
        puts 'Создайте поезд'
      else
        puts 'Какой поезд Вы хотите переместить?'
        show_passenger_trains_list
      end
      train_move = gets.chomp.to_i - 1
      train_to_move = @passenger_trains[train_move]

      if train_to_move.route
        puts 'Переместить поезд вперед или незад? 1. Вперед; 2. Назад'
        forward_or_backward = gets.chomp.to_i

        if forward_or_backward == 1
          train_to_move.move_forward
          puts "Поезд прибыл на станцию #{train_to_move.current_station.name}"
        elsif forward_or_backward == 2
          @passenger_trains[train_move].move_backward
          puts "Поезд вернулся на станцию #{@cargo_trains[train_move].current_station.name}"
        else
          puts 'неверный ввод'
        end
      else
        puts 'Установите поезд на маршрут' unless train_to_move.route
      end
    elsif train_type == 2
      puts 'Выберите поезд: '
      show_cargo_trains_list
      train_move = gets.chomp.to_i - 1

      puts 'Переместить поезд вперед или незад? 1. Вперед; 2. Назад'
      forward_or_backward = gets.chomp.to_i

      if forward_or_backward == 1
        @cargo_trains[train_move].move_forward
        puts "Поезд прибыл на станцию #{@cargo_trains[train_move].current_station.name}"
      elsif forward_or_backward == 2
        @cargo_trains[train_move].move_backward
        puts "Поезд вернулся на станцию #{@cargo_trains[train_move].current_station.name}"
      else
        puts 'неверный ввод'
      end
    else
      puts 'неверный ввод'
    end
  end

  def train_list
    if @stations.empty?
      puts 'создайте станцию'
    else
      show_stations_list
    end

    puts 'Выберите станцию для просмотра поездов: '
    station_choice = gets.chomp.to_i - 1

    puts "На станции нахоятся такие поезда: #{@stations[station_choice].trains}"
  end

  def show_stations_list
    @stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
  end

  def show_passenger_trains_list
    @passenger_trains.each_with_index do |train, index|
      puts "#{index + 1} поезд № #{train.number}"
    end
  end

  def show_cargo_trains_list
    @cargo_trains.each_with_index do |train, index|
      puts "#{index + 1}. поезд № #{train.number}"
    end
  end

  def show_routes_list
    @routes.each_with_index do |route, index|
      puts "#{index + 1}. #{route.stations}"
    end
  end

  Main.new.start
end
