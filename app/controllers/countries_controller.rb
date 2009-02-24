class CountriesController < ApplicationController
  layout 'base'
  def index
    @countries = Country.find :all, :order => 'name'
  end
  
  def new
    @country = Country.new
  end
  
  def create
  end
end
