
module RPS
  class Match
    attr_reader :id, :p1, :p2
    attr_accessor :winner
    @@counter = 0

    def initialize(p1_id, p2_id)
      @@counter += 1
      @id = @@counter
      
      @p1 = p1_id
      @p2 = p2_id
      @winner = nil
    end
  end
end