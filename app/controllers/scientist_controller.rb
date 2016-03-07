class ScientistController < ApplicationController
  include Geokit::Geocoders
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

    scientist = Scientist.new(params.permit(:name, :city, :state, :zip_code, :email, :phone, :education, :affiliation,
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

    #geocode & store lat + lng
    scientist_loc = GoogleGeocoder.geocode(scientist.city + ", " + 
              scientist.state + " " + scientist.zip_code)
    if scientist_loc.success
      scientist.lat = scientist_loc.lat
      scientist.lng = scientist_loc.lng
    end 
    scientist.save

    redirect_to '/scientists/new'

  end

  def test
    for scientist in Scientist.all
      @nearby_teachers = Teacher.within(50, :origin => [scientist.lat, scientist.lng]).all
    end
  end

end