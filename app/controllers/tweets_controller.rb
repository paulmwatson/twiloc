class TweetsController < ApplicationController
  layout 'base'
  def index
    require 'hpricot'
    require 'open-uri'
    
    # Yahoo! Map service geocode http://developer.yahoo.com/maps/rest/V1/geocode.html
    # Twitter API http://apiwiki.twitter.com/Search-API-Documentation?SearchFor=location&sp=3
    # Google Maps http://code.google.com/apis/maps/documentation/introduction.html
    
    app_id = 'fxHTUTrV34EJvDAsVTomfVNKsl4iJkEhb.6D9F5Q0ni3SGCJcYBQcVG1QrMO_Ed4nEY5'
    @country = params[:country]
    @city = params[:city]
    @location_url = "http://local.yahooapis.com/MapsService/V1/geocode?appid=#{app_id}&country=#{@country}&city=#{@city}"
    
    @geo_doc = open(@location_url) { |f| Hpricot(f) }
    
    @lat = @geo_doc.search('//latitude')[0].inner_html
    @long = @geo_doc.search('//longitude')[0].inner_html
    @map_url = "http://maps.google.com/maps?q=#{@lat},+#{@long}"
    
    @search_radius = 10
    
    @twitter_geo_search_url = "http://search.twitter.com/search.atom?geocode=#{@lat}%2C#{@long}%2C#{@search_radius}km"
    
    @tweet_doc = open(@twitter_geo_search_url) { |f| Hpricot(f) }
    @tweets = @tweet_doc.search('//entry')
  end
end
