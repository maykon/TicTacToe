require 'tic-tac-toe'

Shoes.app :title => "Tic-Tac-Toe", :width => 460, :height => 500, :resizable => false do
  background white
  
  CELLS = [
      {:top => 40, :left => 7}, {:top => 40, :left => 155}, {:top => 40, :left => 305},
      {:top => 190, :left => 7}, {:top => 190, :left => 155}, {:top => 190, :left => 305},
      {:top => 335, :left => 7}, {:top => 335, :left => 155}, {:top => 335, :left => 305}
    ]
    
  LINES = [
      [15, 113, 445, 113], [15, 263, 445, 263], [15, 410, 445, 410],
      [85, 50, 85, 480], [230, 50, 230, 480], [380, 50, 380, 480],
      [17, 50, 445, 480], [17, 480, 445, 50]
    ]
  
  @cells = []
  @board = nil
  @line_win = []
  @win = false
  @totalX = 0
  @total0 = 0
  @turn_pc = false
  
  para "Jogador", :stroke => darkred
   @player = list_box :items => [Player::X, Player::CIRCLE],
      :width => 50, :choose => Player::X do |list|
   end
  
  def draw_line(position)
    stroke black
    strokewidth 10
    @line_win << line(LINES[position][0], LINES[position][1], LINES[position][2], LINES[position][3])
  end
  
  def draw_player(player, position)
    @cells << image("figs/#{player}.png", CELLS[position])
  end
  	  	
	button "New Game", :width => 100 do
    new_game!
  end
  
  @board = image('figs/board.png', :top => 35, :left => 0)

 9.times do |i|
   left = case(i)
            when 0, 3, 6 : 5
            when 1, 4, 7 : 150 
            when 2, 5, 8 : 300 
          end
   top = case(i)
          when 0, 1, 2 : 35
          when 3, 4, 5 : 185
          when 6, 7, 8 : 330
         end
   
   stack :width => 150, :height => 150, :left => left, :top => top do
     click do
       unless @win
         if @tic.game_board.verify(i)
           @tic.set(i)
           draw_player(@tic.player, i)
 
           @tic.set_pc 
           draw_player(@tic.pc, @tic.last_pc)
         end
         if @tic.result != false && @tic.result != "Velha" 
           @win = true
           pos = @tic.game_board.selected_cell
           draw_line(pos)
           
           set_placar
           
           if @tic.result == @tic.player
             alert("Parabéns! Você ganhou.")
             new_game
           else
             alert("Que Pena! Você perdeu.")
             new_game
           end
         end
         if @tic.result == "Velha"
           alert("Velha")
           new_game
         end
       end
      end
   end
 end
 
 def set_placar
   case(@tic.result)
     when Player::X :
       @totalX += 1
       @resultX.text = @totalX
     when Player::CIRCLE :
       @total0 += 1
       @result0.text = @total0
    end
 end
 
 def clear_placar
   @totalX = 0
   @resultX.text = @totalX
   @total0 = 0
   @result0.text = @total0
   @turn_pc = false
 end
 
 def new_game!
   clear_game
   clear_placar
   @turn_pc = false
 end
 
 def new_game
   clear_game
   
   if @turn_pc   
     @tic.set_pc 
     draw_player(@tic.pc, @tic.last_pc)
   end
 end
 
 def clear_game
   # Clear the screen
 	 @cells.each{ |d| d.remove }	
 	 @line_win.each{ |d| d.remove }
 	
 	 @win = false
 	 @turn_pc = @turn_pc == true ? false : true
   @tic = TicTacToe.new @player.text
 end
 
 para "Resultado X:", :stroke => darkred   
 @resultX = para "#{@totalX}", :stroke => black
 
 para " - "
 
 #para "#{Player.versus(@player.text)}", :stroke => darkred   
 para "O:", :stroke => darkblue   
 @result0 = para "#{@total0}", :stroke => black
end