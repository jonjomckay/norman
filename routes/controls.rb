require 'buuren'

class Norman < Sinatra::Base
  decks = Buuren::Decks.new(:database => 'jukebox_jonjo_server_development')

  # GET /play
  get '/controls/play' do
    decks.play

    render :rabl, :'controls/index'
  end

  # GET /pause
  get '/controls/pause' do
    if decks.playing?
      decks.pause
    else
      decks.play
    end

    render :rabl, :'controls/index'
  end

  # GET /next_track
  get '/controls/next_track' do
    decks.next_track

    render :rabl, :'controls/index'
  end
end