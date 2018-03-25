package istic.tlc.measure;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

public class TestThread extends Thread {
	
	static String listAds = "Titre 1;1235.12;voici ma premiere description\n"
			+ "Titre 2;1235;deuxieme description \n" + "Titre 3;333;troisieme description";

	static String urlLocalhost = "http://localhost:8080/sign";
	static String urlCloud = "http://proj-pub-cuicui.appspot.com/sign";

	  public TestThread(String name){
	    super(name);
	  }
	  public void run(){

			String data;
			try {
				data = URLEncoder.encode("categoryName", "UTF-8") + "=" + URLEncoder.encode("default", "UTF-8");
				data += "&" + URLEncoder.encode("listAds", "UTF-8") + "=" + URLEncoder.encode(listAds, "UTF-8");
			//	URL url = new URL(urlLocalhost);
				URL url = new URL(urlCloud);
				
				URLConnection conn = url.openConnection();
				conn.setDoOutput(true);
				OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
				wr.write(data);
				wr.flush();
				long timeDebut = System.currentTimeMillis();

				BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			    long timeFin = System.currentTimeMillis();
				long latence = timeFin - timeDebut;
				System.out.println("[REQ "+this.getName()+"] latence = "+latence+ " ms");

				wr.close();
				rd.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

			
			


	  }       
	}