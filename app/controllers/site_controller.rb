class SiteController < ApplicationController
  def index
    # Temporary redirect until a proper home page is sorted TODO
    redirect_to '/local/ireland/dublin/'
  end
end
