require './lib/reader'

class Readers
  READER_COUNT = 100000

  def initialize(readers)
    @readers = readers
  end

  def self.generate(subjects, interface)
    readers = (0..READER_COUNT).inject([]) do |readers, index|
      interface.print_generating_readers_update(index, READER_COUNT)
      readers << Reader.new(subjects.random, subjects.rest)
    end

    new(readers)
  end

  def population
    @readers.count
  end

  def percentage_of_population_interested_in_newspaper(newspaper)
    interested_in_newspaper(newspaper).count.to_f / population
  end

  def percentage_of_population_interested_in_subject(subject)
    interested_in_subject(subject).count.to_f / population
  end

  private

  def interested_in_newspaper(newspaper)
    @readers.select { |reader| reader.interested_in_newspaper? newspaper }
  end

  def interested_in_subject(subject)
    @readers.select { |reader| reader.interested_in? subject }
  end
end