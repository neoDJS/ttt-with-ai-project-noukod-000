class Game
  attr_reader :board, :player_1, :player_2
  def initialize
    @board = Board.new
    @player_1 = Player.new("X")
    @player_2 = Player.new("O")
  end

    # Define your WIN_COMBINATIONS constant
   WIN_COMBINATIONS = [
     [0,1,2], # Top row
     [3,4,5],  # Middle row
     [6,7,8], # Bottom row
     [0,3,6],  # Middle row
     [1,4,7], # Top row
     [2,5,8],  # Middle row
     [0,4,8], # Top row
     [2,4,6]  # Middle row
     # ETC, an array for each win combination
   ]

  def current_player
    self.board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    # index = input_to_index(input)
    if self.board.valid_move?(input)
      player = self.current_player
      self.board.update(player.move(self.board), player)
      self.board.display
    else
      self.turn
    end
  end

  def start
    #Player.reset_all
  end

  def won?
    WIN_COMBINATIONS.detect{|case_set| case_set.all?{|case_i| self.board.position(case_i.to_s) == "X"} || case_set.all?{|case_i| self.board.position(case_i.to_s) == "O"}}
  end

  def winner
    Player.all.detect{|p| p.token == self.won?[0]}
  end

  def play
    until over?
      turn
    end

    if draw?
      puts "Cat's Game!"
    elsif WIN_COMBINATIONS.include?(self.won?)
      puts "Congratulations #{winner}!"
    end
  end

  def draw?
    self.board.full? && !WIN_COMBINATIONS.include?(self.won?)
  end

  def over?
    won? || draw?
  end
end
