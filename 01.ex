defmodule D01 do
    def main(args) do
        nums = Common.readLines(hd args)
            |> Enum.map(&Common.parseInt/1)

        solution1 = amountOfIncreases(nums)
        IO.puts("#{solution1}")

        nums = List.zip([nums, tl(nums), tl(tl(nums))])
            |> Enum.map(&Tuple.sum/1)
        solution2 = amountOfIncreases(nums)
        IO.puts("#{solution2}")
    end

    def amountOfIncreases(nums) do
        Enum.zip(nums, tl(nums))
            |> Enum.count(fn {l, r} -> l < r end)
    end
end

D01.main(["01.input"])
