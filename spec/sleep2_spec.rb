require "spec_helper"

describe Sleep2 do
  it "has a version number" do
    expect(Sleep2::VERSION).not_to be nil
  end

  let!(:duration) { rand(1..3) }

  it "does not sleep when instantiating" do
    start = `date +%s`.to_i
    delay = Sleep2[duration]

    # sleep2 needs the `inspect` to be called
    delay.inspect # this is what is called after instantiation outside rspec

    finish = `date +%s`.to_i
    expect((finish - start).abs).to be <= 1
  end

  it "sleeps according to specified duration" do
    start = `date +%s`.to_i
    delay = Sleep2[duration]

    # sleep2 needs the `inspect` to be called
    delay.inspect # this is what is called after instantiation outside rspec
    delay.inspect # it's the same as just calling `delay` outside rspec

    finish = `date +%s`.to_i
    expect((duration - (finish - start)).abs).to be <= 1
  end

  it "does not sleep when changing duration" do
    start = `date +%s`.to_i
    delay = Sleep2[duration]

    delay[duration + 3]

    finish = `date +%s`.to_i
    expect((finish - start).abs).to be <= 1
  end

  it "works for multiple sleeps" do
    start = `date +%s`.to_i

    duration1 = rand(1..3)
    delay  = Sleep2[duration]

    # sleep2 needs the `inspect` to be called
    delay.inspect # this is what is called after instantiation outside rspec
    delay.inspect # it's the same as just calling `delay` outside rspec

    duration2 = rand(1..3)
    freeze = Sleep2[duration2]

    # sleep2 needs the `inspect` to be called
    freeze.inspect # this is what is called after instantiation outside rspec
    freeze.inspect # it's the same as just calling `freeze` outside rspec

    finish = `date +%s`.to_i
    expect(((duration1 + duration2) - (finish - start)).abs).to be <= 1
  end

  context "when doing math" do
    it "does not sleep" do
      start = `date +%s`.to_i
      sleep = Sleep2[duration]

      delay = sleep * 2

      finish   = `date +%s`.to_i
      expect((finish - start).abs).to be <= 1
    end

    context "with integers" do
      it "is like doing math with all operands of type integer" do
        an_integer = 1
        sleep = Sleep2[duration]
        Sleep2::MATH_OPERATORS.each do |op|
          expect(duration.public_send(op, an_integer)).to(
            eq(sleep.public_send(op, an_integer).duration)
          )
        end
      end
    end

    context "with sleep2 objects" do
      it "is like doing math with all operands of type integer" do
        time_interval = 1
        freeze = Sleep2[time_interval]
        sleep  = Sleep2[duration]
        Sleep2::MATH_OPERATORS.each do |op|
          expect(duration.public_send(op, time_interval)).to(
            eq(sleep.public_send(op, freeze).duration)
          )
        end
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
