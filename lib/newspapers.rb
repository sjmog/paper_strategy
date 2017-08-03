require './lib/newspaper'

class Newspapers
  include Enumerable

  POSSIBLE_NAMES = [
    "The Daily Star",
    "The Daily Mail",
    "The Daily Courier",
    "The Daily Telegraph",
    "The Mirror",
    "The Guardian",
    "The S*n"
  ].freeze

  def initialize(newspapers)
    @newspapers = newspapers
  end

  def self.generate(subjects)
    newspapers = POSSIBLE_NAMES.sample(4).map do |name|
      Newspaper.new(name, subjects.random)
    end

    new(newspapers)
  end

  def each(&block)
    @newspapers.each(&block)
  end

  def each_with_index(&block)
    @newspapers.each_with_index(&block)
  end
end