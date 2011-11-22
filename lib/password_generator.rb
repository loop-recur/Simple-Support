module PasswordGenerator
  extend self
  
  def generate!
    valid_chars = ("a".."z").to_a + ("1".."9").to_a
    pick = lambda{ |range| (1..range).map { valid_chars[rand(valid_chars.length)] } }
    pick[7].join
  end
  
end
