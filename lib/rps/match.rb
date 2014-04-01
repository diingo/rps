
module RPS
  class Match
    attr_reader :id
    @@counter = 0

    def initialize
      @@counter += 1
      @id = @@counter
    end
  end
end