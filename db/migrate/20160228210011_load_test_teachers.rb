class LoadTestTeachers < ActiveRecord::Migration
    def up
  	teacher1 = Teacher.new(:name => "Jeff Rogers", :city => "Berkeley", 
  						:state => "California",
  						:email => "yo.kitchen@gmail.com", :phone => "1234567890",
  						:school => "St. Mary's College High School",
  						:communication_method => "email")
    teacher1.save(:validate => false)

    scientist1 = Scientist.new(name: "Young Lee", city: "Berkeley", state:
    						"California", email: "physicsisgreat@stanford.edu")
    scientist1.save(:validate => false)

  end
end
