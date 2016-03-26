require 'pp'

class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    player = game_state["players"].detect do |k, v|
      v['name'] = "Thoughtful Duck"
    end
    pp game_state, '*' * 80, game_state["current_buy_in"]
    (100..player['stack']).to_a.shuffle.sample
  rescue
    (100..1000).to_a.shuffle.sample
  end

  def showdown(game_state)
    pp game_state
  end
end
