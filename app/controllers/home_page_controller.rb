class HomePageController < ApplicationController
  def index
    @systems_for_row1=System.system_list_for_row 1 
    @systems_for_row2=System.system_list_for_row 2 
    @contacts=Contact.all
  end
end
