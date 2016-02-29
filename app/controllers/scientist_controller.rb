class ScientistController < ApplicationController

  def new

  end

  def create

    scientist = Scientist.new(params.permit(:name, :city, :state, :email, :phone, :education, :affiliation,
      :specialization, :experience, :goals, :availability, :less_than_30, :link, :read_expectations))

    if params[:communication_method] == "other"
      scientist.communication_method = params[:communication_method_other]
    else
      scientist.communication_method = params[:communication_method]
    end

    if params[:occupation] == "other"
      scientist.occupation = params[:occupation_other]
    else
      scientist.occupation = params[:occupation]
    end

    case params[:topics]
    when "climate_change"
      scientist.climate_change = true
      scientist.evolution = false
    when "evolution"
      scientist.climate_change = false
      scientist.evolution = true
    when "both"
      scientist.climate_change = true
      scientist.evolution = true
    end

    if params[:committed]
      scientist.committed = true
    else
      scientist.committed = false
    end

    if params[:read_expectations]
      scientist.read_expectations = true
    else
      scientist.read_expectations = false
    end

    scientist.save

    redirect_to '/scientists/new'

  end

end