
class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    minimum_raise = 0

    game_state['current_buy_in'].to_i - game_state['players']['in_action']['bet'].to_i  + minimum_raise
  end

  def showdown(game_state)

  end
end
