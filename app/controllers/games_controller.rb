require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    word = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)
    legit = params[:word].split('').all? { |letter| params[:letters].include?(letter) }
    english = word['found']
    length = word['length']
    if !legit
      @response = "Sorry, but #{params[:word]} can't be built out of the original grid"
    elsif !english
      @response = "Sorry, but #{params[:word]} is valid according to the grid, but is not a valid English word"
    else
      @response = "Congrats, #{params[:word]} is valid according to the grid and is an English word"
    end
    session[:scores] << length
  end
end

# The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
