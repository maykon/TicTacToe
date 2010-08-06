# class Array; include Comparable; end

class TicTacToe
  attr_accessor :game_board, :player, :pc
  
  def initialize(player)
    @player = player
    @pc = case(player)
            when Player::CIRCLE : Player::X
            when Player::X : Player::CIRCLE
          end
    @game_board = GameBoard.new @player, @pc
  end
  
  def state
    @game_board.game_board
  end
  
  def set(position)   
    @game_board.set(position)
  end
  
  def result
     @game_board.result
  end
  
  def last_pc
    @game_board.last_pc
  end
end

class GameBoard
  attr_accessor :game_board, :player, :pc, :result, :win, :last_pc, :selected_cell
  
  CELL = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
          [0, 3, 6], [1, 4, 7], [2, 5, 8],
          [0, 4, 8], [2, 4, 6]]
  
  def initialize(player, pc)
    @player, @pc = player, pc
    @game_board = ["_"] * 9
    @win = false
    @last_pc = -1
    @selected_cell = -1
    @result = false
    @velha = true
    init_conj
  end
  
  def set(position)
    if verify(position)
      @game_board[position] = @player
    
      status = win?
      if status && @win == false
        win
      end
    
      set_pc if !completed? && @win == false
    end
  end
  
  def verify(position)
    return true if @game_board[position] == "_" && position >= 0 && position <= 8 && @win == false
    false
  end
  
  def win
    @win = true
    puts "Ganhador: #{@result}"
    puts "Posição: #{@selected_cell} - #{CELL[@selected_cell]}" if @selected_cell != -1
  end
  
  def init_conj
    @r_player = []
    @r_pc = []

    @r_player = [@player] * 3
    @r_pc = [@pc] * 3
  end
  
  def win?
    status = @win
    unless @win 
      CELL.each_with_index do |cell, index|
        if group(cell) == @r_player
          @result = @player
          @selected_cell = index        
          @velha = false
          status = true
          break
        elsif group(cell) == @r_pc
          @result = @pc
          @selected_cell = index
          @velha = false
          status = true        
          break
        end
      end
      if completed? && @velha
        @result = "Velha" 
        status = true
      end
    end
    status
  end
  
  def group(conj)
    ma = []
    conj.each { |i| ma << @game_board[i] }
    ma
  end
  
  def completed?
    @game_board.each do |p|
      return false if p == "_"
    end
    true
  end
  
  def set_pc
    position = -1
    loop do
      position = rand(9)
      break if verify(position)
    end
    @last_pc = position
    @game_board[position] = @pc
  end
  
  def to_s
    result = "["
    result << @game_board[0..2].collect { |i| i }.join(", ")
    result << "\n"
    result << @game_board[3..5].collect { |i| i }.join(", ")
    result << "\n"
    result << @game_board[6..8].collect { |i| i }.join(", ")
    result.gsub! /,$/, ""
    result << "]"
  end
end

class Player
  CIRCLE = "0"
  X = "X"
end

# tic = TicTacToe.new Player::X
# #tic.game_board.game_board = ["_"] * 9
# #p tic.game_board.completed?
# tic.set 1
# puts tic.game_board.game_board
# puts tic.last_pc
# 
# tic.set 5
# puts tic.game_board.game_board
# puts tic.last_pc