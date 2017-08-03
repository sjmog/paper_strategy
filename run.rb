module Subjectable
  def initialize(subjects)
    @subjects = subjects.flatten
  end

  def pretty_subjects
    @subjects.map(&:pretty_name).join(", ")
  end

  def interested_in?(subject)
    @subjects.include? subject
  end

  protected

  attr_reader :subjects

  def subjects_length
    @subjects.length
  end

  def subjects_in_common_with(other)
    @subjects.select do |subject| 
      other.subjects.include? subject
    end
  end
end

class Newspaper
  include Subjectable

  BASE_CIRCULATION = 100

  attr_reader :name

  def initialize(name, *subjects)
    @name = name
    super(subjects)
  end

  def circulation
    BASE_CIRCULATION * Reader.percentage_of_population_interested_in_newspaper(self)
  end
end

class Reader
  include Subjectable
  @@readers = []

  def initialize(likes, dislikes)
    super(likes)
    @@readers << self
  end

  def self.population
    @@readers.count
  end

  def self.percentage_of_population_interested_in_newspaper(newspaper)
    (interested_in_newspaper(newspaper).count.to_f / population)
  end

  def self.percentage_of_population_interested_in_subject(subject)
    (interested_in_subject(subject).count.to_f / population)
  end

  def interested_in_newspaper?(newspaper)
    interest_in(newspaper) > 50
  end

  def interest_in(newspaper)
    (subjects_in_common_with(newspaper).length.to_f / newspaper.subjects_length ) * 100
  end

  private

  def self.interested_in_newspaper(newspaper)
    @@readers.select { |reader| reader.interested_in_newspaper? newspaper }
  end

  def self.interested_in_subject(subject)
    @@readers.select { |reader| reader.interested_in? subject }
  end
end

def expect(expectation, expected, actual)
  green = "\e[92m"
  red = "\e[91m" 
  no_color = "\e[0m"
  print "#{expected == actual ?  green : red}#{expectation} should be #{expected}, is: #{actual}#{no_color}\n"
end

# TESTS
#times = Newspaper.new("Times", :sport, :music)
#reader = Reader.new(:sport, :music)

#expect('reader interest', 100.0, reader.interest_in(times))
#expect('newspaper circulation', 100.0, times.circulation)


#telegraph = Newspaper.new("Telegraph", :sport)

#expect('reader interest', 50.0, reader.interest_in(telegraph))
#expect('newspaper circulation', 0.0, telegraph.circulation)

#reader_2 = Reader.new(:sport)
#expect('reader interest', 100.0, reader_2.interest_in(telegraph))
#expect('newspaper circulation', 50.0, telegraph.circulation)
# END TESTS

class Subject
  attr_reader :name

  def initialize(name, liked = true)
    @name = name
    @liked = liked
  end

  def pretty_name
    name.to_s.gsub("_", " ").capitalize
  end

  def ==(other)
    @name == other.name
  end
end

class Subjects
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

  def self.random
    @@chosen = POSSIBLE_SUBJECTS.sample(number).map { |name| Subject.new(name) }
  end

  def self.rest
    POSSIBLE_SUBJECTS - @@chosen
  end

  private

  def self.number
    NUMBER_OF_SUBJECTS_MAP[rand(1..16)]
  end
end

possible_newspaper_names = [
  "The Daily Star",
  "The Daily Mail",
  "The Daily Courier",
  "The Daily Telegraph",
  "The Mirror",
  "The Guardian",
  "The S*n"
]

in_game_newspapers = possible_newspaper_names.sample(4).map do |name|
  Newspaper.new(name, Subjects.random)
end

def print_line(thing = "")
  print "#{thing}\n"
end

def print_over(thing = "")
  print_line("\e[1A\r#{thing}")
end

def clear_over
  print_over " " * 100
end

print_line
print_line "Welcome to the Media game!"
print_line
print_line "People have different interests, and your paper can have its own subjects."
print_line "Over time, people will simulate a change in their interests due to both their own conversation and the current domination of subjects in the newspapers."
print_line "Your job is to choose which subjects to cover to beat the other competitive newspapers out there."
print_line
print_line "Generating readers:"

READER_NUMBER = 100000

readers = (0..READER_NUMBER).to_a.inject([]) do |readers, i|
  print_over "Generating reader #{i + 1} / 100000"
  readers << Reader.new(Subjects.random, Subjects.rest)
end

clear_over
print_over "Generating newspapers:"

in_game_newspapers.each_with_index do |newspaper, index| 
  clear_over if index.zero?
  print_line("#{index + 1}: #{newspaper.name} (#{newspaper.pretty_subjects}) [Circulation #{ newspaper.circulation.round(1) }%]")
end

print_line

Subjects::POSSIBLE_SUBJECTS.each do |name|
  subject = Subject.new(name)
  print_line "Number of people interested in #{ subject.pretty_name }: #{ (Reader.percentage_of_population_interested_in_subject(subject) * 100).round(1) }%"
end

print_line
