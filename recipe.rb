class Recipe
  attr_accessor :name, :description, :prep_time, :difficulty
  def initialize(name, prep_time, difficulty, description)
    @name = name
    @prep_time = prep_time
    @difficulty = difficulty
    @description = description
    @done = false
  end

  def mark_as_done
    @done = true
  end

  def done?
    @done
  end
end
