class TeacherController < ApplicationController

  def new

  end

  def create
    teacher = Teacher.new(params.permit(:name, :city, :state, :email, :phone,
      :school, :communication_method, :grade, :topics, :class_times, :climate_change,
      :evolution, :topics_to_cover, :benefits, :requirements, :read_expectations, :approved))
    teacher.save

    redirect_to '/teachers/new'
    
  end

end