module DataHelpers

  def self.classes_for_score(match, score)
    if score
      podium = match.podium_points

      case score.points
      when podium[0]
        "place_1"
      when podium[1]
        "place_2"
      when podium[2]
        "place_3"
      end
    end
  end

  def self.model_info(model)
    s = "#{model.name} (#{model.table_name})\n"
    s << model.columns.map do |column|
      column.name
    end.join("\n")
    s
  end

  def self.format_number(num)
    sprintf("%0.02f", num)
  end

  def self.table(data, header: true, labels: {}, selected: [], attach_column: nil, border: [])
    if !attach_column.nil?
      data = data.zip(attach_column).map(&:flatten)
    end
    border_map = border.map { |x| [x, true] }.to_h
    selected_map = selected.map { |x| [x, true] }.to_h
    Haml::Engine.new(File.read('views/shared/_data.haml')).render(
      Object.new,
      data: data,
      header: header,
      labels: labels,
      selected: selected_map,
      border: border_map
    )
  end
end
