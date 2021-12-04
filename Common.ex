defmodule Common do
    def readLines(filename) do
        File.stream!(filename)
            |> Stream.map(&String.trim/1)
            |> Enum.to_list
    end

    def parseInt(s) do
        elem(Integer.parse(s), 0)
    end
end
