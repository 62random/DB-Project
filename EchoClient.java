import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;


public class EchoClient {

    public static void main(String args[]) throws IOException, UnknownHostException {

        Socket cs = new Socket("127.0.0.1", 9999);

        PrintWriter out = new PrintWriter(cs.getOutputStream(),true);
        BufferedReader in = new BufferedReader( new InputStreamReader(cs.getInputStream()));


        String current;
        BufferedReader sin = new BufferedReader(new InputStreamReader(System.in));
        while ((current = sin.readLine()) != null){
            out.println(current);
            System.out.println("loop echo: " + current);
        }
        in.close();
        sin.close();

        out.close();
        cs.close();
    }

}
