require 'rails_helper'

# OPTIONAL TESTING FOR DATA TO BE USED IN ALL TESTS
# RSpec.describe "Songs API Endpoints" do
#   before(:each) do
#     Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
#     Song.create(title: "Bad Romance", length: 295, play_count: 5)
#     Song.create(title: "Shake It Off", length: 219, play_count: 2)
#   end
# Can also be Rspec.describe and "Songs API" is a descritor - you can name it what you want as long as it is meaningful
describe "Songs API" do  
  it "sends a list of songs" do
    #SETUP - What object/things do we need to set up for our test
    Song.create(title: "Wrecking Ball", length: 220, play_count: 3)
    Song.create(title: "Bad Romance", length: 295, play_count: 5)
    Song.create(title: "Shake It Off", length: 219, play_count: 2)

    #EXECUTION - What operation must be performed first
    get '/api/v1/songs'

    songs = JSON.parse(response.body, symbolize_names: true)

    #ASSERTION - This is what we are actually testing
    expect(response).to be_successful
    expect(songs.count).to eq(3)

    #Check for the keys that you care about --- Check that the data type of the VALUE is what you expect (string/integer/etc)
    songs.each do |song|
      expect(song).to have_key(:id)
      expect(song[:id]).to be_an(Integer)

      expect(song).to have_key(:title)
      expect(song[:title]).to be_a(String)

      expect(song).to have_key(:length)
      expect(song[:length]).to be_a(Integer)

      expect(song).to have_key(:play_count)
      expect(song[:play_count]).to be_a(Integer)
    end
  end

  it "can get one song by its id" do
    id = Song.create(title: "Wrecking Ball", length: 220, play_count: 3).id
  
    get "/api/v1/songs/#{id}"
  
    song = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
  
    expect(song).to have_key(:id)
    expect(song[:id]).to be_an(Integer)
  
    expect(song).to have_key(:title)
    expect(song[:title]).to be_a(String)
  
    expect(song).to have_key(:length)
    expect(song[:length]).to be_a(Integer)
  
    expect(song).to have_key(:play_count)
    expect(song[:play_count]).to be_a(Integer)
  end

  it "can create a new song" do
    song_params = {
                    title: "Wrecking Ball",
                    length: 220,
                    play_count: 3
    }
    headers = { "CONTENT_TYPE" => "application/json" }
    # We include this header to make sure that these params are passed as JSON rather than as plain text
  
    post "/api/v1/songs", headers: headers, params: JSON.generate(song: song_params)
    created_song = Song.last
  
    expect(response).to be_successful
    expect(created_song.title).to eq(song_params[:title])
    expect(created_song.length).to eq(song_params[:length])
    expect(created_song.play_count).to eq(song_params[:play_count])
  end
end

#Put in spec helper
# RSpec.configure do |config|
#   config.formatter = :documentation
# end