module RPS
  def self.db
    @__db_instance ||= DB.new
  end
  
  class DB
    def initialize
      @match = {}
    end
  end
end