require 'pry'

# There is a board with 9 squares. 
# Player puts X in one of the squares. 
# Computer puts O in another. 
# They continue alternatively until its a tie or someone wins

# sq is abbreviated for squares

class Board
  attr_accessor :sq

  def initialize
    @sq = {}
    (1..9).each {|num| @sq[num] = " "}
  end

  def draw
    system 'clear'
    puts " #{@sq[1]} | #{@sq[2]} | #{@sq[3]} "
    puts "--------------"
    puts " #{@sq[4]} | #{@sq[5]} | #{@sq[6]} "
    puts "--------------"
    puts " #{@sq[7]} | #{@sq[8]} | #{@sq[9]} "
  end

  def empty_sq
    sq.select {|_k,v| v == " "}.keys
  end

end

class Player
  attr_accessor :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game

  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def initialize
    @board = Board.new
    @human = Player.new("Champ", "X")
    @computer = Player.new("Computer", "O")
    @current_player = @human
  end

  def play_again
    puts "Press P to play again. Any other key to exit."
    key = gets.chomp.downcase
    if key == "p"
      Game.new.play
    else
      puts "Bye!"
    end
  end

  def check_win?
    WINNING_LINES.each do |x, y, z|
      if @board.sq[x] == @board.sq[y] && @board.sq[x] == @board.sq[z] && @board.sq[x] != " "
        return true
      end
    end
    false
  end

  def switch_player
    if @current_player == @human
      @current_player = @computer
    elsif @current_player == @computer
      @current_player = @human
    end
  end

  def player_turn
    if @current_player == @human
      begin
        puts "Choose an empty square to put X. Select from 1-9"
        current_sq = gets.chomp.to_i
      end until @board.empty_sq.include?(current_sq)
    elsif @current_player == @computer
      current_sq = @board.empty_sq.sample
    end
    @board.sq[current_sq] << @current_player.marker
  end

  def play
    @board.draw

    loop do
      player_turn
      @board.draw
      if check_win?
        puts "#{@current_player.name} wins!"
        break
      elsif @board.empty_sq.empty?
        puts "Its a tie!"
        break
      else
        switch_player
      end
    end

    play_again
  end
end

Game.new.play
