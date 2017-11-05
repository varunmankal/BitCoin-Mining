defmodule Worker do
    
    def worker(ip_addr) do
      
        unless Node.alive?() do
            wkr_ip = :inet.getif() |> elem(1) |> hd() |> elem(0) |> Tuple.to_list |> Enum.join(".")
            long_name = "worker@"<>wkr_ip |> String.to_atom
            Node.start( long_name,:longnames,15000)
        end
      
        conn_str = "raheen@"<> to_string(ip_addr) |> String.to_atom
        Node.set_cookie(Node.self,:myconn)
        Node.connect(conn_str)
	receive do: (_ -> :ok)

    end
end
