puts  "Введите: день, месяц, год:"
puts "введите день:"
day = gets.chomp.to_i
puts "введите месяц:"
month = gets.chomp.to_i
puts "введите год:"
year = gets.chomp.to_i
february = if (year % 400 == 0) && ((year % 4 == 0) && (year % 100 != 0))
  29
else
  28
end
  month_days = [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  number_date = day
  (0...month - 1).each do |m|
  number_date += month_days[m]
end
puts "Порядковый номер вашей даты: #{number_date}"
 