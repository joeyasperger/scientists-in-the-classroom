class Teacher < ActiveRecord::Base

    has_many :matches
    has_many :scientists, :through => :matches

end
