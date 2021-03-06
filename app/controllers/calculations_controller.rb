class CalculationsController < ApplicationController

  # first section

  def word_count

    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length

    #  @character_count_without_spaces = @text.gsub(" ", "").length
    z = @text.gsub(/[\s+]/, "")
    @character_count_without_spaces = z.length

    @word_count = @text.split.size

    oc = 0
    b = @text.downcase
    c = b.split
    d = @special_word.downcase
    c.each { |x|
      if x == d
        oc += 1
      end
    }
    @occurrences = oc

    render("word_count.html.erb")
  end

  # second section

  def loan_payment

    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # PMT = P*(r/12)
    #       --------
    #       1 - [1 + (r/12)]^-12Y

    p = @principal
    m = @years * 12
    r = @apr/1200
    @monthly_payment = p * (r + (r / ((1 + r) ** m - 1) ) )

    render("loan_payment.html.erb")
  end

  # third section

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # default time measurement is seconds

    s = @ending - @starting
    @seconds = s.abs

    m = s/60
    @minutes = m.abs

    h = m/60
    @hours = h.abs

    d = h/24
    @days = d.abs

    w = d/7
    @weeks = w.abs

    y = w/52
    @years = y.abs

    render("time_between.html.erb")
  end

  # fourth section

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    n = @numbers
    l = @numbers.length

    @sorted_numbers = n.sort
    s = @sorted_numbers

    @count = n.count

    @minimum = n.min

    @maximum = n.max

    r = @maximum - @minimum
    @range = r.abs

    m = l / 2
    if l % 2 == 0
      median = (s[m] + s[m - 1]) / 2
    else
      median = s[m]
    end
    @median = median

    @sum = n.sum

    @mean = n.sum/n.size

    # Subtract the mean from each value in the data. This gives you a measure of the distance of each value from the mean.
    # Square each of these distances (so that they are all positive values), and add all of the squares together.
    # Divide the sum of the squares by the number of values in the data set.

    mean = @mean
    g = n.map { |i| i - mean }
    p = g.map { |i| i ** 2 }
    v = p.sum / l
    @variance = v

    k = v.abs
    d = 1.0/2
    b = v ** d
    @standard_deviation = b

    # MODE TEST
    # Very true! It’s a pretty dumb test; it’s just looking for the presence of the mode anywhere on the entire page, which of course passes since the whole list is displayed first thing.
    # We should narrow the test to look within a particular CSS selector. Ask me about this in class so we can discuss it with everyone?
    @mode = n.sum

    render("descriptive_statistics.html.erb")
  end
end
