module RPS

  class Round
    attr_reader :match_id, :winner_id, :id, :loser_id, :p1_choice, :p2_choice
    @@counter = 0

    def initialize(attrs)
      @@counter += 1
      @id = @@counter

      @match_id = attrs[:match_id]
      @winner_id = attrs[:winner_id]
      @loser_id = attrs[:loser_id]

      @p1_choice = attrs[:p1_choice]
      @p2_choice = attrs[:p2_choice]
    end
  end
end