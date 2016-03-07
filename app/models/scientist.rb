class Scientist < ActiveRecord::Base
	acts_as_mappable
    has_many :matches
    has_many :teachers, :through => :matches
end
