class MatchController < ApplicationController

    def new
        @page = 'match'
        @teachers = Teacher.all
        @scientists = Scientist.all
    end

    def index
        @page = 'matches'
        @matches = Match.all
    end
end
