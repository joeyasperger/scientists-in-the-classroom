class AddSamplePeople < ActiveRecord::Migration
    def up
  	teacher1 = Teacher.new(:name => "Jeff Rogers", :city => "Berkeley", 
  						:state => "California",
  						:email => "yo.kitchen@gmail.com", :phone => "1234567890",
  						:school => "St. Mary's College High School", :lat => 27, :lng => -122,
  						:communication_method => "email", :zip_code => "94705")
    teacher1.save(:validate => false)

    scientist1 = Scientist.new(name: "Young Lee", city: "Berkeley", state:
    						"California", email: "physicsisgreat@stanford.edu", :lat => 27, :lng => -122,
    						:zip_code => "94703")
    scientist1.save(:validate => false)

  end
end