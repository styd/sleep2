require "sleep2/version"

class Sleep2
  MATH_OPERATORS = %i[* / + - % **]

  include Comparable

  def self.[](duration)
    new duration
  end

  attr_accessor :duration

  def initialize(time_interval)
    if time_interval.class.ancestors.include?(Numeric)
      self.duration = time_interval.to_f
    elsif time_interval.class == self.class
      self.duration = time_interval.duration.to_f
    else
      msg = "can't convert #{time_interval.class} into time interval"
      raise TypeError, msg
    end
    undef go_to_sleep if defined? go_to_sleep
  end

  def inspect
    # Avoids sleeping the first time it is called (the moment of instantiation)
    slept = go_to_sleep rescue nil
    return if slept
    def go_to_sleep
      sleep duration
    end
  end

  def [](new_duration)
    self.duration = new_duration
  end

  # Creates new sleep instance by calculating it with integer
  MATH_OPERATORS.each do |m|
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
