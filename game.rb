# There is a board with 9 squares. 
# Player puts X in one of the squares. 
# Computer puts O in another. 
# They continue alternatively until its a tie or someone wins

class Board
  attr_accessor :sq, :empty_sq

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
    @empty_sq = @sq.select {|k,v| v == " "}.keys
  end

end

class Player
  attr_accessor :player, :marker

  def initialize(player, marker)
    @player = player
    @marker = marker
  end
end

class Game

  def switch_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def player_turn
    begin
      if @current_player == @human
        begin
          puts "Choose an empty square to put X. Select from 1-9"
          current_sq = gets.chomp.to_i
        end until @board.empty_sq.include?(current_sq)
      else
        current_sq = @board.empty_sq.sample
      end
      @board.sq[current_sq] << @current_player.marker
      @board.draw
      switch_player
    end until @board.empty_sq.empty?
    puts "Its a tie!"
  end

  def play
    @board = Board.new
    @board.draw
    @human = Player.new("Champ", "X")
    @computer = Player.new("Computer", "O")
    @current_player = @human
    player_turn

    # sleep 3
    # @board.sq[1] << "x"
    # @board.draw
  end
end

Game.new.play
