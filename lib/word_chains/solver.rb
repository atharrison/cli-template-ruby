module WordChains
  class Solver

    attr_accessor :start_word, :end_word, :candidates, :solutions

    def initialize(start_word, end_word)
      @start_word = start_word
      @end_word = end_word
      @dictionary = Dictionary.new('data/words.txt')
      @solutions = []
      @best_solution = nil
    end

    def solve(candidates, word, goal, chain)
      if candidates.length == 0
        return @best_solution unless @best_solution.nil?
        return ["No solution"]
      end

      begin
        candidate = best_levenshtein(candidates, word)
      rescue => ex
        #puts "Bad candidate: #{candidate}] #{ex.message}"
        raise "No solution here" if candidate.nil? || candidate.length == 0
        candidates.delete(candidate)
        retry
      end

      new_dist = Levenshtein.distance(candidate, goal)

      if new_dist == 1 && (@best_solution.nil? || @best_solution.size > chain.size)
        chain << candidate # Success!
        puts "Found a chain of size #{chain.size}"
        puts chain
        @best_solution = chain.dup
        #new_candidates = candidates.dup
        #new_candidates.delete(word)
        #begin
        #  solve(new_candidates, candidate, goal, chain)
        #rescue
        #  chain.pop
        #  new_candidates.delete(candidate)
        #  solve(new_candidates, word, goal, chain)
        #end
      elsif !@best_solution.nil? && @best_solution.size > chain.size
        chain << candidate
        puts "Current chain: #{chain}"
        inner_solve(candidates, candidate, word, goal, chain)
        #new_candidates = candidates.dup
        #new_candidates.delete(word)
        #begin
        #  solve(new_candidates, candidate, goal, chain)
        #rescue
        #  chain.pop
        #  new_candidates.delete(candidate)
        #  solve(new_candidates, word, goal, chain)
        #end
      else
        #chain.pop
        inner_solve(candidates, candidate, word, goal, chain)
        #new_candidates = candidates.dup
        #new_candidates.delete(word)
        #begin
        #  solve(new_candidates, candidate, goal, chain)
        #rescue
        #  chain.pop
        #  new_candidates.delete(candidate)
        #  solve(new_candidates, word, goal, chain)
        #end
      end
    end

    def inner_solve(candidates, candidate, word, goal, chain)
      new_candidates = candidates.dup
      new_candidates.delete(word)
      begin
        solve(new_candidates, word, goal, chain)
      rescue
        chain.pop
        new_candidates.delete(candidate)
        solve(new_candidates, word, goal, chain)
      end
    end

    def solution
      solve(prune_dictionary(start_word.length), start_word, end_word, [])

      best_chain = @solutions.sort{|a,b| a.length <=> b.length}.first
      [start_word, best_chain, end_word].flatten
    end

    def prune_dictionary(length)
      @dictionary.words.reject{ |word| word.size != length}
    end

    def levenshtein(words, word)
      #binding.pry
      words.map{ |w| {word: w, dist: Levenshtein.distance(w, word)} }
    end

    def best_levenshtein(words, word)
      inner_words = words.dup
      inner_words.delete(word)
      best = levenshtein(inner_words, word).sort { |a, b| a[:dist] <=> b[:dist] }[0]
      #binding.pry
      raise "no good candidate" if best[:dist] > 1
      best[:word]
    end
  end
end
