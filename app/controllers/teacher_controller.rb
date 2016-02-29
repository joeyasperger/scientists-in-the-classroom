class TeacherController < ApplicationController

  def new

  end

  def create
    teacher = Teacher.new(params.permit(:name, :city, :state, :email, :phone, :school,
      :grade, :topics, :class_times, :topics_to_cover, :benefits, :requirements))

    if params[:communication_method] == "other"
      teacher.communication_method = params[:communication_method_other]
    else
      teacher.communication_method = params[:communication_method]
    end

    case params[:topics]
    when "climate_change"
      teacher.climate_change = true
      teacher.evolution = false
    when "evolution"
      teacher.climate_change = false
      teacher.evolution = true
    when "both"
      teacher.climate_change = true
      teacher.evolution = true
    end

    if params[:read_expectations]
      teacher.read_expectations = true
    else
      teacher.read_expectations = false
    end

    if params[:approved]
      teacher.approved = true
    else
      teacher.approved = false
    end

    teacher.save

    redirect_to '/teachers/new'

  end

end