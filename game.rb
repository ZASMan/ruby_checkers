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
