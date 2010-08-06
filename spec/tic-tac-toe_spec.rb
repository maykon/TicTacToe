require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TicTacToe do  
  before do
    player = Player::X
    @tic = TicTacToe.new player
  end
  
  it "should be initialize with 9 spaces" do
    @tic.state.should == ["_", "_", "_",
                              "_", "_", "_",
                              "_", "_", "_"]
  end
  
  it "should set a piece in a space" do
    #tic = TicTacToe.new TicTacToe::CIRCLE
    
    board = ["X", "_", "_",
            "_", "_", "_",
            "_", "_", "_"]
    
    @tic.set 0    
    board[@tic.last_pc] = @tic.pc
    @tic.state.should == board
    
    @tic.set 1
    board[1] = @tic.player
    board[@tic.last_pc] = @tic.pc
    @tic.state.should == board
                              
    @tic.set 10
    @tic.state.should == board
                              
    @tic.set -11
    @tic.state.should == board
  end
  
  it "should show the result" do
    @tic.set 0
    @tic.set 1
    @tic.set 2
    @tic.set 3
    @tic.set 4
    @tic.set 5
    @tic.set 6
    @tic.set 7
    @tic.set 8
        
    ["X", "0", "Velha"].include?(@tic.result).should be_true
  end
end
