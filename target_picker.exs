## Target picker
## Inputs
## * word_list
## * difficulty: a combination of min number of hops and number of paths
#
## Output:
## * start
## * target_word

defmodule TargetPicker do
  @spec generate_targets(word_list :: [String.t()]) ::
    {start :: String.t(), target_word :: String.t()}
  def generate_targets(word_list) do
    # TODO: Think about word list filtering and uniq
    # Consider using `MapSet`
    # Build paths (list of words)
    build_paths(word_list)

    # Select start and end nodes of a path
  end

  defp build_paths(word_list) do
    Enum.map(word_list, fn word ->
      build_paths_for_word(word, word_list)
    end)
  end

  defp build_paths_for_word(word, word_list) do
    new_word = Enum.find(word_list, fn new_word ->
      difference_in_chars(new_word, word) == 1
    end)

    IO.inspect(word, label: "word")
    IO.inspect(new_word, label: "new_word")
  end

  defp difference_in_chars(word_1, word_2) do
    length(String.graphemes(word_1) -- String.graphemes(word_2))
  end
end

word_list = [
  "cat",
  "xyz",
  "bat",
  "hat",
  "rat"
]

TargetPicker.generate_targets(word_list)
