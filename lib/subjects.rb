require './lib/subject'

class Subjects
  include Enumerable
  POSSIBLE_SUBJECTS = [
    :local_news,
    :technology,
    :science,
    :sport,
    :music,
    :lifestyle,
    :art
  ].freeze

  NUMBER_OF_SUBJECTS_MAP = {
    1 =>  1,
    2 =>  2,
    3 =>  2,
    4 =>  2,
    5 =>  2,
    6 =>  2,
    7 =>  2,
    8 =>  2,
    9 =>  2,
    10 => 2,
    11 => 2,
    12 => 3,
    13 => 3,
    14 => 3,
    15 => 3,
    16 => 4
  }.freeze

  def initialize(subjects)
    @subjects = subjects
  end

  def self.generate
    subjects = POSSIBLE_SUBJECTS.map do |name|
      Subject.new(name)
    end

    new(subjects)
  end

  def random
    @chosen = random_subjects.map { |name| Subject.new(name) }
  end

  def rest
    POSSIBLE_SUBJECTS - @chosen
  end

  def each(&block)
    @subjects.each(&block)
  end

  private

  def random_subjects
    POSSIBLE_SUBJECTS.sample(number_of_subjects)
  end

  def number_of_subjects
    NUMBER_OF_SUBJECTS_MAP[rand(1..16)]
  end
end