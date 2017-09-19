require "spec_helper"

RSpec.describe Sleep2 do
  it "has a version number" do
    expect(Sleep2::VERSION).not_to be nil
  end

  let!(:duration) { rand 1..3 }

  it "does not sleep when instantiating" do
    start = `date +%s`.to_i
    delay = Sleep2[duration]

    # rspec stops ruby from calling `inspect` to return value when instantiating
    # sleep2 needs the `inspect` to be called
    delay.inspect # similar to the result of Sleep2[duration] or Sleep2.new(duration) outside rspec

    finish = `date +%s`.to_i
    expect((finish - start).abs).to be <= 1
  end

  it "sleeps according to specified duration" do
    start = `date +%s`.to_i
    delay = Sleep2[duration]

    # rspec stops ruby from calling `inspect` to return value when instantiating
    # sleep2 needs the `inspect` to be called
    delay.inspect # similar to the result of Sleep2[duration] or Sleep2.new(duration) outside rspec
    delay.inspect # really calling it to run the sleep for the duration specified

    finish = `date +%s`.to_i
    expect((duration - (finish - start)).abs).to be <= 1
  end

  it "does not sleep when changing duration" do
    start = `date +%s`.to_i
    delay = Sleep2[duration]

    # rspec stops ruby from calling `inspect` to return value when instantiating
    # sleep2 needs the `inspect` to be called
    delay.inspect # similar to the result of Sleep2[duration] or Sleep2.new(duration) outside rspec

    delay[duration + 3]

    finish = `date +%s`.to_i
    expect((finish - start).abs).to be <= 1
  end

  context "when doing math" do
    it "does not sleep" do
      start = `date +%s`.to_i
      sleep = Sleep2[duration]

      # rspec stops ruby from calling `inspect` to return value when instantiating
      # sleep2 needs the `inspect` to be called
      delay = sleep * 2
      delay.inspect # similar to the result of Sleep2[duration] or Sleep2.new(duration) outside rspec

      finish   = `date +%s`.to_i
      expect((finish - start).abs).to be <= 1
    end

    context "with integers" do
      it "is like doing math with all operands of type integers" do
        an_integer = 2
        sleep = Sleep2[duration]
        delay = sleep * an_integer
        expect(duration * an_integer).to eq(delay.duration)
      end
    end

    context "with sleep2 objects" do
      it "is like doing math with all operands of type integers" do
        time_interval = 3
        freeze = Sleep2[time_interval]
        sleep  = Sleep2[duration]
        delay  = sleep + freeze
        expect(duration + time_interval).to eq(delay.duration)
      end
    end
  end

  context "when compared with an integer" do
    it "is like comparing between two integers" do
      sleep  = Sleep2[duration]
      expect(sleep).to be < duration + 1
      expect(sleep).to be > duration - 1
    end
  end

  context "when compared with other object of the same type" do
    it "is like comparing between two integers" do
      sleep      = Sleep2[duration]
      more_sleep = Sleep2[duration + 1]
      less_sleep = Sleep2[duration - 1]
      expect(sleep).to be < more_sleep
      expect(sleep).to be > less_sleep
    end
  end
end
