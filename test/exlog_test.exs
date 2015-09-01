defmodule ExlogTest do
  use ExUnit.Case
  use Exlog
  
  test "the truth" do
    assert 1 + 1 == 2
  end

  test "exlog" do

    simulation do  
      fact truth(:a, :b)

      result1 = solve do: truth(:a, :b)    
      result2 = solve do: truth(:b, :a)
      
      assert result1
      refute result2
    end    
  end
end
