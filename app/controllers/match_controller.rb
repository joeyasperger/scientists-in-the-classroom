class MatchController < ApplicationController

    def new
        @teachers = Teacher.all
        @scientists = Scientist.all
    end

    def index
        @matches = Match.all
    end
end
