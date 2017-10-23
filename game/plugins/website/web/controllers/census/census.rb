module AresMUSH
  class WebApp
    
    helpers do
      def census_types
        [ 'gender', 'colony', 'faction', 'position', 'department', 'rank' ]
      end
    end
    
    get '/census/?' do
<<<<<<< HEAD
      @chars = Idle.active_chars.sort_by { |c| c.name }
=======
      @chars = Chargen.approved_chars.sort_by { |c| c.name }
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      erb :"census/all"
    end


    get '/census/gender/?' do
<<<<<<< HEAD
      @groups = Idle.active_chars.group_by { |c| c.demographic(:gender)}
=======
      @groups = Chargen.approved_chars.group_by { |c| c.demographic(:gender)}
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      @title = "Characters by Gender"
      erb :"census/group"
    end

    get '/census/colony/?' do
<<<<<<< HEAD
      @groups = Idle.active_chars.group_by { |c| c.group('Colony')}
=======
      @groups = Chargen.approved_chars.group_by { |c| c.group('Colony')}
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      @title = "Characters by Colony"
      erb :"census/group"
    end
    
    get '/census/faction/?' do
<<<<<<< HEAD
      @groups = Idle.active_chars.group_by { |c| c.group('Faction')}
=======
      @groups = Chargen.approved_chars.group_by { |c| c.group('Faction')}
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      @title = "Characters by Faction"
      erb :"census/group"
    end
    
    get '/census/position/?' do
<<<<<<< HEAD
      @groups = Idle.active_chars.group_by { |c| c.group('Position')}
=======
      @groups = Chargen.approved_chars.group_by { |c| c.group('Position')}
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      @title = "Characters by Position"
      erb :"census/group"
    end

    get '/census/department/?' do
<<<<<<< HEAD
      @groups = Idle.active_chars.group_by { |c| c.group('Department')}
=======
      @groups = Chargen.approved_chars.group_by { |c| c.group('Department')}
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      @title = "Characters by Department"
      erb :"census/group"
    end

    get '/census/rank/?' do
<<<<<<< HEAD
      @groups = Idle.active_chars.group_by { |c| c.rank}
=======
      @groups = Chargen.approved_chars.group_by { |c| c.rank}
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      @title = "Characters by Rank"
      erb :"census/group"
    end
    
    
  end
end