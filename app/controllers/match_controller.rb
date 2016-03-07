class MatchController < ApplicationController

    def new
        @teachers = Teacher.all
        @scientists = Scientist.all
    end

    def get_matched_scientists
    	curr_teacher = Teacher.find_by_id(params[:id])
    	array_of_ids = Array.new
    	#default to 50 miles as distance for teachers
    	for scientist in Scientist.within(50, :origin => [curr_teacher.lat, curr_teacher.lng]).all do
    		array_of_ids << scientist.id
    	end
    	data = {:scientists_in_range => array_of_ids, :all_scientists => Scientist.all.id}
  		render :json => data, :status => :ok

    end

    def get_matched_teachers
    	curr_scientist = Scientist.find_by_id(params[:id])
    	array_of_ids = Array.new
    	if curr_scientist.less_than_30 then
    		distance = 30
    	else
    		distance = 50
    	end
    	for teacher in Scientist.within(distance, :origin => 
    							[curr_scientist.lat, curr_scientist.lng]).all do
    		array_of_ids << teacher.id
    	end
    	data = {:message => array_of_ids}
  		render :json => data, :status => :ok

    end
end
