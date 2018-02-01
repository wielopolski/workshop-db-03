class Match < ActiveRecord::Base
  belongs_to :game

  has_many :scores

  before_save :store_date_components_separately

  # Returns array of poitns required for podium, example: [76, 56, 20].
  def podium_points
    points_per_place = []

    # 1st
    data = scores
    points_per_place << data.max { |a, b| a.points <=> b.points }.points

    # 2nd
    data = data.select { |s| s.points != points_per_place[-1] }
    points_per_place << data.max { |a, b| a.points <=> b.points }.points

    # 3rd
    data = data.select { |s| s.points != points_per_place[-1] }
    points_per_place << data.max { |a, b| a.points <=> b.points }.points

    points_per_place
  end

  # Calculates average for already loaded scores thus elimnating N+1 query.
  def average_score
    scores.inject(0) { |total, score| total + score.points } / scores.size.to_f
  end

  private

  def store_date_components_separately
    self.day     = played_at.day
    self.month   = played_at.month
    self.year    = played_at.year
    self.wday    = played_at.wday
    self.quarter = ((played_at.month - 1) / 3).to_i + 1
  end
end