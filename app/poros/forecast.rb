class Forecast
  attr_reader :current_weather_data, :daily_weather_data, :hourly_weather_data, :id

  def initialize(weather_data)
    @current_weather_data = weather_data[:current]
    @daily_weather_data   = weather_data[:forecast][:forecastday]
    @hourly_weather_data  = weather_data[:forecast][:forecastday][0][:hour]
    @id                   = nil
  end

  def current_weather
    {
      last_updated: current_weather_data[:last_updated],
      temperature:  current_weather_data[:temp_f],
      feels_like:   current_weather_data[:feelslike_f],
      humidity:     current_weather_data[:humidity],
      uvi:          current_weather_data[:uv],
      visibility:   current_weather_data[:vis_miles],
      condition:    current_weather_data[:condition][:text],
      icon:         current_weather_data[:condition][:icon][2..]
    }
  end

  def daily_weather
    @daily_weather_data.map do |forecast|
      {
        date:      forecast[:date],
        sunrise:   forecast[:astro][:sunrise],
        sunset:    forecast[:astro][:sunset],
        max_temp:  forecast[:day][:maxtemp_f],
        min_temp:  forecast[:day][:mintemp_f],
        condition: forecast[:day][:condition][:text],
        icon:      forecast[:day][:condition][:icon][2..]
      }
    end
  end

  def hourly_weather
    @hourly_weather_data.map do |hour|
      {
        time:        hour[:time][-5..],
        temperature: hour[:temp_f],
        conditions:  hour[:condition][:text],
        icon:        hour[:condition][:icon][2..]
      }
    end
  end
end