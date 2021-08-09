require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @message = ''
    @score = 0
    @guess = params[:word].upcase
    @url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    @letters = params[:letters]
    json = open(@url).read
    objs = JSON.parse(json)
    if objs['found']
      @guess.split('').each do |letter|
        if @letters.include?(letter)
          @score += 1
        else
          @message = 'Error one or more characters in guess not in given letters'
          break
        end
      end
    else
      @message = 'That\'s not an English word'
    end
  end
end
