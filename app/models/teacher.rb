class Teacher < ActiveRecord::Base
	acts_as_mappable
    has_many :matches
    has_many :scientists, :through => :matches
end
