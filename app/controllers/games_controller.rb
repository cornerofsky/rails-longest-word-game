require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10).join
  end

  def score
    @array = params[:letters].split(//).map(&:downcase)
    response = call_dictionary(params["word"])
    @score = session[:current_score] += 0
    @message = ''
    # binding.pry
    if response["error"]
      @message = "Sorry but #{response["word"]} is not a word"
    elsif (response["word"].split(//) - @array).empty?
      session[:current_score] += response["length"]
      @message = "Great job! #{response["word"]} is worth #{response["length"]} points."
    else
      @message = "Sorry but #{response["word"]} cannot be built out of #{@array}"
    end
  end

  def call_dictionary(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    response = JSON.parse(response)
  end
end


