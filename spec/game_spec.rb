require_relative '../game.rb'

describe 'Player' do
  let(:player) { Checkers::Player.new('andy') }
  it 'can initialize a player with a name' do
  	player
  	expect(player.player_name).to eq 'andy'
  end

  it 'initializes a player with all game pieces as pawns' do
  	player
  	first_piece = player.player_pieces.first
  	expect(first_piece.type).to eq 'pawn'
    last_piece = player.player_pieces.last
    expect(last_piece.type).to eq 'pawn'
  end
end

describe 'GamePiece' do
  let(:pawn_piece) { Checkers::GamePiece.new('pawn') }
  let(:pawn_abilities) do
    {
      diaganol_left_forward: true,
      diaganol_left_backward: false,
      diaganol_right_forward: true,
      diaganol_right_backward: false,
    }
  end

  let(:king_abilities) do
    {
      diaganol_left_forward: true,
      diaganol_left_backward: true,
      diaganol_right_forward: true,
      diaganol_right_backward: true,
    }
  end

  it 'creates a pawn piece with appropriate abilities' do
  	pawn_piece
  	expect(pawn_piece.moves.abilities[:diaganol_left_forward]).to eq true
  	expect(pawn_piece.moves.abilities[:diaganol_right_forward]).to eq true
    expect(pawn_piece.moves.abilities[:diaganol_left_backward]).to eq false
    expect(pawn_piece.moves.abilities[:diaganol_right_backward]).to eq false
  end
end

describe 'Board' do
  let(:player_one) { Checkers::Player.new('andy') }
  let(:player_two) { Checkers::Player.new('sid') }
  let(:game_board) do
    Checkers::Board.new(
  	  player_one.player_pieces,
  	  player_two.player_pieces
  	)
  end

  before do
    player_one
    player_two
    game_board
  end

  it 'creates an 8x8 square board' do
  	# Height
  	expect(game_board.board_squares.length).to eq 8
  	# Width
  	expect(game_board.board_squares[1].length).to eq 8
  end

  it 'places each players board pieces on the board' do
    first_row_square = game_board.board_squares[1][:a]
    expect(first_row_square.class.to_s).to eq 'GamePiece' 
  end
end
