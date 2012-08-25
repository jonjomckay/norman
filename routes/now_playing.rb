class Norman < Sinatra::Base

  # GET /
  get '/now_playing' do
    @now_playings = NowPlaying.all

    render :rabl, :'now_playing/index'
  end

  # POST /
  post '/now_playing' do
    begin
      @now_playing = NowPlaying.create(track: Track.find(params[:track_id]))

      # return 201 created & location of new resource
      headers["Location"] = "/now_playing/#{@now_playing.id}"
      status 201
      render :rabl, :'now_playing/show'
    rescue Mongoid::Errors::DocumentNotFound
      status 404 # throw a 404 not found
      render :rabl, :'status/404'
    rescue
      status 400 # throw a 400 bad request
      render :rabl, :'status/400'
    end
  end

  # DELETE /
  delete '/now_playing' do
    NowPlaying.delete_all

    status 204 # return 204 no content
  end

  # GET /:id
  get '/now_playing/:id' do
    begin
      @now_playing = NowPlaying.find(params[:id])
      render :rabl, :'now_playing/show'
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # PUT /:id
  put '/now_playing/:id' do
    begin
      @now_playing = NowPlaying.find(params[:id])

      if defined? params[:position]
        position = params[:position]

        if position =~ /^[-+]?[0-9]+$/
          # if $position is an Integer, then cast to integer and move to new position
          @now_playing.move_to! position.to_i
          status 204 # return 204
        elsif %w'top bottom higher lower'.include? position
          # else if $position is a string and supported by mongoid_orderable, then move to new direction
          @now_playing.move_to! :"#{position}"
          status 204 # return 204
        else
          # else $position is not an integer or a supported string
          status 400 # throw a 400 bad request
          render :rabl, :'status/400'
        end
      else
        status 400 # throw a 400 bad request
        render :rabl, :'status/400'
      end
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end

  # DELETE /:id
  delete '/now_playing/:id' do
    begin
      NowPlaying.find(params[:id]).remove_from_list
      NowPlaying.find(params[:id]).delete

      status 204 # return 204
    rescue
      status 404
      render :rabl, :'status/404'
    end
  end
end