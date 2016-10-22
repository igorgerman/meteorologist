require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

##location
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_without_spaces

    parsed_data = JSON.parse(open(url).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


##Weather
url2 = "https://api.darksky.net/forecast/52d86c1b44b2c47bd9a307aa7b77346c/"+ @latitude.to_s + "," + @longitude.to_s

parsed_data2 = JSON.parse(open(url2).read)

@current_temperature = parsed_data2["currently"]["temperature"]

@current_summary = parsed_data2["currently"]["summary"]

@summary_of_next_sixty_minutes =parsed_data2["minutely"]["summary"]

@summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

@summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
