class TeacherController < ApplicationController
	include Geokit::Geocoders
	def test
		
		# if @school_loc.success
		# else
		# 	raise params.inspect
		# end
		# @scientist_location = []
		@scientist = Scientist.find_by_name("Young Lee")
		@teacher = Teacher.find_by_name("Jeff Rogers")
		if (@scientist.lat == nil) then
			@scientist_loc = GoogleGeocoder.geocode("#{@scientist.city}, @scientist.state 94703")
			@scientist.lat = @scientist_loc.lat
			@scientist.lng = @scientist_loc.lng
			@scientist.save
		end
		if (@teacher.lat == nil) then
			@teacher_loc = GoogleGeocoder.geocode("#{@teacher.city}, @teacher.state 94705")
			@teacher.lat = @teacher_loc.lat
			@teacher.lng = @teacher_loc.lng
			@teacher.save
		end
		
		@nearby_teacher = Teacher.within(50, :origin => [@scientist.lat, @scientist.lng]).first
		if (@nearby_teacher == nil) then
			@nearby_teacher = Teacher.new
			@nearby_teacher.name = "FAILURE"
			@nearby_teacher.save
			raise params.inspect
		end
	end
end

# within and beyond find records within or beyond a certain distance from the origin point.
# in_range finds records within a certain distance range from the origin point.
# in_bounds finds records within a rectangle on the map
# closest and farthest find the closest or farthest record from the origin point
# by_distance finds records ordered by distance from the origin point