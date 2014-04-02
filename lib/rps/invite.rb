module RPS
  class Invite
    attr_reader :id, :inviter_id, :invitee_id, :pending
    @@counter = 0

    def initialize(inviter_id, invitee_id)
      @@counter += 1
      @id = @@counter

      @inviter_id = inviter_id
      @invitee_id = invitee_id
      @pending = true
    end
  end
end