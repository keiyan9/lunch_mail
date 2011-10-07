class Weather < ActiveRecord::Base
  def self.extract_probability response
    today = Date.today.strftime("%Y-%m-%d") 
    response.forecast.umbrella.umbrellaIndex.select{|rec| rec.date == today}.first.value
  end

  def self.notice? probability
    probability > 30
  end

end
