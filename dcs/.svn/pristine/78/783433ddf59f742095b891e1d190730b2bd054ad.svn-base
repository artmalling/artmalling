package common.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class dServer implements Runnable { 

    public static final int ServerPort = 4445; 
    public static final String ServerIP = "127.0.0.1"; 
 
    public void run() { 

        // TODO Auto-generated method stub  

        try { 

            System.out.println("S: Connecting(1)..."); 
            ServerSocket serverSocket = new ServerSocket(ServerPort); 

            while (true) { 

            	Socket client = serverSocket.accept(); 
                System.out.println("S: Connect Client(2)..."); 
                
                BufferedReader inFile = new BufferedReader(new InputStreamReader(client.getInputStream()));
                PrintWriter outFile = new PrintWriter(client.getOutputStream());
                
				boolean bContinue = true;
				String buff;
				buff =inFile.readLine();
				System.out.println(buff);  
				//이곳에 조건을 추가하자.
				while(bContinue == true && buff != null) //while(bContinue == true && (buff =inFile.readLine()) != null )
				{
					//client Data 송신. 
					//
	                outFile.write( "SrvMsg : Your msg OK!" );               	
	                bContinue = false;
				}

				outFile.flush();
				client.close();				
				System.out.println("S: Connect ServerEnd(3)..."); 
            } 
        } catch (Exception e) { 
            System.out.println("S: Error"); 
            e.printStackTrace(); 
        } 

    } 

    public static void main(String[] args) { 

        Thread desktopServerThread = new Thread(new dServer()); 
        desktopServerThread.start(); 

    } 

}
