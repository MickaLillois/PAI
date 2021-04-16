package classes;

import io.socket.client.IO;
import io.socket.client.Socket;

import java.net.URI;

public class Partie {

    Socket socketPartie;

    public Partie(){}

    public Partie(String lien){
        URI uri = URI.create(lien);
        this.socketPartie = IO.socket(uri);
    }

    public String isActive(){
        if(socketPartie.isActive()){return "true";}
        else {return "false";}
    }

}
