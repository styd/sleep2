require "sleep2/version"

class Sleep2
  include Comparable

  attr_accessor :time, :time_of_instantiation

  def initialize time
    @time_of_instantiation = Time.now
    @time = time.to_f
  end

  def inspect
    # Avoid sleeping the first time it is called (the moment of instantiation)
    unless Time.now - time_of_instantiation <= 0.1
      sleep time
    end
  end

  # Make sleep instance can be calculated with integer
  [:*, :/, :+, :-, :%, :**].each do |m|
    define_method m do |num|
      num = num.time if num.kind_of? self.class
      sleep time.public_send(m, num)
    end
  end

  # Make sleep instance comparable with another object of its type and integer
  def <=>(other)
    if other.kind_of? self.class
      self.time <=> other.time
    elsif other.kind_of? Integer
      self.time <=> other
    end
  end
end
