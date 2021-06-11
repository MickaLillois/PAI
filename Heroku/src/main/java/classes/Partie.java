package classes;

import io.socket.client.IO;
import io.socket.client.Socket;


import java.io.Console;
import java.io.PrintWriter;
import java.net.URI;

public class Partie {

    Socket socketPartie;

    public Partie(){}

    public Partie(String lien, PrintWriter out){
        URI uri = URI.create(lien);
        this.socketPartie = IO.socket(uri);

        this.socketPartie.on(Socket.EVENT_CONNECT, e -> {
            out.println("Connected");
        });
        this.socketPartie.on(Socket.EVENT_DISCONNECT, e -> {
            out.println("Disonnected");
        });
        this.socketPartie.connect();
    }

    public String socketString(){
        return socketPartie.toString();
    }

}
