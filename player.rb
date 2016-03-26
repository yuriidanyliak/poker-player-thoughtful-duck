require 'pp'

class Player

  VERSION = "Default Ruby folding player"

  # def game_state
  # 	{"tournament_id"=>"56e977803c01ba0003000002", "game_id"=>"56f652a43e900e0003000358", "round"=>0, "players"=>[{"name"=>"LockStock", "stack"=>1000, "status"=>"active", "bet"=>0, "version"=>"Lock, Stock and Two Smoking Barrels", "id"=>0}, {"name"=>"Monty Python", "stack"=>990, "status"=>"active", "bet"=>10, "version"=>"Unknown", "id"=>1}, {"name"=>"DuckOfDoom", "stack"=>980, "status"=>"active", "bet"=>20, "version"=>"Unknown", "id"=>2}, {"name"=>"Thoughtful Duck", "stack"=>1000, "status"=>"active", "bet"=>0, "hole_cards"=>[{"rank"=>"4", "suit"=>"spades"}, {"rank"=>"4", "suit"=>"clubs"}], "version"=>"Default Ruby folding player", "id"=>3}, {"name"=>"MadFoldBot", "stack"=>1000, "status"=>"active", "bet"=>0, "version"=>"Default JavaScript folding player", "id"=>4}, {"name"=>"TNT", "stack"=>1000, "status"=>"active", "bet"=>0, "version"=>"Unknown", "id"=>5}], "small_blind"=>10, "orbits"=>0, "dealer"=>0, "community_cards"=>[{"rank"=>"7", "suit"=>"spades"}, {"rank"=>"5", "suit"=>"clubs"}], "current_buy_in"=>20, "pot"=>30, "in_action"=>3, "minimum_raise"=>10, "bet_index"=>2}
  # end

  def bet_request(game_state)
    puts "Current buy in #{game_state["current_buy_in"]}"
  	minimum_raise = 0
  	minimum_raise = 100 if test_pair(game_state)
  	minimum_raise = 250 if test_set(game_state)
  	minimum_raise = 350 if test_pair_pair(game_state)
  	full_raise =!minimum_raise.zero? ? minimum_raise + game_state["current_buy_in"] : ((game_state["current_buy_in"] / 2).to_i..(game_state["current_buy_in"] + 20)).to_a.shuffle.sample
  rescue => err
  	puts err.inspect
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

  def group_cards(game_state)
	only_rank = game_state.group_by{|card| card['rank']}
	only_rank.each{|k, v| only_rank[k] = v.count}
  end

  def test_pair(game_state)
  	pair = 0
  	cards_on_table = group_cards(game_state['community_cards'])
  	all_cards = group_cards(player(game_state)['hole_cards'] + game_state['community_cards'])
    cards_on_table.each {|k, v| all_cards[k]-=1 if v==2}
    all_cards.each {|k,v| pair +=1 if v==2}
    return true if pair==1
    false
  end

   def test_pair_pair(game_state)
  	pair = 0
  	cards_on_table = group_cards(game_state['community_cards'])
  	all_cards = group_cards(player(game_state)['hole_cards'] + game_state['community_cards'])
    cards_on_table.each {|k, v| all_cards[k]-=1 if v==2}
    all_cards.each {|k,v| pair += 1 if v==2}
    return true if pair==2
    false
  end		

  def test_set(game_state)
 	pair = false
  	cards_on_table = group_cards(game_state['community_cards'])
  	all_cards = group_cards(player(game_state)['hole_cards'] + game_state['community_cards'])
    cards_on_table.each {|k, v| all_cards[k]-=1 if v==3}
    all_cards.each {|k,v| pair = true if v==3}
    pair
  end
end

# pp = Player.new
# p Player.new.bet_request(pp.game_state)
