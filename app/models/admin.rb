class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :omniauthable
  # I enabled :confirmable, :lockable, :timeoutable, which are not defaults
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
          :lockable, :timeoutable
end
