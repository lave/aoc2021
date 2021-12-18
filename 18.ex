defmodule D18 do
    def main(args) do
        nums = Common.readLines(hd args)
            |> Enum.map(&Code.eval_string/1)
            |> Enum.map(&(elem(&1, 0)))
        #print(nums)

        sum = List.foldl(tl(nums), hd(nums), &add/2)
        #print(sum)
        magnitude = calcMagnitude(sum)
        IO.puts("#{magnitude}")

        maxMagnitude = (for n1 <- nums, n2 <- nums, do: calcMagnitude(add(n1, n2)))
            |> Enum.max
        IO.puts("#{maxMagnitude}")
    end

    def print(num) do
        IO.puts("#{inspect(num, limit: :infinity, charlists: :as_lists)}")
    end

    def add(x, sum) do
        reduce([sum, x])
    end

    def reduce(num) do
        # explode first
        {num, _, _, exploded?} = explode(num, 0, nil, false)

        # if it wasn't exploded - split
        {num, reduced?} = if exploded? do
            {num, exploded?}
        else
            split(num, false)
        end

        # if number was reduced - try again until reducing doesn't do anything
        if reduced? do
            reduce(num)
        else
            num
        end
    end

    # input:
    #   (<node>, <depth>, <add_to_right>, <is_reduced>)
    # returns:
    #   {<new node>, <add_to_left>, <add_to_right>, <is_reduced>}
    #
    # don't do anything if a node was already exploded and we already used it's right part
    def explode(num, _depth, nil, true) do
        {num, nil, nil, true}
    end
    # node is a number - return it unchanged or add right part of exploded node if we have it pending
    def explode(num, _depth, add_to_right, reduced?) when is_number(num) do
        num_ = num + (if add_to_right == nil do 0 else add_to_right end)
        {num_, nil, nil, reduced?}
    end
    # we've found a node to explode - do it! (there's no pending right part
    # because only one node can be exploded during the single pass)
    def explode([x, y], depth, nil, false) when depth > 3 do
        #IO.puts("explode #{inspect([x, y], charlists: :as_lists)}")
        {0, x, y, true}
    end
    # composite node, and explosion wasn't done yet - try left part first, then
    # right one, be careful with applying exploded parts to proper components
    def explode([x, y], depth, add_to_right, reduced?) do
        #IO.puts("#{inspect([x, y], charlists: :as_lists)}, #{depth}, #{add_to_right}, #{reduced?}")
        {x_, add_to_left_1, add_to_right_1, reduced?} =
            explode(x, depth + 1, add_to_right, reduced?)
        {y_, add_to_left_2, add_to_right_2, reduced?} =
            explode(y, depth + 1, add_to_right_1, reduced?)
        {[add_at_right(x_, add_to_left_2), y_], add_to_left_1, add_to_right_2, reduced?}
    end

    # add left part of exploded right node component to the left node component -
    # we should add it to the right-most number
    def add_at_right(x, nil) do
        x
    end
    def add_at_right(x, n) when is_number(x) do
        x + n
    end
    def add_at_right([x, y], n) do
        [x, add_at_right(y, n)]
    end

    # input:
    #   (<node>, <depth>, <add_to_right>, <is_reduced>)
    # returns:
    #   {<new node>, <add_to_left>, <add_to_right>, <is_reduced>}
    #
    #   don't do anything is split already has been done
    def split(num, true) do
        {num, true}
    end
    # node is a number - split it if necessary
    def split(n, false) when is_number(n) do
        if n > 9 do
            n_ = [div(n, 2), div(n + 1, 2)]
            #IO.puts("split #{n} -> #{inspect(n_, charlists: :as_lists)}")
            {n_, true}
        else
            {n, false}
        end
    end
    # composite node, split wan't done yet - try left part first, then right one
    def split([x, y], false) do
      {x_, split?} = split(x, false)
      {y_, split?} = split(y, split?)
      {[x_, y_], split?}
    end

    def calcMagnitude(n) when is_number(n) do
        n
    end
    def calcMagnitude([x, y]) do
        calcMagnitude(x) * 3 + calcMagnitude(y) * 2
    end
end

D18.main(["18.input"])
