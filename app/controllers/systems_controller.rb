class SystemsController < ApplicationController

  def index
    @systems_for_row1=System.system_list_for_row 1 
    @systems_for_row2=System.system_list_for_row 2 
  end

  def show
  	system=System.find_by(id: params[:id])
  	@system_decorator=SystemDecorator.new(system)
  	@system_decorator.check_for_closed_incidents
  end
    
end