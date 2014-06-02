module WordChains
  class Solver

    attr_accessor :start_word, :end_word

    def initialize(start_word, end_word)
      @start_word = start_word
      @end_word = end_word
    end

    def solution
      [start_word, end_word]
    end
  end
end
