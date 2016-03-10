class MatchController < ApplicationController

    def new
        @teachers = Teacher.all
        @scientists = Scientist.all
    end

    def get_matched_scientists
    	curr_teacher = Teacher.find_by_id(params[:id])
    	array_of_ids = Array.new
        incompatible_scientists = Array.new
    	#default to 50 miles as distance for teachers
        distance = 50
    	for scientist in Scientist.within(distance, :origin => [curr_teacher.lat, curr_teacher.lng]).all do
    		if ((curr_teacher.climate_change == true && scientist.climate_change == true) || 
                (curr_teacher.evolution == true && scientist.evolution == true)) then
                array_of_ids << scientist.id
            else
                incompatible_scientists << scientist.id
            end
    	end
        for scientist in Scientist.beyond(50, :origin => [curr_teacher.lat, curr_teacher.lng]).all do
            incompatible_scientists << scientist.id
        end

    	data = {:scientists_in_range => array_of_ids, :incompatible_scientists => incompatible_scientists}
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
