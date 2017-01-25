class CalculationsController < ApplicationController

# first section

  def word_count

    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length
    @character_count_without_spaces = @text.gsub(" ", "").length
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


  @monthly_payment = "your text"

  render("loan_payment.html.erb")
end

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

def descriptive_statistics
  @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

  n = @numbers

  @sorted_numbers = n.sort

  @count = n.count

  @minimum = n.min

  @maximum = n.max

  @range = "Replace this string with your answer."

  @median = "Replace this string with your answer."

  @sum = n.sum

  @mean = n.sum/n.size

  @variance = "Replace this string with your answer."

  @standard_deviation = "Replace this string with your answer."

  @mode = "Replace this string with your answer."

  render("descriptive_statistics.html.erb")
end
end
