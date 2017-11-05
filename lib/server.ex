defmodule Server do
    def server(k) do
        unless Node.alive?() do
            ip_address = :inet.getif() |> elem(1) |> hd() |> elem(0) |> Tuple.to_list |> Enum.join(".")
            long_name = "raheen@"<> ip_address |> String.to_atom
 	    Node.start(long_name,:longnames,15000)
          end
          Node.set_cookie(Node.self,:myconn)
          check_connection(k,[]) 
    end   
    
    def new_node(list) do
        print_list(Node.list())
        Node.list() -- list
    end

    def check_connection(k,list) do
	Process.sleep(1500)
        conn_list = new_node(list) 
        print_list(conn_list)
        if (List.first(conn_list) != nil) do
            spawn_process(conn_list,k)
            list = Node.list()
        end
       
        if ( List.first(Node.list()) == nil ) do
            check_connection(k,[])
        else
            check_connection(k,list)
        end
    end

    def spawn_process(temp_list,k) do
        if (List.first(temp_list) != nil ) do
            Node.spawn(temp_list|>List.first(),Project1,:spawn_mining,[k])
            spawn_process(tl(temp_list),k)
        end
    end

    def print_list(list) do
        if (list|>List.first()) do
            IO.puts(list|>List.first())
            print_list(tl(list))
        end
    end
end
