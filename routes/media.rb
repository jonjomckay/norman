require 'buuren'

class Norman < Sinatra::Base
  decks = Buuren::Decks.new(:database => 'jukebox_jonjo_server_development')

  # GET /play
  get '/media/play' do
    decks.play

    render :rabl, :'media/index'
  end

  # GET /pause
  get '/media/pause' do
    if decks.playing?
      decks.pause
    else
      decks.play
    end

    render :rabl, :'media/index'
  end

  # GET /next_track
  get '/media/next_track' do
    decks.next_track

    render :rabl, :'media/index'
  end
end