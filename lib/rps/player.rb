module RPS
  class Player
    attr_accessor :name
    attr_reader :id, :password

    @@counter = 0
    def initialize(name, pw)
      @name = name
      @password = pw

      @@counter += 1
      @id = @@counter
    end
  end
end