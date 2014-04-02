module RPS

  class Round
    attr_reader :match_id, :winner_id, :id
    @@counter = 0

    def initialize(match_id, winner_id)
      @@counter += 1
      @id = @@counter
      
      @match_id = match_id
      @winner_id = winner_id
    end
  end
end