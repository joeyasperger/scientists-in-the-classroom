class ScientistController < ApplicationController

  def new

  end

  def create

    scientist = Scientist.new(params.permit(:name, :city, :state, :email, :phone, :communication_method,
      :occupation, :education, :affiliation, :evolution, :climate_change, :specialization, :experience,
      :goals, :availability, :committed, :less_than_30, :link, :read_expectations))
    scientist.save

    redirect_to '/scientists/new'

  end

end