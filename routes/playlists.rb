class Norman < Sinatra::Base

  # GET /
  get '/playlists' do
    @playlists = Playlist.all
    @display_total = true

    render :rabl, :'playlists/index'
  end

  # POST /
  post '/playlists' do
    begin
      # TODO: Make this look pretty
      playlist_criteria = Playlist.where(name: params[:name])
      if playlist_criteria.exists?
        @playlist = playlist_criteria.first

        headers["Location"] = "/playlists/#{@playlist.id}"
        status 303 # return 303 see other
      else
        @playlist = Playlist.create!(params)

        # return 201 created & location of new resource
        headers["Location"] = "/playlists/#{@playlist.id}"
        status 201
        render :rabl, :'playlists/show'
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
  get '/playlists/:id' do
    begin
      @playlist = Playlist.find(params[:id])
      render :rabl, :'playlists/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # PUT /:id
  put '/playlists/:id' do
    begin
      @playlist = Playlist.find(params[:id])
      @playlist.update_attributes(params)

      # fix track ids
      params[:track_ids].each do |i|
        begin
          track = Track.find(i)
          @playlist.tracks.create!(:track => track)
        rescue BSON::InvalidObjectId
          @error = 'Track was not found'
          halt 400, render(:rabl, :'status/400')
        end
      end

      render :rabl, :'playlists/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # DELETE /:id
  delete '/playlists/:id' do
    begin
      Playlist.find(params[:id]).delete

      status 204 # return 204
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end
end