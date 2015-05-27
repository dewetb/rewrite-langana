require 'sinch_sms'

def random_code(size = 4)
  chars = (('a'..'z').to_a + ('2'..'9').to_a) - %w(i o l)
  (1..size).collect{|a| chars[rand(chars.size)] }.join
end

def send_code
  phone_number = '+27792958514'
  code = random_code
  SinchSms.send(ENV.fetch('SINCH_KEY'), ENV["SINCH_SECRET"], "Your code is #{code}", phone_number)
end

puts send_code