require "csv"


if Game.count == 0
  Game.transaction do
    game = Game.create!(name: "7 Wonders (Classic)")

    header = true
    players = {}

    CSV.foreach("./db/data/7nudow_classic.csv") do |row|
      if header
        header = false
        index = 2
        player_names = row.slice(index + 1, row.size)
        players = player_names.map do |name|
          [index += 1, Player.create!(name: name)]
        end
      else
        date = Date.parse(row[0].split(' ').first)
        match = Match.create!(game: game, played_at: date)
        players.each do |index, player|
          if row[index].present? # if person played that time
            Score.create!(match: match, player: player, points: row[index].to_i)
          end
        end
      end
    end
  end
end