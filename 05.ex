defmodule D05 do
    def main(args) do
        lines = parseInput(hd args)

        regularLines = lines
            |> Enum.filter(fn {{x1, y1}, {x2, y2}} -> x1 == x2 or y1 == y2 end)

        IO.puts("#{inspect(lines)}")

        points = regularLines
            |> Enum.map(&linePoints/1)
            |> Enum.concat

        IO.puts("#{inspect(points)}")

        uniquePoints = Enum.uniq(points)
        nonUniquePoints = Enum.uniq(points -- uniquePoints)

        IO.puts("#{inspect(nonUniquePoints)}")

        IO.puts("#{length(nonUniquePoints)}")

        points = lines
            |> Enum.map(&linePoints/1)
            |> Enum.concat

        IO.puts("#{inspect(points)}")

        uniquePoints = Enum.uniq(points)
        nonUniquePoints = Enum.uniq(points -- uniquePoints)

        IO.puts("#{inspect(nonUniquePoints)}")

        IO.puts("#{length(nonUniquePoints)}")

    end

    def parseInput(filename) do
        Common.readLines(filename) |> Enum.map(&parseLine/1)
    end

    def parseLine(line) do
        [from, to] = String.split(line, " -> ")
        [x1, y1] = String.split(from, ",") |> Enum.map(&Common.parseInt/1)
        [x2, y2] = String.split(to, ",") |> Enum.map(&Common.parseInt/1)
        {{x1, y1}, {x2, y2}}
    end

    def linePoints({{x, y1}, {x, y2}}) do
        for y <- y1..y2, do: {x, y}
    end
    def linePoints({{x1, y}, {x2, y}}) do
        for x <- x1..x2, do: {x, y}
    end
    def linePoints({{x1, y1}, {x2, y2}}) when abs(x1 - x2) == abs(y1 - y2) do
        Enum.zip(x1..x2, y1..y2)
    end
end

D05.main(["05.input"])
