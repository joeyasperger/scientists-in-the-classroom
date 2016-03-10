class MatchController < ApplicationController

    def new
        @page = 'match'
        @teachers = Teacher.all
        @scientists = Scientist.all
    end

    def index
        @page = 'matches'    
        if params[:name] or params[:institution] or params[:city] or params[:state]
            #lol this is ugly -- fix it
            teachers = Teacher.where("lower(name) like lower(?) and lower(school) like lower(?) \
                and lower(city) like lower(?) and lower(state) like lower(?)", "%#{params[:name]}%",
                "%#{params[:institution]}%", "%#{params[:city]}%", "%#{params[:state]}%") 
            scientists = Scientist.where("lower(name) like lower(?) and lower(affiliation) like lower(?) \
                and lower(city) like lower(?) and lower(state) like lower(?)", "%#{params[:name]}%",
                "%#{params[:institution]}%", "%#{params[:city]}%", "%#{params[:state]}%") 
            @matches = []
            teachers.each do |teacher|
                if teacher.matches[0] and not @matches.include?(teacher.matches[0])
                    @matches.append(teacher.matches[0])
                end
            end
            scientists.each do |scientist|
                if scientist.matches[0] and not @matches.include?(scientist.matches[0])
                    @matches.append(scientist.matches[0])
                end
            end
            @filtered = true
            @params = {
                name:params[:name],
                institution:params[:institution],
                city:params[:city],
                state:params[:state]
            }
        else
            @matches = Match.all
            @filtered = false
            @params = {
                name:"",
                institution:"",
                city:"",
                state:""
            }
        end

        @states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California",
            "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
            "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
            "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
            "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
            "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
            "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
            "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
            "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
            "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    end
end
