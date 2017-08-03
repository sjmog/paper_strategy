require './lib/subjectable'

class Reader
  include Subjectable

  def initialize(likes, dislikes)
    super(likes)
  end

  def interested_in_newspaper?(newspaper)
    interest_in(newspaper) > 50
  end

  def interest_in(newspaper)
    (subjects_in_common_with(newspaper).length.to_f / newspaper.subjects_length ) * 100
  end
end