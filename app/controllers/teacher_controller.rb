class TeacherController < ApplicationController
  include Geokit::Geocoders
  def test
    @loc=GoogleGeocoder.geocode('100 Spear St, San Francisco, CA')
    @scientist = Scientist.find_by_name("Young Lee")
    @teacher = Teacher.find_by_name("Jeff Rogers")
    if (@scientist.lat == nil) then
      @scientist_loc = GoogleGeocoder.geocode(@scientist.city + ", " + 
              @scientist.state + " " + @scientist.zip_code)
      if @scientist_loc.success
        @scientist.lat = @scientist_loc.lat
        @scientist.lng = @scientist_loc.lng
        @scientist.save
        @scientist_success = "SUCCESS"
      else
        @scientist_success = "FAILURE"
      end
    end
    if (@teacher.lat == nil) then
      @teacher_loc = GoogleGeocoder.geocode(@teacher.city + ", " + 
              @teacher.state + " " + @teacher.zip_code)
      if @teacher_loc.success
        @teacher.lat = @teacher_loc.lat
        @teacher.lng = @teacher_loc.lng
        @teacher.save
        @teacher_success = "SUCCESS"
      else
        @teacher_success = "FAILURE"
      end
    end

    @nearby_teacher = Teacher.within(50, :origin => [@scientist.lat, @scientist.lng]).first
    if (@nearby_teacher == nil) then
      @nearby_teacher = Teacher.new
      @nearby_teacher.name = "FAILURE"
      @nearby_teacher.save
    end
  end

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
    teacher = Teacher.new(params.permit(:name, :city, :state, :zip_code, :email, :phone, :school,
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
    #geocode & store lat + lng
    teacher_loc = GoogleGeocoder.geocode(teacher.city + ", " + 
              teacher.state + " " + teacher.zip_code)
    if teacher_loc.success
      teacher.lat = teacher_loc.lat
      teacher.lng = teacher_loc.lng
    end 
    teacher.save

    redirect_to '/teachers/thankyou'

  end

end