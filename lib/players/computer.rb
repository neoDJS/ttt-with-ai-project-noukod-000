module Players
  class Computer < Player
    move = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    def move(board)
      self.getAnInteger
    end
  end
end
