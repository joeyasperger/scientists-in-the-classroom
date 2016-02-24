class Scientist < ActiveRecord::Base

    has_many :matches
    has_many :teachers, :through => :matches

end
