class PinController < ApplicationController
  def generate
    count = Rails.cache.read("count")
    pin = 0
    if count == 8990
      Rails.cache.clear
    end
    
    if count == nil
      count = 0
      Rails.cache.write("count", count)
    end
    
    loop do
      pin = rand(1000..9998)
      break if validPin(pin)
    end
    
    Rails.cache.write(pin, 1)
    Rails.cache.write("count", count+1)

    render json: { PIN: pin }
  end

  skip_forgery_protection

  private
  def validPin(pin)
    [1111, 2222, 3333, 4444, 5555, 6666, 7777, 8888, 9999].exclude? pin && !Rails.cache.exist?(pin)
  end
  
end
