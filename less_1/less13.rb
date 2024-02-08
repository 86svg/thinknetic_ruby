triangle_side = []
puts "Введите первую сторону треугольника: "
triangle_side << gets.to_i
puts "Введите вторую сторону треугольника: "
triangle_side << gets.to_i
puts "Введите третью сторону треугольника: "
triangle_side << gets.to_i
a, b, c = triangle_side
triangle_side.sort

    if (a == b &&  b == c && a == c)
puts "Треугольник равносторонний, но не является прямоугольным."
    elsif  (a == b && a**2 + b**2 == c**2)
     puts "Треугольник является прямоугольным и равнобедренным."
    elsif (a**2 + b**2 == c**2)
      puts "Треугольник является прямоугольным."
    else
     puts "Треугольник не является прямоугольным."
    end
   