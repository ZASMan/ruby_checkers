require_relative 'game_board_squares.rb'
require_relative 'game_piece_abilities.rb'

module Checkers
  include GameBoardSquares
  include GamePieceAbilities

  class Player
    attr_accessor :player_name, :player_pieces

    def initialize(player_name)
      @player_name = player_name
      @player_pieces = create_pieces
    end

    def create_pieces
      pieces = []
      20.times do |_piece|
        pieces << GamePiece.new('pawn')
      end
      pieces
    end
  end

  class GamePiece
    attr_accessor :type, :moves

    def initialize(type)
      @type = type
      @moves = GamePieceAbility.new(type)
    end
  end

  class GamePieceAbility
    attr_accessor :abilities

    def initialize(game_piece_type)
      @abilities = Checkers::PAWN_ABILITIES if game_piece_type == 'pawn'
      @abilities = Checkers::KING_ABILITIES if game_piece_type == 'king'
    end
  end

  class Board
    attr_accessor :board_squares

    def initialize(player_one_pieces, player_two_pieces)
      @board_squares = Checkers::GAME_BOARD_SQUARES
      place_game_pieces(player_one_pieces, player_two_pieces)
    end

    def place_game_pieces(player_one_pieces, player_two_pieces)
      # Rows for Player One
      [1, 2, 3, 4].each do |row|
        # First Row
        @board_squares[row][:a] = player_one_pieces.last
        player_one_pieces.pop
        @board_squares[row][:c] = player_one_pieces.last
        player_one_pieces.pop
        @board_squares[row][:e] = player_one_pieces.last
        player_one_pieces.pop
        @board_squares[row][:g] = player_one_pieces.last
        player_one_pieces.pop
        @board_squares[row][:j] = player_one_pieces.last
      end
      # Rows for Player Two
      [7, 8, 9, 10].each do |row|
        # First Row
        @board_squares[row][:a] = player_two_pieces.last
        player_two_pieces.pop
        @board_squares[row][:c] = player_two_pieces.last
        player_two_pieces.pop
        @board_squares[row][:e] = player_two_pieces.last
        player_two_pieces.pop
        @board_squares[row][:g] = player_two_pieces.last
        player_two_pieces.pop
        @board_squares[row][:j] = player_two_pieces.last
      end
    end
  end

  class Game
    def intialize(player_one_name, player_two_name)
      @game_player_one = Player.new(player_one_name)
      @game_player_two = Player.new(player_two_name)
      @game_board = Board.new(@player_one.player_pieces, @player_two.player_pieces)
    end

    def game_player_move(user_input)
      user_input = gets.chomp
    end

    def parse_player_move(user_input)
      # Should be format of
      # piece on 1A square to 2B square
      # Input: 1A, 2B
      # Chop that input and update the board
    end
  end
end
