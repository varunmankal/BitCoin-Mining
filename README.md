The goal of this project is generate bitcoins with the required number of leading zeros using actor model. It has also been extended to enlist other machines to take part in bitcoin generation.

**Steps to execute**

1) Bitcoin mining using actor model
   Execute the following command in the directory where the project is present
   i) mix escript.build
   ii) ./project1 "number of required zeros" (4 can be substituted by any other number of required zeros)

2) Bitcoin mining using distributed implementation
   Execute the following command in the directory where the project is present in the SERVER machine
   i) mix escript.buil
   ii) ./project1 "number of required zeros" (4 can be substituted by any other number of required zeros)

  Execute the following command in the directory where the project is present in the WORKER machine
  i) mix escript.build
  ii) ./project1 "ip address of server"

  *NOTE : In order for a node to be a distributed node epmd (Erlang Port Mapper Daemon) must be running on the machine. If it isn't running then the node will not be able to start. To start epmd manually, execute "epmd -daemon" on command line. 

**Results**

1)work unit

2) The following output was obtained while mining for coins with 4 leading 0's. 
    
raheenmz;/rQNgCPE 00008EEE5DC6632F700D7962344F6EE531728C999F1852A3A513716393077299
raheenmz;3DEhJA7e 0000BC2989DE94BCAC8C8694066E21E72AB289FEE0CDEB6A6FB653BC5FE17DD5
raheenmz;SxkkIBJT 0000318821E90EA6930A352B244DEF8E72A5B73309E64A80D59C6B14BF1D503A
raheenmz;4liqtGas 0000E7F188B863157FC2277E5362BFB9AB7865E47D57723A1270F5AA350DFD79
raheenmz;G2Lft78a 00000F52C1C15DE3220A21E3D672E4D593A585DD00E1678CBC1D03069B7D4813
raheenmz;UJIPGtTo 00001790BC544B7A6D53DA0E90CC6D435A783E6843C616D127BB282FB12697D5
raheenmz;gLPBV7eQ 000024B72E511812392C90D182AA094B3E1DA33F58DB6675209F6682C6F77BB8
raheenmz;zebywgyg 000070371F39907A972E2C2428C737EA3EFA65040D811068F12B451C06F09F5C
raheenmz;FO+PtMpl 00000835277AAD34E76F920514E94EE55E4748C231A5CF393A0D3698117D8A63
raheenmz;AM0WLBf9 00006B7A2D698D2A3BB64F87DFFD59271AFA986531D431812CB448B10FDFD0F3
raheenmz;KlBM+r/j 0000AF8C4D25DE5B92506CFEDC0215CEDD494856B49A9EBEC3F93D28C5C2C184
raheenmz;GfyWSszg 0000E3C19A80D80B43E25BD7A8E5E6E45BEAA9F79952459B1DEC42F45494C1DD
raheenmz;rJKEAe19 000040837D20A1F8FC320732D04E91CA0769B638C0359FDCFD68614360CBE877
raheenmz;AI2gCv1U 0000D7CA48733566307B08E6C9275AAE9E92210635D51748E27557BF7D01BC4C
raheenmz;9DUANqq0 0000A267DDB13D28BAEDA0202E8844D7CEA208E48866AD2444177F5EB3742C43
raheenmz;CFm1q8U2 00001FD96C30BEFE748D69D085D2236ACC4A7EE66D5F9B8E33D6C352D52E8233
raheenmz;p7HCIqH1 00000E0481C562B12B96650A30487858B15BDD1D3275CB3199ABC94FC3DCCF6F
raheenmz;IF/vkC4A 00002E3E2B0EFB541C840CF1269756EE05AF0CF806C74AD13A7B146397E3D1DD

3)largest number of machines : 4 


**Function description** 

I) Project1
  Contains functions for mining bitcoins on a single node using actor model.

  i) mining(k): Generates random string of length 10. Genrates hash of random string appended with UFID. Prints hash if it has atleast k leading zeros.

  ii) check_value(hash, k, i): Verifies whether hash has atleast k leading zeros.

  ii) spawn_mining(k) : Spawns mining process.

II) Server: Contains functions required to spawn process on worker nodes

    i) server(k) : Creates a node and invokes function check_connection() to check for active connections.
       *NOTE : This function uses :inet.getif to obtain IP address of local machines. However, with this command position of local IP in result set is not fixed. Depending on it's position, we may have to used hd()/tl()/List.last() to get local IP. Currently hd() is being used.
    
    ii) check_connection(k,list) : Continously monitors if any new nodes are connected to server. If new connections are found spawn_process is invoked.  

    iii) spawn_process(temp_list,k) : Spawns process of list of nodes received as input. Input also includes number of zeros expected in bitcoin.

III) Worker: Contains functions to be run on worker nodes

    i) main(ip_address) : Creates a node and establishes connection with server node which is present on the IP address specified in the argument
    *NOTE : This function uses :inet.getif to obtain IP address of local machines. However, with this command position of local IP in result set is not fixed. Depending on it's position, we may have to used hd()/tl()/List.last() to get local IP. Currently hd() is being used.
    
    **NOTE: Besides the above given function, worker nodes must also have copy of the functions which are spawned by the Server

