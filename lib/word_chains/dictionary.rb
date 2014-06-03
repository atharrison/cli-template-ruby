module WordChains
  class Dictionary

    attr_reader :words

    def initialize(filename)
      contents = IO.binread(filename)
      contents.each_line do |line|
        (@words ||= []) << line.chomp
      end
    end
  end
end
