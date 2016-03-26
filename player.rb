require 'pp'
require 'json'

class Player

  VERSION = "BOM BOM"

  def bet_request(game_state)
    puts "Current buy in #{game_state["current_buy_in"]}"
    return 5000 if cards(game_state).count > 4 && rain_man(game_state)['rank'] > 4
    return 0 if cards(game_state).count > 4 && rain_man(game_state)['rank'] < 1
  	minimum_raise = 0
  	minimum_raise = 100 if test_pair(game_state)
  	minimum_raise = 400 if test_set(game_state)
  	minimum_raise = 600 if test_pair_pair(game_state)
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

  def rain_man(game_state)
    JSON.load `curl -XGET -d 'cards=#{cards(game_state).to_json}' http://rainman.leanpoker.org/rank`
  end

  def cards(game_state)
    player(game_state)['hole_cards'] + game_state['community_cards']
  end
end

