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