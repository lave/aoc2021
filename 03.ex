defmodule D03 do
    def main(args) do
        report = Common.readLines(hd args)
            |> Enum.map(&parseBits/1)
        n = length(report)

        # part 1
        columns = Common.transpose(report)
        mostCommonBits = Enum.map(columns,
            fn l -> if Enum.sum(l) * 2 > n do 1 else 0 end end)

        gammaRate = bitsToInt(mostCommonBits)
        epsilonRate = bitsToInt(Enum.map(mostCommonBits, &(1 - &1)))
        IO.puts("#{gammaRate * epsilonRate}")

        # part 2
        rows = Enum.map(report, &List.to_tuple/1)
        oxygenRating = findRating(rows, 0, true)
        co2Rating = findRating(rows, 0, false)
        IO.puts("#{oxygenRating * co2Rating}")
    end

    def parseBits(str) do
        String.graphemes(str)
            |> Enum.map(fn x -> if x == "0" do 0 else 1 end end)
    end

    def bitsToInt(bits) do
        List.foldl(bits, 0, fn (bit, num) -> num * 2 + bit end)
    end

    def findRating([row], _, _) do
        bitsToInt(Tuple.to_list(row))
    end
    def findRating(rows, pos, useMostCommonBit) do
        sum = rows |> Enum.map(&(elem(&1, pos))) |> Enum.sum
        mostCommonBit = if sum * 2 >= length(rows) do 1 else 0 end
        remainingRows = Enum.filter(rows,
            fn l -> (elem(l, pos) == mostCommonBit) == useMostCommonBit end)
        findRating(remainingRows, pos + 1, useMostCommonBit)
    end
end

D03.main(["03.input"])
