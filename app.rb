class App < Sinatra::Base
  TITLE = "WDB03 - CTEs and window functions"

  register Sinatra::ActiveRecordExtension

  if ENV["RACK_ENV"] != "production"
    get '/q' do
      @result = nil
      @rows = 10
      haml :'q/index'
    end

    post '/q' do
      @rows = [params[:query].count("\n") + 1, 10].max
      begin
        @result = Game.connection.select_all(params[:query])
      rescue ActiveRecord::StatementInvalid => e
        @error = e
      end

      haml :'q/index'
    end
  end

  get '/' do
    redirect '/data'
  end

  get '/data' do
    @game = Game.first
    @players = Player.order(:id).all
    @matches = @game.matches.includes(:scores).order(:played_at, :id).all

    haml :'data/index'
  end

  get '/cte' do
    haml :'cte/index'
  end

  get '/window-functions' do
    @data_first = [
      ["1", "Jarek", 38],
      ["1", "Beo", 31],
      ["1", "Irek",  52],
      ["1", "Dawid", 45],
      ["1", "Paweł", 61],
      ["1", "Majchał", 56]
    ]
    @data_second = [
      ["7", "Jarek", 59],
      ["7", "Beo", 71],
      ["7", "Irek",  50],
      ["7", "Dawid", 59],
      ["7", "Paweł", 79],
      ["7", "Majchał", 74]
    ]
    @header = [["match_id", "player", "points"]]
    @data = @header + @data_first + @data_second
    @first_rank = [5, 6, 3, 4, 1, 2]
    @second_rank = [4, 3, 6, 4, 1, 2]
    @data_first_ranked = @data_first.zip(@first_rank).map(&:flatten)
    @data_second_ranked = @data_second.zip(@second_rank).map(&:flatten)
    @ranked_data = [@header.flatten << "place"] + @data_first_ranked + @data_second_ranked

    haml :'window-functions/fn1'
  end

  get '/window-functions-framing' do
    @partitions = [
      [
        [2016, 3, 283],
        [2016, 3, 239],
        [2016, 3, 357]
      ],
      [
        [2016, 4, 190]
      ],
      [
        [2017, 1, 270],
        [2017, 1, 342],
        [2017, 1, 392],
        [2017, 1, 327],
        [2017, 1, 334],
        [2017, 1, 403],
        [2017, 1, 417],
        [2017, 1, 341],
        [2017, 1, 275],
        [2017, 1, 396],
        [2017, 1, 361],
        [2017, 1, 338],
        [2017, 1, 338],
        [2017, 1, 314],
        [2017, 1, 481],
        [2017, 1, 274],
        ["...", "...", "..."]
      ]
    ]
    @header = [["year", "quarter", "sum"]]
    @data = @header + @partitions[0] + @partitions[1] + @partitions[2]
    @data2 = [
      ["match_id", "player", "place", "points", "match_average", "better_than_average"],
      [1, "Paweł", 1, "61 of 283", 47.17, "yes"],
      [1, "Majchał", 2, "56 of 283", 47.17, "yes"],
      [1, "Irek", 3, "52 of 283", 47.17, "yes"],
      [1, "Dawid", 4, "45 of 283", 47.17, "no"],
      [1, "Jarek", 5, "38 of 283", 47.17, "no"],
      [1, "Beo", 6, "31 of 283", 47.17, "no"],
      [7, "Paweł", 1, "79 of 392", 65.33, "yes"],
      [7, "Majchał", 2, "74 of 392", 65.33, "yes"],
      [7, "Beo", 3, "71 of 392", 65.33, "yes"],
      [7, "Jarek", 4, "59 of 392", 65.33, "no"],
      [7, "Dawid", 4, "59 of 392", 65.33, "no"],
      [7, "Irek", 6, "50 of 392", 65.33, "no"]
    ]

    haml :'window-functions/fn2'
  end

  get '/exercises' do
    @data = [
      ["ID", "points", "quartile"],
      ["A", 10, 1],
      ["B", 20, 1],
      ["C", 30, 1],
      ["D", 40, 2],
      ["E", 50, 2],
      ["F", 60, 2],
      ["G", 70, 3],
      ["H", 80, 3],
      ["I", 90, 4],
      ["J", 100, 4]
    ]
    haml :'exercises/index'
  end

end



