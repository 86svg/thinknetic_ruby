
puts "Введите коэффициент a"
a = gets.to_i
puts "Введите коэффициент b"
b = gets.to_i
puts "Введите коэффициент c"
c = gets.to_i
D = b**2 - (4 * a * c)
if D < 0 
    puts "Дискриминант равняется D = #{D}", "Корней нет"
        elsif D == 0 
            X = -b / (a * 2)
            puts "Дискриминант равняется D = #{D}", "корень X = #{X}"
            else D > 0
                X1 = (-b + Math.sqrt(D)) / (a * 2)
                X2 = (-b - Math.sqrt(D)) / (a * 2)
                puts "Дискриминант равняется D = #{D}", "корень X1 = #{X1}", "корень X2 = #{X2}"

            end

   