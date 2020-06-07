# caesar_shift.rb

def caesar_shift(text, key_shift)
  encrypted_text = ""
  encrypted_letter = ""
  divided_text = text.split("")
  upcase_abc = ("A".."Z").to_a
  downcase_abc = ("a".."z").to_a
  
  divided_text.each do |character|
    if upcase_abc.include?(character)
      encrypted_letter = encrypt_text(upcase_abc, character, key_shift)
      encrypted_text += encrypted_letter
 
    elsif downcase_abc.include?(character)
      encrypted_letter = encrypt_text(downcase_abc, character, key_shift)
      encrypted_text += encrypted_letter
    
    else
      # If character isn't a letter add it without encrypting it.
      encrypted_text += character
    end
  end
  encrypted_text
end

def encrypt_text(abecedary, letter, key_shift)
  letter_index = abecedary.index(letter)
  if (letter_index + key_shift) >= abecedary.length
    letter_index = (letter_index + key_shift) - abecedary.length
    encrypted_letter = abecedary[letter_index]

  else
    encrypted_letter = abecedary[letter_index + key_shift]
  end
end

puts "Enter the text to be encrypted: "
text = gets.chomp

puts "\nEnter the number to use as key shift to encrypt: "
key_shift = gets.chomp.to_i

encrypted_text = caesar_shift(text, key_shift)
puts encrypted_text