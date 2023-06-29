## Target picker
## Inputs
## * word_list
## * difficulty: a combination of min number of hops and number of paths
#
## Output:
## * start
## * target_word
## TODO: Add feedback on user decisions

defmodule TargetPicker do
  @spec generate_targets(word_list :: [String.t()]) ::
    {start :: String.t(), target_word :: String.t()}
  def generate_targets(word_list) do
    # TODO: Think about word list filtering and uniq
    # Consider using `MapSet`
    # Build paths (list of words)
    build_paths(word_list)
    |> select_target()

    # Select start and end nodes of a path
  end

  defp select_target(paths) do
    path = paths
    |> Enum.filter(fn path -> length(path) > 1 end)
    |> Enum.random()
    if is_nil(path) do
      nil
    else
      {Enum.at(path,0),Enum.at(path,-1)}
    end
  end

  defp build_paths(word_list) do
    Enum.map(word_list, fn word ->
      build_paths_for_word(word, word_list, [word])
    end)
    |> List.flatten()
    |> Enum.map(fn {path} -> path end)
  end


  defp build_paths_for_word(word, word_list, current_path) do
    new_words = Enum.filter(word_list, fn new_word ->
      difference_in_chars(new_word, word) == 1 && new_word not in current_path
    end)

    if Enum.empty?(new_words) do
      {Enum.reverse(current_path)}

    else
      #IO.inspect(word, label: "word")
      #IO.inspect(new_words, label: "new_words")
      Enum.map(new_words, fn new_word -> build_paths_for_word(new_word, word_list, [new_word | current_path])end)
    end
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
|> IO.inspect()
