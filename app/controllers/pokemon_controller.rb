class PokemonController < ApplicationController
  def show

    @request = params[:id]
    @pokemon_data = JSON.parse(HTTParty.get('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'))
    api_key = ENV['GIFY_KEY']
    @gify_data = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{@request}&limit=25&offset=0&rating=G&lang=en")["data"][0]["url"]
    @api_data = []
    image = []
    @pokemon_data["pokemon"].each do |pokemon|

      pokemon_hash           =   {}
      pokemon_hash["id"]     =   pokemon["id"]
      pokemon_hash["name"]   =   pokemon["name"]
      pokemon_hash["types"]  =   pokemon["type"]
      pokemon_hash["gif"]    =   HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{pokemon["name"]}&limit=25&offset=0&rating=G&lang=en")["data"][0]["url"]

      @api_data.push(pokemon_hash)

      

      end
    end

end
