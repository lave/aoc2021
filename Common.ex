defmodule Common do
    def readLines(filename) do
        File.stream!(filename)
            |> Stream.map(&String.trim/1)
            |> Enum.to_list
    end

    def readLine(filename) do
        hd(readLines(filename))
    end

    def parseInt(s) do
        elem(Integer.parse(s), 0)
    end

    def transpose(matrix) do
        Enum.zip(matrix) |> Enum.map(&Tuple.to_list/1)
    end

    def last(tuple) do
        elem(tuple, tuple_size(tuple) - 1)
    end
end
