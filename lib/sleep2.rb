require "sleep2/version"

class Sleep2
  include Comparable

  def self.[] duration
    new duration
  end

  attr_accessor :duration, :sleep2
  attr_writer :new

  def initialize duration
    @duration = duration.to_f
    @new      = true
  end

  def new?
    @new
  end

  def inspect
    # Avoid sleeping the first time it is called (the moment of instantiation)
    unless new?
      self.sleep2.call
    else
      self.new   = false
      self.sleep2 = proc { sleep duration }
    end
  end

  # Make sleep instance can be calculated with integer
  [:*, :/, :+, :-, :%, :**].each do |m|
    define_method m do |num|
      num = num.duration if num.kind_of? self.class
      self.class[ duration.public_send(m, num) ]
    end
  end

  # Make sleep instance comparable with another object of its type and integer
  def <=>(other)
    if other.kind_of? self.class
      self.duration <=> other.duration
    elsif other.kind_of? Integer
      self.duration <=> other
    end
  end
end
