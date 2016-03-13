class MatchController < ApplicationController

    before_action :authenticate_admin!

    def new
        @page = 'match'
        @teachers = Teacher.all
        @scientists = Scientist.all
    end

    def index
        @page = 'matches'    
        if params[:name] or params[:institution] or params[:city] or params[:state]
            #lol this is ugly -- fix it
            teachers = Teacher.where("lower(name) like lower(?) and lower(school) like lower(?) \
                and lower(city) like lower(?) and lower(state) like lower(?)", "%#{params[:name]}%",
                "%#{params[:institution]}%", "%#{params[:city]}%", "%#{params[:state]}%") 
            scientists = Scientist.where("lower(name) like lower(?) and lower(affiliation) like lower(?) \
                and lower(city) like lower(?) and lower(state) like lower(?)", "%#{params[:name]}%",
                "%#{params[:institution]}%", "%#{params[:city]}%", "%#{params[:state]}%") 
            @matches = []
            teachers.each do |teacher|
                if teacher.matches[0] and not @matches.include?(teacher.matches[0])
                    @matches.append(teacher.matches[0])
                end
            end
            scientists.each do |scientist|
                if scientist.matches[0] and not @matches.include?(scientist.matches[0])
                    @matches.append(scientist.matches[0])
                end
            end
            @filtered = true
            @params = {
                name:params[:name],
                institution:params[:institution],
                city:params[:city],
                state:params[:state]
            }
        else
            @matches = Match.all
            @filtered = false
            @params = {
                name:"",
                institution:"",
                city:"",
                state:""
            }
        end

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

    def get_matched_scientists
    	curr_teacher = Teacher.find_by_id(params[:id])
        incompatible_scientists = Array.new
    	#default to 50 miles as distance for teachers
        distance = 50
    	for scientist in Scientist.within(distance, :origin => [curr_teacher.lat, curr_teacher.lng]).all do
    		if (!((curr_teacher.climate_change == true && scientist.climate_change == true) || 
                (curr_teacher.evolution == true && scientist.evolution == true))) then
                incompatible_scientists << scientist.id
            end
    	end
        for scientist in Scientist.beyond(50, :origin => [curr_teacher.lat, curr_teacher.lng]).all do
            incompatible_scientists << scientist.id
        end

    	data = {:incompatible_scientists => incompatible_scientists}
  		render :json => data, :status => :ok

    end

    def get_matched_teachers
    	curr_scientist = Scientist.find_by_id(params[:id])
        incompatible_teachers = Array.new
    	if curr_scientist.less_than_30 then
    		distance = 30
    	else
    		distance = 50
    	end
    	for teacher in Teacher.within(distance, :origin => 
    							[curr_scientist.lat, curr_scientist.lng]).all do
            if (!((curr_scientist.climate_change == true && teacher.climate_change == true) || 
                (curr_scientist.evolution == true && teacher.evolution == true))) then
                incompatible_teachers << teacher.id
            end
    	end
        for teacher in Teacher.beyond(50, :origin => [curr_scientist.lat, curr_scientist.lng]).all do
            incompatible_teachers << teacher.id
        end
        data = {:incompatible_teachers => incompatible_teachers}
        render :json => data, :status => :ok
    end

end
