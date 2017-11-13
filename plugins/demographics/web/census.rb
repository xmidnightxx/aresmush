module AresMUSH
  class WebApp
    
    helpers do
      def census_types
        [ 'gender', 'nationality', 'position', 'crew', 'rank' ]
      end
    end
    
    get '/census/?' do
      @chars = Chargen.approved_chars.sort_by { |c| c.name }
      erb :"census/all"
    end


    get '/census/gender/?' do
      @groups = Chargen.approved_chars.group_by { |c| c.demographic(:gender)}
      @title = "Characters by Gender"
      erb :"census/group"
    end

    get '/census/nationality/?' do
      @groups = Chargen.approved_chars.group_by { |c| c.group('Nationality')}
      @title = "Characters by Nation"
      erb :"census/group"
    end
        
    get '/census/position/?' do
      @groups = Chargen.approved_chars.group_by { |c| c.group('Position')}
      @title = "Characters by Position"
      erb :"census/group"
    end

    get '/census/crew/?' do
      @groups = Chargen.approved_chars.group_by { |c| c.group('Crew')}
      @title = "Characters by Crew"
      erb :"census/group"
    end

    get '/census/rank/?' do
      @groups = Chargen.approved_chars.group_by { |c| c.rank}
      @title = "Characters by Rank"
      erb :"census/group"
    end
    
    
  end
end