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
      build_paths_for_word(word, word_list, [word])
      |> IO.inspect()
    end)
  end

  defp build_paths_for_word(nil, word_list, current_path) do
    Enum.reverse(current_path)
  end

  defp build_paths_for_word(word, word_list, current_path) do
    new_word = Enum.find(word_list, fn new_word ->
      difference_in_chars(new_word, word) == 1 && new_word not in current_path
    end)

    IO.inspect(word, label: "word")
    IO.inspect(new_word, label: "new_word")

    build_paths_for_word(new_word, word_list, [new_word | current_path])
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
