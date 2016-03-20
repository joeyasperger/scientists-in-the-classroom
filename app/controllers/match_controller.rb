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
            @matches = Match.joins(:scientist).joins(:teacher).where("(lower(teachers.name) like lower(?) \
                and lower(teachers.school) like lower(?) and lower(teachers.city) like lower(?) \
                and lower(teachers.state) like lower(?)) OR (lower(scientists.name) like lower(?) \
                and lower(scientists.affiliation) like lower(?) and lower(scientists.city) like lower(?) \
                and lower(scientists.state) like lower(?))",
                "%#{params[:name]}%", "%#{params[:institution]}%", "%#{params[:city]}%", "%#{params[:state]}%",
                "%#{params[:name]}%", "%#{params[:institution]}%", "%#{params[:city]}%", "%#{params[:state]}%")
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
        compatible_scientists = Array.new
    	#default to 50 miles as distance for teachers
        distance = 50
    	for scientist in Scientist.within(distance, :origin => [curr_teacher.lat, curr_teacher.lng]).all do
    		if ((curr_teacher.climate_change == true && scientist.climate_change == true) || 
                (curr_teacher.evolution == true && scientist.evolution == true)) then
                compatible_scientists << scientist.id
            else 
                incompatible_scientists << scientist.id
            end
    	end
        for scientist in Scientist.beyond(50, :origin => [curr_teacher.lat, curr_teacher.lng]).all do
            incompatible_scientists << scientist.id
        end

    	data = {:incompatible_scientists => incompatible_scientists, 
                :compatible_scientists => compatible_scientists}
  		render :json => data, :status => :ok

    end

    def get_matched_teachers
    	curr_scientist = Scientist.find_by_id(params[:id])
        incompatible_teachers = Array.new
        compatible_teachers = Array.new
    	if curr_scientist.less_than_30 then
    		distance = 30
    	else
    		distance = 50
    	end
    	for teacher in Teacher.within(distance, :origin => 
    							[curr_scientist.lat, curr_scientist.lng]).all do
            puts teacher
            if ((curr_scientist.climate_change == true && teacher.climate_change == true) || 
                (curr_scientist.evolution == true && teacher.evolution == true)) then
                compatible_teachers << teacher.id
            else
                incompatible_teachers << teacher.id
            end
    	end
        for teacher in Teacher.beyond(50, :origin => [curr_scientist.lat, curr_scientist.lng]).all do
            incompatible_teachers << teacher.id
        end
        data = {:incompatible_teachers => incompatible_teachers,
                :compatible_teachers => compatible_teachers}
        puts data
        render :json => data, :status => :ok
    end

    def create_match 
        @teacher = Teacher.find_by_id(params[:teacher_id])
        if (@teacher == nil) then
            raise params.inspect
        end
        @scientist = Scientist.find_by_id(params[:scientist_id])
        if @scientist == nil then
            raise params.inspect
        end
        if (@teacher != nil && @scientist != nil) then
            match = Match.new
            match.teacher_id = @teacher.id
            match.scientist_id = @scientist.id
            match.save
            new_match = {match_id: match.id}
            render :json => new_match, :status => :ok
        end
        #@new_match = Match.new
        #@new_match.teacher_id = params[:teacher_id]
        #@new_match.scientist_id = params[:scientist_id]
        #@new_match.save
        # redirect_to '/matches/create_match'
    end

end
