package servlet;

import classes.Partie;
import io.socket.client.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
        name = "ConnexionPartieServlet",
        urlPatterns = {"/connexion"}
)
public class ConnexionPartieServlet extends HttpServlet {

    //pour l'instant, cette classe va systématiquement créer une partie et établir une io socket qu'elle renvoie
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String lien = "https://quizinmobile.herokuapp.com/partie1";
        Partie nouvellePartie = new Partie(lien);

        ServletOutputStream out = resp.getOutputStream();
        out.write("partie créée".getBytes());
        out.flush();
        out.write(nouvellePartie.isActive().getBytes());
        out.flush();

        PrintWriter pw = resp.getWriter();
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        pw.print(lien);
        pw.flush();

        pw.close();
        out.close();
    }

}