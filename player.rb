
class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    p game_state
    (100..1000).to_a.shuffle.sample
  end

  def showdown(game_state)

  end
end
