
module RPS
  class Match
    attr_reader :id, :p1_id, :p2_id
    attr_accessor :winner
    @@counter = 0

    def initialize(p1_id, p2_id)
      @@counter += 1
      @id = @@counter
      
      @p1_id = p1_id
      @p2_id = p2_id
      @winner = nil
    end
  end
end