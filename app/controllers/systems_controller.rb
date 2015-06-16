class SystemsController < ApplicationController
  def show
  	system=System.find_by(id: params[:id])
  	@system_decorator=SystemDecorator.new(system)
    @system_decorator.check_for_closed_incidents
  end   
end