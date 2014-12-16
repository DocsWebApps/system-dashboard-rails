class HomePageController < ApplicationController
  def index
    @systems=System.order(:name)
    @contacts=Contact.all
  end
end
