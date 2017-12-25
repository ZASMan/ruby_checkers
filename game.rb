require_relative 'game_board_squares.rb'
require_relative 'game_piece_abilities.rb'
require 'pry'

module Checkers
  include GameBoardSquares
  include GamePieceAbilities

  class Player
    attr_accessor :player_name, :player_pieces, :player_no

    def initialize(player_no, player_name)
      @player_no = player_no
      @player_name = player_name
      @player_pieces = create_pieces
    end

    def create_pieces
      pieces = []
      20.times do |_piece|
        pieces << GamePiece.new(player_no, 'pawn')
      end
      pieces
    end
  end

  class GamePiece
    attr_accessor :player_no, :type, :moves

    def initialize(player_no, type)
      @player_no = player_no
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
    def initialize(player_one_name, player_two_name)
      @game_player_one = Player.new('P1', player_one_name)
      @game_player_two = Player.new('P2', player_two_name)
      @game_board = Board.new(
        @game_player_one.player_pieces,
        @game_player_two.player_pieces
      )
    end

    def display_game_board
      # TODO:
      # Should display a pattern of the board
      # Need to display the type and maybe player on each board?
      board.each do |row_no, squares|
        puts('')
        puts('____________________________________________________________________________________')
        %i[a b c d e f g h].each do |letter|
          if squares[letter] == []
            row_name = "#{row_no}#{letter.capitalize}:|"
            print(row_name)
            print(' ')
            print('|')
          else
            row_name = "#{row_no}#{letter.capitalize}:|"
            row_piece = "#{squares[letter].player_no}(#{squares[letter].type[0]})"
            print(row_name + row_piece)
            print('|')
          end
        end
      end
      board
    end

    def board
      @game_board.board_squares
    end

    def instruction_message
      puts(
        'Move should be input in the format' \
        "of '1A, 1B'."
      )
    end

    def game_player_move(_user_input)
      instruction_message
      user_input = gets.chomp
      parsed_move = parse_player_move(user_input)
      move_piece(parsed_move)
    end

    def move_piece(parsed_move); end

    def parse_player_move(user_input)
      # Format will be row, square, piece
      output = {
        position_a: [],
        position_b: []
      }
      user_input_aray = user_input.split(/\s*,\s*/)
      row = user_input_array[0][0]
      square = user_input_array[0][1]
      piece = @game_board.board_squares[row][square]
      output[position_a] = [row, square, piece]
      row = user_input_array[1][0]
      square = user_input_array[1][1]
      piece = @game_board.board_squares[row][square]
      output[position_b] = [row, square, piece]
      output
    end
  end
end
