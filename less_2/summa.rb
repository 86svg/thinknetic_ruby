basket = {}
full_price = 0
loop do
  puts "Введите название товара. Для завершения, введите 'стоп'"
  purchase_name = gets.chomp

break if purchase_name == "стоп"

  puts "Введите стоимость товара: "
  price = gets.chomp.to_f

  puts "Введите количество товара: "
  quantity = gets.chomp.to_f
  
  basket[purchase_name.to_sym] = {price: price, quantity: quantity}   
end


basket.each do |key, value|
  puts "название товара: #{key} цена за ед.: #{value[:price]} количество: #{value[:quantity]}"
  puts "сумма товара: #{key}: #{value[:price] * value[:quantity]}"
  full_price += value[:price] * value[:quantity]
end

puts "Общая стоимость товаров: #{full_price}"
