def area_triangle (base, height)
  0.5 * base * height
end
puts "Введите основание треугольника: "
base = gets.to_f
puts "Введите высоту треугольника: "
height = gets.to_f
puts "Площадь треугольника #{area_triangle(base, height)}"