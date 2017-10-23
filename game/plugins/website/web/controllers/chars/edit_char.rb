module AresMUSH
  class WebApp
    get '/char/:id/edit/?', :auth => :approved do |id|
<<<<<<< HEAD
      @char = Character.find_one_by_name(id)
      @files = uploaded_file_names.select { |f| f.start_with?(@char.name.downcase)}
=======
      @char = Character[id]
>>>>>>> parent of f74f1de2... Merge remote-tracking branch 'upstream/master'
      if (!@char)
        flash[:error] = "Character not found."
        redirect '/chars'
      end

      erb :"chars/edit_char"
    end
    
    post '/char/:id/edit', :auth => :approved do |id|
      @char = Character[id]
      
      if (!@char)
        flash[:error] = "Character not found."
        redirect '/chars'
      end
      
      if (!can_manage_char?(@char))
        flash[:error] = "You are not allowed to do that."
        redirect "/chars"
      end
      
      if (!@char.is_approved?)
        flash[:error] = "You can only edit approved characters."
        reedirect "/char/#{id}"
      end
                        
      demographics = {}
      profile = {}
      relationships = {}
      
      params.each do |k, v|
        if (k.start_with?('profiletitle-') && !v.blank?)
          name = k.after('-')
          profile[v] = params["profile-#{name}"]
        elsif (k.start_with?('demo-'))
          name = k.after('-')
          demographics[name] = v
        elsif (k.start_with?('relationname-') && !v.blank?)
          name = k.after('-')
          relationships[v] = { 
            'category' => params["relationcat-#{name}"],
            'relationship' => params["relationdetail-#{name}"]
          }
        end
      end
      
      demographics.each do |name, value|
        @char.update_demographic name, value
      end
      
<<<<<<< HEAD
      relationship_categories = (@params[:relationship_category_order] || "").split(',').map { |r| r.strip.titleize }
      @char.update(relationships_category_order: relationship_categories)
      
      @char.set_profile(profile)
      @char.update(bg_shared: params[:share_bg])
      @char.update(relationships: relationships)
      @char.update(profile_image: params[:profileimage] ? params[:profileimage].downcase : nil )
      @char.update(profile_icon: params[:profileicon] ? params[:profileicon].downcase : nil )
      @char.update(profile_gallery: params[:gallery] ? params[:gallery].downcase : nil )
=======
      @char.update(profile: profile)
      @char.update(relationships: relationships)
      @char.update(profile_image: params[:profileimage])
      @char.update(profile_gallery: params[:gallery])
>>>>>>> parent of f74f1de2... Merge remote-tracking branch 'upstream/master'
      
      flash[:info] = "Character updated!"
      redirect "/char/#{id}"
    end
  end
end