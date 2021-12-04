defmodule D02 do
    def main(args) do
        moves = Common.readLines(hd args)
            |> Enum.map(&parseMove/1)

        {x, y} = List.foldl(moves, {0, 0}, &makeMove1/2)
        IO.puts("#{x * y}")

        {x, y, _} = List.foldl(moves, {0, 0, 0}, &makeMove2/2)
        IO.puts("#{x * y}")
    end

    def parseMove(move) do
        [dir, num] = String.split(move, " ")
        n = Common.parseInt(num)
        case dir do
            "forward" -> {:forward, n}
            "up"      -> {:up, n}
            "down"    -> {:down, n}
        end
    end

    def makeMove1({dir, n}, {x, y}) do
        case dir do
            :forward -> {x + n, y}
            :up      -> {x, y - n}
            :down    -> {x, y + n}
        end
    end

    def makeMove2({dir, n}, {x, y, aim}) do
        case dir do
            :forward -> {x + n, y + aim * n, aim}
            :up      -> {x, y, aim - n}
            :down    -> {x, y, aim + n}
        end
    end
end

D02.main(["02.input"])
