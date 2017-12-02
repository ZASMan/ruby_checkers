require_relative 'game_board_squares.rb'

module Checkers
  include GameBoardSquares

  class Player
    attr_accessor :player_name, :player_pieces

    def initialize(player_name)
      @player_name = player_name
      @player_pieces = create_pieces
    end

    def create_pieces
      pieces = []
      20.times do |piece|
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
      @abilities = pawn_abilities if game_piece_type == 'pawn'
      @abilities = king_abilities if game_piece_type == 'king'
    end

    def pawn_abilities
      {
        diaganol_left_forward: true,
        diaganol_left_backward: false,
        diaganol_right_forward: true,
        diaganol_right_backward: false,
      }
    end

    def king_abilities
      {
        diaganol_left_forward: true,
        diaganol_left_backward: true,
        diaganol_right_forward: true,
        diaganol_right_backward: true,
      }
    end
  end

  class Board
    attr_accessor :board_squares

    def initialize(player_one_pieces, player_two_pieces)
      @board_squares = Checkers::GAME_BOARD_SQUARES
      place_game_pieces(player_one_pieces, player_two_pieces)
    end

    def place_game_pieces(player_one_pieces, player_two_pieces)
      @board_squares.each do |row|
        row.each_with_index do |square, index|
          square = player_one_pieces.last if index.even?
          player_one_pieces.pop
        end
      end
    end
  end

  class Game
    def intialize(player_one_name, player_two_name)
      @game_player_one = Player.new(player_one_name)
      @game_player_two = Player.new(player_two_name)
      @game_board = Board.new(@player_one.player_pieces, @player_two.player_pieces)
    end
  end
end

player_one = Checkers::Player.new('Player One')
player_two = Checkers::Player.new('Player Two')
Checkers::Board.new(player_one.pieces, player_two.pieces)
