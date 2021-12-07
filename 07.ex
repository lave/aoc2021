defmodule D07 do
    def main(args) do
        positions = Common.readLine(hd args)
            |> String.split(",")
            |> Enum.map(&Common.parseInt/1)

        fuel = findFuel1(positions)
        IO.puts("#{fuel}")

        fuel = findFuel2(positions)
        IO.puts("#{fuel}")
    end

    def findFuel1(positions) do
        sorted = Enum.sort(positions)
        mid = Enum.at(sorted, div(length(sorted) - 1, 2))
        Enum.map(positions, &(abs(&1 - mid))) |> Enum.sum
    end

    def fuel(fuelPerDistance, x, pos) do
        Enum.map(pos, &(elem(fuelPerDistance, abs(&1 - x)))) |> Enum.sum
    end

    def findFuel2(positions) do
        {l, r} = Enum.min_max(positions)

        fuelPerDistance = Enum.to_list(1..(r - l))
            |> List.foldl([0], fn(dist, fuels) -> [hd(fuels) + dist | fuels] end)
            |> Enum.reverse
            |> List.to_tuple

        Enum.to_list(l..r)
            |> Enum.map(&(fuel(fuelPerDistance, &1, positions)))
            |> Enum.min
    end
end

D07.main(["07.input"])
