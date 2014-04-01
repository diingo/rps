
module RPS
  class Match
    attr_reader :id
    attr_reader :p_1, :p_2
    @@counter = 0

    def initialize(p1_id, p2_id)
      @@counter += 1
      @id = @@counter
      @p_1 = p1_id
      @p_2 = p2_id
    end
  end
end