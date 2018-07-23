class FunctionsController < ApplicationController
  def index
    @result_factorial = calculate_factorial
    @number_to_translate = translate_number
  end

  private

    def calculate_factorial
      number = params[:factorial].to_i || 1
      (1..number).reduce(:*).to_s.count('0')
    end

    def translate_number
      number = params[:number].to_i || 0
      NumbersToWordsService.perform(number)
    end
end
