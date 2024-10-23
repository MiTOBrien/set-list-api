class Api::V1::SongsController < ApplicationController
  def index
    render json: Song.all
  end

  def show
    render json: Song.find(params[:id])
  end

  def post
    render json: Song.create(song_params)
  end

  private

  def song_params
    params.require(:song).permit(:title, :length, :play_count )
  end
end