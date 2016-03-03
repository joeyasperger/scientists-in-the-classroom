class Scientist < ActiveRecord::Base
	acts_as_mappable #:auto_geocode => true
end
