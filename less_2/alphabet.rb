letter_number = {}

letters = ('а'..'я').to_a
vowels = %w[а е ё и о у ы э ю я]

letters.each_with_index do |key, value|
  letter_number[key] = value + 1 if vowels.include?(key)
end

puts letter_number
