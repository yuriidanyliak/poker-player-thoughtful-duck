
class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    minimum_raise = 0

    game_state[current_buy_in] - game_state[players][in_action][bet]  + minimum_raise
  end

  def showdown(game_state)

  end
end
