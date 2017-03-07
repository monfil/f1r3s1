class Board
    @@templates = [
      [["POEMA", "CANCION", "RONDAS", "RIMAS"],"POEMAXCXXXXAXXSXNXAAXCMXDXIXXNROXXOXNXXR"],
      [["MANGO", "SANDIA", "MELON", "PLATANO"],"XXXXPXXXXLXAMXAXIEXTXDLXAXNOXNMANGOXSXXX"],
      [["ROJO", "VERDE", "AZUL", "NEGRO"],"OJORXXXXXXXEXXOXDXRXXRGLXXEXUXNVXZXXXXAX"]
    ]
 
  def initialize
     complete_board!
  end

  def to_s
    template = @@templates[rand(0..@@templates.length-1)]
    board = template[1]
    p board
    for row in 0..7
      for col in 0..4
        print "#{board[col]} " if row == 0
        print "#{board[col + 5]} " if row == 1
        print "#{board[col + 10]} " if row == 2
        print "#{board[col + 15]} " if row == 3
        print "#{board[col + 20]} " if row == 4
        print "#{board[col + 25]} " if row == 5
        print "#{board[col + 30]} " if row == 6
        print "#{board[col + 35]} " if row == 7
      end
      puts
    end
  end

  private

  def complete_board!
    @@templates.each{ |template| template[1].gsub!(/X/) {("A".."Z").to_a[rand(26)] if template[1] == 'X'} }
  end
end

board = Board.new
puts board