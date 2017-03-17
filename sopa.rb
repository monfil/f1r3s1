require 'matrix'

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
    #template = @@templates[2]
    board = template[1]
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

  def include?(template)
    template[0].each do |item|
      search_rows(item, template[1])
      search_columns(item, template[1])
      search_diagonal(item, template[1])
    end
  end

  def search_rows(word, board)
    row = 0
    board.scan(/...../).each do |item|
      return p "Se encontró la palabra #{word} en la fila #{row}." if item.include? word
      return p "Se encontró la palabra #{word} al revés en la fila #{row}." if item.include? word.reverse
      row += 1
    end
  end

  def search_columns(word, board)
     for column in 0..4
      palabra = board[column]
      for row in 5..35
        palabra += board[column + row] if row % 5 == 0
      end
      return p "Se encontró la palabra #{word} en la columna #{column}." if palabra.include? word
      return p "Se encontró la palabra #{word} al revés en la columna #{column}." if palabra.include? word.reverse
    end
  end

  def search_diagonal(word, board)
    grid = board.scan(/...../)
    matrix = Matrix[*grid.map{|item| item.split(//)}]
    array_with_words = walk_grid(matrix.to_a)
    array_with_words << walk_grid(matrix.transpose.to_a)
    array_with_words << walk_grid_inverse(matrix.to_a)
    array_with_words.flatten!.uniq!
    array_with_words.each do |item|
      return p "Se encontró la palabra #{word} en forma diagonal." if item.include? word or item.include? word.reverse
    end
   end

  def walk_grid(grid)
    top_row = grid.length-1
    top_letter = grid[1].length-1
    row = top_row
    col = 0
    count_letter = 0
    count_row = 0
    get_word = ""
    array_words = []  

    while count_row <= top_row
      while count_letter <= top_letter do
        for x in 0..count_letter
          get_word += grid[row - count_row + x][col + x]
        end
        array_words << get_word
        get_word = ""
        count_letter += 1
        count_row += 1 
      end
      diff = count_letter - top_letter
      count_letter = top_letter if diff > 0
    end
    array_words
  end

  def walk_grid_inverse(grid)
    top_row = grid.length-1
    top_letter = grid[1].length-1
    row = top_row
    col = 4
    count_letter = 0
    count_row = 0
    get_word = ""
    array_words_inverse = []

    while count_row <= top_row
      while count_letter <= top_letter do
        for x in 0..count_letter
          get_word += grid[row - count_row + x][col - x]
        end
        array_words_inverse << get_word
        get_word = ""
        count_letter += 1
        count_row += 1 
      end
      diff = count_letter - top_letter
      count_letter = top_letter if diff > 0
    end
    array_words_inverse
  end

  private

  def complete_board!
    @@templates.each{ |template| template[1].gsub!(/X/) {("A".."Z").to_a[rand(26)]} }
  end
end

board = Board.new
puts board