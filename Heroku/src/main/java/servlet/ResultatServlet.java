package servlet;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@WebServlet(
        name = "MyResultatServlet",
        urlPatterns = {"/resultat"}
)
public class ResultatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            JSONObject json = new JSONObject("{scorePartie: 10, email: ruru4.matt@gmail.com, nbQuestions: 10, classement: 0, ptsUser: 20, tauxBonneRep: 1.0, tpsReponseMoy: 0}");
            ServletOutputStream out = resp.getOutputStream();
            out.write(json.getString("scorePartie").getBytes());
            out.write(json.getString("email").getBytes());
            out.write(json.getString("nbQuestions").getBytes());
            out.write(json.getString("classement").getBytes());
            out.write(json.getString("ptsUser").getBytes());
            out.write(json.getString("tauxBonneRep").getBytes());
            out.write(json.getString("tpsReponseMoy").getBytes());
            out.flush();
            out.close();

            String sURL = "https://quizinmobile.alwaysdata.net/Stats/updateStatsStandard.php"; //just a string

            CloseableHttpClient httpclient = HttpClients.createDefault();
            HttpPost httppost = new HttpPost(sURL);

            // Request parameters and other properties.
            List<NameValuePair> params = new ArrayList<NameValuePair>(7);
            params.add(new BasicNameValuePair("user", json.getString("email")));
            params.add(new BasicNameValuePair("scPart", json.getString("scorePartie")));
            params.add(new BasicNameValuePair("TmpRepMoy", json.getString("tpsReponseMoy")));
            params.add(new BasicNameValuePair("txBonRep", json.getString("tauxBonneRep")));
            params.add(new BasicNameValuePair("nbQue", json.getString("nbQuestions")));
            params.add(new BasicNameValuePair("ptsUs", json.getString("ptsUser")));
            params.add(new BasicNameValuePair("clmt", json.getString("classement")));
            httppost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));

            //Execute and get the response.
            HttpResponse response = httpclient.execute(httppost);
            HttpEntity entity = response.getEntity();

        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}