class Norman < Sinatra::Base

  # GET /
  get '/albums' do
    @albums = Album.all

    render :rabl, :'albums/index'
  end

  # POST /
  post '/albums' do
    begin
      # TODO: Make this look pretty
      album_criteria = Album.where(name: params[:name], mbid: params[:mbid], year: params[:year], artist_id: params[:artist_id])
      if album_criteria.exists?
        @album = album_criteria.first

        headers["Location"] = "/albums/#{@album.id}"
        status 303 # return 303 see other
      else
        @album = Album.create!(name: params[:name], mbid: params[:mbid], year: params[:year], artist: Artist.find(params[:artist_id]))

        # return 201 created & location of new resource
        headers["Location"] = "/albums/#{@album.id}"
        status 201
        render :rabl, :'albums/show'
      end
    rescue Mongoid::Errors::DocumentNotFound
      status 404 # throw a 404 not found
      render :rabl, :'status/404'
    rescue
      status 400 # throw a 400 bad request
      render :rabl, :'status/400'
    end
  end

  # GET /:id
  get '/albums/:id' do
    begin
      @album = Album.find(params[:id])
      render :rabl, :'albums/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # PUT /:id
  put '/albums/:id' do
    begin
      @album = Album.find(params[:id])
      @album.update_attributes(params)

      render :rabl, :'albums/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # DELETE /:id
  delete '/albums/:id' do
    begin
      Album.find(params[:id]).delete

      status 204 # return 204
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end
end