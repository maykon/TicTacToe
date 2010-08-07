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
  
  def draw_line(position)
    stroke black
    strokewidth 10
    @line_win << line(LINES[position][0], LINES[position][1], LINES[position][2], LINES[position][3])
  end
  
  def draw_player(player, position)
    @cells << image("figs/#{player}.png", CELLS[position])
  end
  	  	
	button "New Game", :width => 100 do
    # Clear the screen
  	@cells.each{ |d| d.remove }	
  	@line_win.each{ |d| d.remove }
  	
  	@win = false
    @tic = TicTacToe.new Player::X
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
           draw_player(@tic.pc, @tic.last_pc) # if @tic.last_pc != -1 && !@tic.game_board.completed?
         end
       end
       if @tic.result != false && @tic.result != "Velha" 
         @win = true
         pos = @tic.game_board.selected_cell
         draw_line(pos)
         if @tic.result == @tic.player
           alert("Parabéns! Você ganhou.")
         else
           alert("Que Pena! Você perdeu.")
         end
       end
       if @tic.result == "Velha"
         alert("Velha")
       end
     end
   end
 end
end