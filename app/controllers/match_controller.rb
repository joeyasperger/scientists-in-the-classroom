class MatchController < ApplicationController

    def new
        @teachers = Teacher.all
        @scientists = Scientist.all
    end

end
