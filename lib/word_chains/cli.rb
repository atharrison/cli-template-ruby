require 'thor'

module WordChains
  class Cli < Thor

    namespace :word_chains

    long_desc <<-LONGDESC
      Given a start_word and an end_word, print a list of words, including start_word and end_word.\n
      Each word in the list should differ from the previous word by exactly one letter.
    LONGDESC
    option :start_word, :type => :string, :aliases => '-s'
    option :end_word, :type => :string, :aliases => '-e'
    desc "solve", "Solve a word chain problem"
    def solve
      s = Solver.new(options[:start_word], options[:end_word])
      puts s.solution
    end

    desc "dict", "Prints some words"
    def dict
      d = Dictionary.new('data/words.txt')
      puts d.words[0..10]
    end
  end
end
