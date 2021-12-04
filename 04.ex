defmodule D04 do
    def main(args) do
        {numbers, boards} = parseInput(hd args)

        result = play(numbers, boards, true)
        IO.puts("#{score(result)}")

        result = play(numbers, boards, false)
        IO.puts("#{score(result)}")
    end

    def parseInput(filename) do
        [numbers | boards] = Common.readLines(filename)

        numbers = String.split(numbers, ",")
            |> Enum.map(&Common.parseInt/1)

        boards = Enum.chunk_every(boards, 6)
            |> Enum.map(&parseBoard/1)

        {numbers, boards}
    end

    def parseBoard(lines) do
        rows = lines
            |> Enum.filter(fn line -> String.length(line) > 0 end)
            |> Enum.map(fn line -> String.split(line, " ", trim: true) |> Enum.map(&Common.parseInt/1) end)

        cols = Common.transpose(rows)

        rows ++ cols
    end

    def play([number | numbers], boards, tillFirstWin) do
        boards_ = Enum.map(boards, &(remove(number, &1)))
        {won, remaining} = Enum.split_with(boards_, &isWin/1)

        case {tillFirstWin, won, remaining} do
            # if game till first win and we have winner - return
            {true, [won], _} -> {won, number}
            # if game till last win and we have no more participants - return
            {false, _, []} -> {hd(boards_), number}
            _ -> play(numbers, remaining, tillFirstWin)
        end
    end

    def remove(number, board) do
        # remove given number from each element (i.e. each row and each column)
        Enum.map(board, &(List.delete(&1, number)))
    end

    def isWin(board) do
        # it's a win if board has empty element (i.e. empty row or empty column)
        Enum.find(board, &(Enum.empty?(&1))) != nil
    end

    def score({board, number}) do
        sum = board
            |> Enum.take(div(length(board), 2)) # take half of the elements - i.e. only rows
            |> Enum.concat
            |> Enum.sum
        sum * number
    end
end

D04.main(["04.input"])
