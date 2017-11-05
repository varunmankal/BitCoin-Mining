defmodule Project1 do
  def main(k) do
     if (String.contains?(to_string(k),"." )) do
     	Worker.worker(k)
     else
      spawn(fn -> Server.server(k) end)
      spawn_mining(k)
      receive do: (_ -> :ok)
     end 
  end

  def mining(k) do
    string =  (:crypto.strong_rand_bytes(8) |> Base.encode64 |> binary_part(0, 8))
    prefixed_string = "raheenmz;"<>string
    hash = Base.encode16(:crypto.hash(:sha256, prefixed_string)) 
    if check_value(hash,k,0) do
      IO.puts(prefixed_string<> " "<> hash)
    end
    mining(k)
  end

  def check_value(hash, k, i) do
     cond do
	  String.equivalent?(to_string(i),to_string(k)) -> true
          String.at(hash,i) != "0" -> false 
          true -> check_value(hash,k,i+1)
      end
   end    

  def spawn_mining(k) do
        for _ <- 1..10 do
		spawn(fn -> mining(k) end)
	end
	receive do: (_ -> :ok)
  end

end
