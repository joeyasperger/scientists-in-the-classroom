class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :omniauthable
  # I enabled :timeoutable, which are not defaults
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable
end
