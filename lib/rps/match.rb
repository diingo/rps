
module RPS
  class Match
    attr_reader :id
    attr_accessor :p_1, :p_2
    @@counter = 0

    def initialize
      @@counter += 1
      @id = @@counter
      @p_1 = nil
      @p_2 = nil
    end
  end
end