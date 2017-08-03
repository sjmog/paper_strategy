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
    @subjects.select { |subject| other.interested_in? subject }
  end
end