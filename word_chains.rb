class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name)
    @dictionary = @dictionary.map { |line| line.chomp}
    @current_words = []
    @seen_words = []
  end

  def adjacent_words(word)
    result = []
    @dictionary.each do |dict_word|
      next if word == dict_word
      next if word.size != dict_word.size
      diff_count = count_differences(word, dict_word)
      next if diff_count > 1
      result << dict_word
    end
    result
  end

  def count_differences(word1, word2)
    differences = 0
    word1.split('').each_index do |index|
      differences += 1 if word1[index] != word2[index]
    end
    differences
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = [source]
    until @current_words.empty?
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |word|
          next if @all_seen_words.include?(word)
          new_current_words << word
          @all_seen_words << word
        end
        p new_current_words
        @current_words = new_current_words
      end
    end
  end

end
