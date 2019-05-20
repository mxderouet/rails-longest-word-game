require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @input = params[:word]
    if includer?(@input, @letters) && english_word?(@input)
      @result = "Congratulations ! #{@input} is valid English word!"
    elsif includer?(@input, @letters) && !english_word?(@input)
      @result = "Sorry but #{@input} does not seem to be a valid English word..."
    else
      @result = "Sorry but #{@input} is not in the grid"
    end
  end

  def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
  end

  def includer?(input, grid)
    input.upcase.chars.all? do |letter|
      grid.chars.include?(letter)
    end
  end
end


