require "sleep2/version"

class Sleep2
  include Comparable

  def self.[] duration
    new duration
  end

  attr_accessor :duration, :sleep_proc
  attr_writer :new

  def initialize duration
    if duration.class.ancestors.include?(Numeric)
      @duration = duration.to_f
    elsif duration.class == self.class
      @duration = duration.duration.to_f
    else
      raise TypeError, "can't convert #{duration.class} into time interval"
    end
    @new = true
  end

  def new?
    @new
  end

  def inspect
    # Avoids sleeping the first time it is called (the moment of instantiation)
    unless new?
      self.sleep_proc.call
    else
      self.new   = false
      self.sleep_proc = proc { sleep duration }
    end
  end

  def [] new_duration
    self.duration = new_duration
  end

  # Creates new sleep instance by calculating it with integer
  [:*, :/, :+, :-, :%, :**].each do |m|
    define_method m do |num|
      num = num.duration if num.kind_of? self.class
      self.class[ duration.public_send(m, num) ]
    end
  end

  # Makes sleep instance comparable with another object of its type and integer
  def <=>(other)
    if other.kind_of? self.class
      self.duration <=> other.duration
    elsif other.kind_of? Integer
      self.duration <=> other
    end
  end
end
