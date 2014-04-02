
class Client

  def start
    puts sign_in_prompt
    puts " > "
    initial_input = gets.chomp.to_i

    sign_in if initial_input == 1
    sign_up if initial_input == 2

    puts play_prompt

  end

  def sign_in
    puts "Please enter your username:"
    @username = gets.chomp
    puts "Please enter your password:"
    password = gets.chomp

    @session_key = RPS.db.sign_in(@username, password)

    # result = SignInUser.run(:username => username, :password => password)
    # if result.success?
    #   @session_key = result.session_key
    # else
    #   puts "Incorrect username/password"
    # end
  end

  def active_matches
    RPS.db.active_matches(@session_key)
  end

  def match_play(mid)
    RPS.db.play
  end

  def play_prompt
<<-eos
Welcome, #{@username}!
You have #{active_matches.count} active match(es).
  users list - List all users
  match list - List active matches
  match play MID - Start playing game with id=MID
  invites - List game invites
  invite accept IID - Accept invite with id=IID
  invite create UID - Invite user with id=UID to play a game
eos
  end

  def sign_in_prompt
<<-eos
[1] Sign in
[2] Sign up
eos
  end

end