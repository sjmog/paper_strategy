require './lib/subjectable'

class Newspaper
  include Subjectable

  BASE_CIRCULATION = 100

  attr_reader :name

  def initialize(name, *subjects)
    @name = name
    super(subjects)
  end

  def circulation(readers)
    BASE_CIRCULATION * readers.percentage_of_population_interested_in_newspaper(self)
  end
end