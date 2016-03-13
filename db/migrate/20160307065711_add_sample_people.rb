class AddSamplePeople < ActiveRecord::Migration
    def up
  	teacher1 = Teacher.new(:name => "Jeff Rogers", :city => "Berkeley", 
  						:state => "California",
  						:email => "yo.kitchen@gmail.com", :phone => "1234567890",
  						:school => "St. Mary's College High School", :lat => 37.871399, :lng => -122.259591,
  						:communication_method => "email", :zip_code => "94705", evolution: true,
              climate_change: false)
    teacher1.save(:validate => false)

    scientist1 = Scientist.new(name: "Young Lee", city: "Berkeley", state:
    						"California", email: "physicsisgreat@stanford.edu", :lat => 37.871399, 
                :lng => -122.259591, evolution: true, climate_change: false,
    						:zip_code => "94703")
    scientist1.save(:validate => false)

    teacher2 = Teacher.new(:name => "Craig Sutphin", :city => "Houston", 
              :state => "Texas",
              :email => "yo.kitchen@gmail.com", :phone => "1234567890",
              :school => "St. Mary's College High School", :lat => 29.742151, :lng => -95.397540,
              :communication_method => "email", :zip_code => "77006", evolution: false,
              climate_change: true)
    teacher2.save(:validate => false)

    scientist2 = Scientist.new(name: "John Forte", city: "Houston", state:
                "Texas", email: "physicsisgreat@stanford.edu", :lat => 29.742151, 
                :lng => -95.397540, evolution: false, climate_change: true,
                :zip_code => "77006")
    scientist2.save(:validate => false)

    teacher3 = Teacher.new(:name => "Jennifer Jack", :city => "El Cerrito", 
              :state => "California",
              :email => "yo.kitchen@gmail.com", :phone => "1234567890",
              :school => "St. Mary's College High School", :lat => 37.921409, :lng => -122.303532,
              :communication_method => "email", :zip_code => "94530", evolution: false,
              climate_change: true)
    teacher3.save(:validate => false)

    scientist3 = Scientist.new(name: "Kathleen Gonzalez", city: "Albany", state:
                "California", email: "physicsisgreat@stanford.edu", :lat => 37.891490, 
                :lng => -122.304575, evolution: true, climate_change: true,
                :zip_code => "94706")
    scientist3.save(:validate => false)

  end
end