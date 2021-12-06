defmodule D06 do
    def main(args) do
        fish = Common.readLine(hd args)
            |> String.split(",")
            |> Enum.map(&Common.parseInt/1)

        fish_ = model1(fish, 80)
        IO.puts("#{length(fish_)}")

        fishCount = model2(fish, 256)
        IO.puts("#{fishCount}")
    end

    def model1(fish, days) do
        List.foldl(Enum.to_list(1..days), fish, &modelDay/2)
    end

    def modelDay(_, fish) do
        # add new fish
        newCount = Enum.count(fish, &(&1 == 0))
        fish_ = fish ++ List.duplicate(9, newCount)

        # decrease timers
        Enum.map(fish_, fn timer -> if timer == 0 do 6 else timer - 1 end end)
    end

    def model2(fish, days) do
        # map - how many fish will be in given amount of days for fish with
        # given initial timer value (timer values are from 0 to 8, at day 0 it's
        # 1 fish for all initial timer values)
        map = List.foldl(Enum.to_list(1..days), {1, 1, 1, 1, 1, 1, 1, 1, 1}, &genMap/2)

        fish
            |> Enum.map(&(elem(map, &1)))
            |> Enum.sum
    end

    def genMap(_, prevDay) do
        new = Enum.to_list(0..8)
            |> Enum.map(fn timer ->
                # for each timer value calculate amount of fish this day based
                # on amounts of fish previous day
                if timer == 0 do 
                    elem(prevDay, 6) + elem(prevDay, 8)
                else
                    elem(prevDay, timer - 1)
                  end
            end)

        # IO.puts(#{inspect(new)}")

        List.to_tuple(new)
    end
end

D06.main(["06.input"])
