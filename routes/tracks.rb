class Norman < Sinatra::Base

  # GET /
  get '/tracks' do
    @tracks = Track.all

    render :rabl, :'tracks/index'
  end

  # POST /
  post '/tracks' do
    begin
      # TODO: Make this look pretty
      track_criteria = Track.where(name: params[:name],
                                   mbid: params[:mbid],
                                   disc: params[:disc],
                                   track_number: params[:track_number],
                                   year: params[:year],
                                   artist_id: params[:artist_id],
                                   album_id: params[:album_id],
                                   filename: params[:filename])
      if track_criteria.exists?
        @track = track_criteria.first

        headers["Location"] = "/tracks/#{@track.id}"
        status 303 # return 303 see other
      else
        @track = Track.create!(params)

        # return 201 created & location of new resource
        headers["Location"] = "/tracks/#{@track.id}"
        status 201
        render :rabl, :'tracks/show'
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
  get '/tracks/:id' do
    begin
      @track = Track.find(params[:id])
      render :rabl, :'tracks/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # PUT /:id
  put '/tracks/:id' do
    begin
      @track = Track.find(params[:id])
      @track.update_attributes(params)

      render :rabl, :'tracks/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # DELETE /:id
  delete '/tracks/:id' do
    begin
      Track.find(params[:id]).delete

      status 204 # return 204
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end
end