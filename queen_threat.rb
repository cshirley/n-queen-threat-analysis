# frozen_string_literal: true

# Analysis list of queen coordinates for board of size n.2
# Returns list of queen positions with threats
# find_all returns hash of coord to threat count
class QueenThreat
  attr_reader :board_size
  def initialize(queen_positions: [0, 1, 2, 3])
    @queen_positions = queen_positions
    @board_size = queen_positions.length
    @threats = {}
  end

  def find_all
    @threats = {}
    @check_count = 0
    @queen_positions.each_with_index do |x, y|
      coord = Struct::Coord.new(x, y)
      @threats[coord.key] = []
      find_threats_for(coord: coord)
    end
    format_threats
  end

  private

  Struct.new('Coord', :x, :y) do
    def key
      "#{x},#{y}"
    end
  end

  SEARCH_PATHS = [{ x: -1, y: -1 }, { x: -1, y: 1 }, { x: 1, y: -1 }, { x: 1, y: 1 }].freeze

  def format_threats
    data = {}
    @threats.each { |k, v| data[k] = v.length unless v.empty? }
    data
  end

  def find_threats_for(coord:)
    ts = SEARCH_PATHS.map { |v| check_direction(coord: coord, x_direction: v[:x], y_direction: v[:y]) }.compact.flatten
    ts.each do |t|
      add_threat(key: coord.key, coord: t)
      add_threat(key: t.key, coord: coord)
    end
  end

  def check_direction(coord:, x_direction:, y_direction:)
    return nil if axis?(coord: coord)
    @check_count += 1
    next_coord = Struct::Coord.new(coord.x + x_direction, coord.y + y_direction)
    if @threats.key?(next_coord.key)
      next_coord
    else
      check_direction(coord: next_coord, x_direction: x_direction, y_direction: y_direction)
    end
  end

  def axis?(coord:)
    coord.y.negative? || coord.x.negative? || coord.x >= board_size || coord.y >= board_size
  end

  def add_threat(key:, coord:)
    @threats.key?(key) ? @threats[key] << coord : @threats[key] = [coord]
  end
end
