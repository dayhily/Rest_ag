class HomeController < ApplicationController
  def index
    @property = Property.all
  end
end
