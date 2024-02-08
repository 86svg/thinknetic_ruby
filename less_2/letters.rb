
  letter_number = {}
  letters = ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л",
  "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ",
  "ы", "ь", "э", "ю", "я" ]
  vowels = ["а", "е", "ё", "и", "о", "у", "ы", "э", "ю", "я"]
  letters.each.with_index do |key, value|
if vowels.include?(key)
  letter_number[key] = value + 1
  
end  
end
puts letter_number
