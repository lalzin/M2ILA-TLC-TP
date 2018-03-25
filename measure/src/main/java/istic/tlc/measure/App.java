package istic.tlc.measure;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

/**
 *
 * Program by Simon LEDOUX-LEVIN & Alan MARZIN
 */
public class App {

	public static void main(String[] args) throws Exception {

		System.out.println("******** DEBUT lancement des threads)*********");

		int nbReq = 10;

		for (int i = 0; i < nbReq; i++) {

			TestThread t = new TestThread("Num" + i);
			t.start();
		}

		System.out.println("******** FIN lancement des threads)*********");

	}

}