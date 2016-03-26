require 'pp'

class Player

  VERSION = "Default Ruby folding player"

  # def game_state
  # 	{"tournament_id"=>"56e977803c01ba0003000002", "game_id"=>"56f652a43e900e0003000358", "round"=>0, "players"=>[{"name"=>"LockStock", "stack"=>1000, "status"=>"active", "bet"=>0, "version"=>"Lock, Stock and Two Smoking Barrels", "id"=>0}, {"name"=>"Monty Python", "stack"=>990, "status"=>"active", "bet"=>10, "version"=>"Unknown", "id"=>1}, {"name"=>"DuckOfDoom", "stack"=>980, "status"=>"active", "bet"=>20, "version"=>"Unknown", "id"=>2}, {"name"=>"Thoughtful Duck", "stack"=>1000, "status"=>"active", "bet"=>0, "hole_cards"=>[{"rank"=>"A", "suit"=>"spades"}, {"rank"=>"4", "suit"=>"clubs"}], "version"=>"Default Ruby folding player", "id"=>3}, {"name"=>"MadFoldBot", "stack"=>1000, "status"=>"active", "bet"=>0, "version"=>"Default JavaScript folding player", "id"=>4}, {"name"=>"TNT", "stack"=>1000, "status"=>"active", "bet"=>0, "version"=>"Unknown", "id"=>5}], "small_blind"=>10, "orbits"=>0, "dealer"=>0, "community_cards"=>[{"rank"=>"A", "suit"=>"spades"}, {"rank"=>"5", "suit"=>"clubs"}], "current_buy_in"=>20, "pot"=>30, "in_action"=>3, "minimum_raise"=>10, "bet_index"=>2}
  # end

  def bet_request(game_state)
  	minimum_raise =  has_pair_or_set?(game_state) ? 400 + (game_state["current_buy_in"]..1000).to_a.shuffle.sample : (game_state["current_buy_in"]..1000).to_a.shuffle.sample
  	game_state['current_buy_in'] + minimum_raise
  rescue => err
  	puts err
    (100..1000).to_a.shuffle.sample
  end

  def showdown(game_state)
  	p game_state
  end

  private

  def player(game_state)
  	game_state['players'].each do |player|
		return player if player['name'] == 'Thoughtful Duck'
  	end
  end

  def has_pair_or_set?(game_state)
  	all_cards = player(game_state)['hole_cards'] + game_state['community_cards']
	only_rank = all_cards.map {|card| card['rank']}
	return false if only_rank.uniq.count == all_cards.count
	true
  end
end

# p Player.new.bet_request
