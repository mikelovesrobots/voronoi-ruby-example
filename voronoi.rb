#!/usr/bin/env ruby
MAP_WIDTH = 60
MAP_HEIGHT = 20
NUM_POINTS = 12

class Biome
  attr :point, :glyph
  def initialize(point, glyph)
    @point = point
    @glyph = glyph
  end
end

class Point
  attr :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.distance(p1, p2)
    sum_of_squares = 0
    sum_of_squares += (p1.x - p2.x) ** 2
    sum_of_squares += (p1.y - p2.y) ** 2
    Math.sqrt(sum_of_squares)
  end
end

def generate_point
  x = rand(0..MAP_WIDTH)
  y = rand(0..MAP_HEIGHT)
  Point.new(x, y)
end

def generate_biomes
  glyphs = ('a'..'z').to_a.shuffle
  (0..NUM_POINTS).collect do
    Biome.new(generate_point, glyphs.pop)
  end
end

def find_closest_biome(p)
  @biomes.sort_by { |biome| Point.distance(p, biome.point) }[0]
end

@biomes = generate_biomes
(0..MAP_HEIGHT).each do |y|
  (0..MAP_WIDTH).each do |x|
    point = Point.new(x, y)
    biome = find_closest_biome(point)
    print biome.glyph
  end
  print "\n"
end

