require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    session[:user_score] = 0 if session[:user_score].nil?
    @alphabets = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word].upcase
    @letter_check = true
    @alpha = params[:alpha].split('')
    @word.split('').each do |letter|
      @alpha.include?(letter) ? @alpha.delete_at(@alpha.index(letter)) : @letter_check = false
    end

    url = 'https://wagon-dictionary.herokuapp.com/' + @word
    word_check_serialized = open(url).read
    @word_check = JSON.parse(word_check_serialized)["found"]

    @score = @letter_check && @word_check ? JSON.parse(word_check_serialized)["length"] ** 2 : 0
    session[:user_score] += @score
  end

  def reset
    reset_session
    redirect_to '/new'
  end
end
