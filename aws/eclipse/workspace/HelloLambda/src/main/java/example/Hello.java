package example;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.GetMethod; 

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
//https://stackoverflow.com/questions/42851183/execute-curl-command-from-java-code

public class Hello implements RequestHandler<String, String> {
    
	public static String invokeCurlPost(String _host, int _connectTimeout, int _maxTimeout, int _maxResLength, Charset _charset) throws IOException
    {
	
		byte[] res = execute("curl -X POST -H \'Content-type: application/json\' --data \'{\"text\":\"Big Sloppy Joe for dinner!\"}\' " + _host, _maxResLength);

        return new String(res, _charset);
    }
	public static byte[] execute(String _cmd, int _maxResLength) throws IOException
    {
        Process process = Runtime.getRuntime().exec(_cmd);

        try
        {
            int result = process.waitFor();
            if(result != 0)
            {
                throw new IOException("Fail to execute cammand. Exit Value[" + result + "], cmd => " + _cmd);
            }
        }
        catch(InterruptedException e)
        {
            process.destroyForcibly();

            throw new IOException(e);
        }

        BufferedInputStream in = null;

        try
        {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            in = new BufferedInputStream(process.getInputStream());
            byte[] buf = new byte[1024];
            int read = 0;

            while((read = in.read(buf)) != -1)
            {
                out.write(buf, 0, read);
                out.flush();

                if(_maxResLength > 0 && out.size() > _maxResLength)
                {
                    throw new IOException("Response length exceeded.");
                }
            }

            return out.toByteArray();
        }
        finally
        {
            if(in != null)
            {
                in.close();
            }
        }
    }
	public String handleRequest(String input, Context context) {
	
//    	try {
//			System.out.println(invokeCurlPost("https://hooks.slack.com/services/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", 3, 10, 0, Charset.defaultCharset()));
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}	
	
    	String output = "Hello, " + input + "!";
    	return output;
	
	
	}
}