package example;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

import org.apache.http.HttpException;
import org.apache.http.client.HttpClient;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;

//import Curl.curl;
public class Hello implements RequestHandler<String, String> {
		public String handleRequest(String input, Context context) {
		
//		HttpPost mypost = new HttpPost("https://hooks.slack.com/services/T4FKBC1N3/B4LPEMV0B/qkmXuVZXfyFEcXWWW1AaDA9");
//		mypost.setHeader("Content-type", "application/json");
//		String ApiUrl = "https://hooks.slack.com/services/T4FKBC1N3/B4LPEMV0B/qkmXuVZXfyFEcXWWW1AaDA9"; 
    	String output = "Hello, " + input + "!";
    	return output;
//    	HttpResponse response2 = curl().k().xUpperCase("POST").d("{\"var1\":\"val1\",\"var2\":\"val2\"}").run("https://localhost:8443/public/json");
    	
//    	return curl("-k -X POST 'https://localhost:8443/public/json' -d '{\"var1\":\"val1\",\"var2\":\"val2\"}'");
//    	return curl("-k -X POST --data-urlencode 'payload={\"channel\": \"#general\", \"username\": \"webhookbot\", \"text\": \"Happy Birthday Mr. President.\", \"icon_emoji\": \":ghost:\"}'");
    	

 }
}		


