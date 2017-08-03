class Interface
  def initialize(output = STDOUT)
    @output = output
  end

  def print_welcome_message
    print_line
    print_line "Welcome to the Media game!"
    print_line
    print_line "People have different interests, and your paper can have its own subjects."
    print_line "Over time, people will simulate a change in their interests due to both their own conversation and the current domination of subjects in the newspapers."
    print_line "Your job is to choose which subjects to cover to beat the other competitive newspapers out there."
  end

  def print_generating_message
    print_line
    print_line "Generating all entities:"
    print_line
  end

  def print_generating_readers_update(index, reader_count)
    return clear_over if index == reader_count
    print_over "Generating reader #{index} / #{reader_count}"
  end

  def print_newspapers(newspapers, readers)
    newspapers.each_with_index do |newspaper, index|
      print_line("#{index + 1}: #{newspaper.name} (#{newspaper.pretty_subjects}) [Circulation #{ newspaper.circulation(readers).round(1) }%]")
    end
  end

  def print_subjects(subjects, readers)
    print_line
    subjects.each do |subject|
     print_line "Number of people interested in #{ subject.pretty_name }: #{ (readers.percentage_of_population_interested_in_subject(subject) * 100).round(1) }%"
    end
  end

  private

  def print_line(thing = "")
    @output.print "#{thing}\n"
  end

  def print_over(thing = "")
    print_line("\e[1A\r#{thing}")
  end

  def clear_over
    print_over " " * 100
  end
end