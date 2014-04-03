module RPS
  class CreateInvite < UseCase
    def run(inputs)
      return failure(:invitee_nonexistent) if RPS.db.get_player(inputs[:invitee_id]).nil?

      session = RPS.db.get_session(inputs[:session_key])

      invite = RPS.db.create_invite(session.user_id, inputs[:invitee_id])
      
      inviter_name = RPS.db.get_player(session.user_id).name
      invitee_name = RPS.db.get_player(inputs[:invitee_id]).name

      success({ invite: invite, inviter_name: inviter_name, invitee_name: invitee_name})
    end
  end
end