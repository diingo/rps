module RPS
  class Session
    attr_reader :id, :user_id
    @@counter = 0

    def initialize(uid)
      @@counter += 1
      @id = @@counter
      @user_id = uid
    end
  end
end