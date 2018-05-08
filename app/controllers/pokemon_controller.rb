class PokemonController < ApplicationController
  def show

    @pokemon_data = JSON.parse(HTTParty.get('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json').body)["pokemon"]
    api_key = ENV['GIFY_KEY']
    # @gify_data = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{@request}&limit=25&offset=0&rating=G&lang=en")["data"][0]["url"]
    @pokemon_hash = {}

    if params[:id].to_i > 0
      # if params is an integer find the correct pokemon
      @pokemon_data.each do |pokemon|

        if pokemon["id"].to_s == params[:id].to_s
          @pokemon_hash["id"] = pokemon["id"]
          @pokemon_hash["name"] = pokemon["name"]
          @pokemon_hash["type"] = pokemon["type"]
          @pokemon_hash["url"] = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{pokemon["name"]}&limit=25&offset=0&rating=G&lang=en")["data"][0]["url"]

          end

        end

      else
      # if params is the name of pokemon the url would be the params
        @pokemon_data.each do |pokemon|

        if pokemon["name"].downcase == params[:id].downcase
          @pokemon_hash["id"] = pokemon["id"]
          @pokemon_hash["name"] = pokemon["name"]
          @pokemon_hash["type"] = pokemon["type"]
          @pokemon_hash["url"] = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{pokemon["name"]}&limit=25&offset=0&rating=G&lang=en")["data"][0]["url"]
        else

        end
      end
    end

      respond_to do |format|

        format.html {render }
        format.json {render json: {
            id: @pokemon_hash["id"],
            name: @pokemon_hash["name"],
            type: @pokemon_hash["type"],
            gif: @pokemon_hash["url"]

          }}

      end

    end

end
