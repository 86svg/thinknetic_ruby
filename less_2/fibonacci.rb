
fibonacci = [0, 1]
loop do 
  numbers = (fibonacci[-1] + fibonacci[-2])
  break if numbers > 100
  fibonacci << numbers
end
puts fibonacci