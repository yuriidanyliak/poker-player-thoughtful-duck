require_relative 'player.rb'

player = Player.new

stub = {"tournament_id"=>"56e977803c01ba0003000002",
         "game_id"=>"56f6562d3e900e0003000370",
         "round"=>6,
         "players"=>
             [{"name"=>"LockStock",
               "stack"=>3090,
               "status"=>"active",
               "bet"=>0,
               "version"=>"Lock, Stock and Two Smoking Barrels",
               "amount_won"=>30,
               "id"=>0},
              {"name"=>"Monty Python",
               "stack"=>0,
               "status"=>"out",
               "bet"=>0,
               "version"=>"Default Python folding player",
               "id"=>1},
              {"name"=>"DuckOfDoom",
               "stack"=>1910,
               "status"=>"folded",
               "bet"=>0,
               "version"=>"Default JavaScript folding player",
               "id"=>2},
              {"name"=>"Thoughtful Duck",
               "stack"=>0,
               "status"=>"out",
               "bet"=>0,
               "hole_cards"=>[],
               "version"=>"Default Ruby folding player",                                                                                                                                                                             "id"=>3},
              {"name"=>"MadFoldBot",
               "stack"=>0,
               "status"=>"out",
               "bet"=>0,
               "version"=>"Default JavaScript folding player",
               "id"=>4},
              {"name"=>"TNT",
               "stack"=>0,
               "status"=>"out",
               "bet"=>0,
               "version"=>"Default JavaScript folding player",
               "id"=>5}],
         "small_blind"=>10,
         "orbits"=>1,
         "dealer"=>0,
         "community_cards"=>[
             {
                 "rank": "4",
                 "suit": "spades"
             },
             {
                 "rank": "A",
                 "suit": "hearts"
             },
             {
                 "rank": "6",
                 "suit": "clubs"
             }
         ],
         "current_buy_in"=>0,
         "pot"=>0}


puts player.bet_request(stub).inspect