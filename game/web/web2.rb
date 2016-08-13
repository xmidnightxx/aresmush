module AresMUSH
  class AresWeb
  
    get '/api/characters' do
      content_type :json      
      Character.all
    end
  
    get '/api/characters/:id' do
      content_type :json      
      Character.find params[:id]
    end
    
    get '/foobar' do
      "FOOBAR3"
    end
    
  end
end
