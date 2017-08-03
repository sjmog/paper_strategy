require './lib/interface'
require './lib/readers'
require './lib/newspapers'
require './lib/subjects'

class Game
  def initialize(interface = Interface.new)
    @interface = interface
  end

  def self.run
    new.run
  end

  def run
    @interface.print_welcome_message
    @interface.print_generating_message

    subjects   = Subjects.generate
    readers    = Readers.generate(subjects, @interface)
    newspapers = Newspapers.generate(subjects)

    @interface.print_newspapers(newspapers, readers)
    @interface.print_subjects(subjects, readers)
  end
end