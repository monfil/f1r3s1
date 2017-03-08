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
    include?(template)
  end

  def include?(word)
    word[0].each do |item|
      search_rows(item, word[1])
      search_rows_reverse(item, word[1])
      search_columns(item, word[1])
    end
  end

  def search_rows(word, board)
    for row in 0..7
      for col in 0..35
        if board.byteslice(col, 5).include? word
          return p "Se encontró la palabra #{word} en la fila #{row}."
        else
          col += 5
        end
      end
    end
  end

  def search_rows_reverse(word, board)
    for row in 0..7
      for col in 0..35
        if board.byteslice(col, 5).include? word.reverse
          return p "Se encontró la palabra #{word} al revés en la fila #{row}."
        else
          col += 5
        end
      end
    end
  end

  def search_columns(word, board)
    for column in 0..4
      palabra = board[column]
      for row in 5..35
        palabra += board[column + row]
        row += 5
      end
      p palabra
    end
  end

  private

  def complete_board!
    @@templates.each{ |template| template[1].gsub!(/X/) {("A".."Z").to_a[rand(26)]} }
  end
end

board = Board.new
puts board