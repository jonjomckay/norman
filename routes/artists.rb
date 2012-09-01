class Norman < Sinatra::Base

  # GET /
  get '/artists' do
    @artists = Artist.all

    render :rabl, :'artists/index'
  end

  # POST /
  post '/artists' do
    begin
      # TODO: Make this look pretty
      artist_criteria = Artist.where(name: params[:name],
                                     mbid: params[:mbid],
                                     disambiguation: params[:disambiguation],
                                     real_name: params[:real_name])
      if artist_criteria.exists?
        @artist = artist_criteria.first

        headers["Location"] = "/artists/#{@artist.id}"
        status 303 # return 303 see other
      else
        @artist = Artist.create!(params)

        # return 201 created & location of new resource
        headers["Location"] = "/artists/#{@artist.id}"
        status 201
        render :rabl, :'artists/show'
      end
    rescue Mongoid::Errors::DocumentNotFound
      status 404 # throw a 404 not found
      render :rabl, :'status/404'
    rescue Mongoid::Errors::Validations => e
      status 400 # throw a 400 bad request
      @error = e.message
      render :rabl, :'status/400'
    rescue
      status 400 # throw a 400 bad request
      render :rabl, :'status/400'
    end
  end

  # GET /:id
  get '/artists/:id' do
    begin
      @artist = Artist.find(params[:id])
      render :rabl, :'artists/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # PUT /:id
  put '/artists/:id' do
    begin
      @artist = Artist.find(params[:id])
      @artist.update_attributes(params)

      render :rabl, :'artists/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # DELETE /:id
  delete '/artists/:id' do
    begin
      Artist.find(params[:id]).delete

      status 204 # return 204
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end
end