class TeacherController < ApplicationController

  def new
    @states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California",
      "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
      "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
      "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
      "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
      "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
      "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
      "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
      "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
      "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

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