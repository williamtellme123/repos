
import org.apache.avro.AvroRemoteException;
import org.apache.avro.ipc.HttpServer;
import org.apache.avro.ipc.Server;
import org.apache.avro.ipc.specific.SpecificResponder;

public class TwitterServiceImpl implements TwitterService {

	private final int port;

	public TwitterServiceImpl(int port) {
		this.port = port;
	}

	public static boolean isServerStarted;
	private static Server server;

	public static void main(String[] args) {
		TwitterServiceImpl service = new TwitterServiceImpl(9090);
		if (!TwitterServiceImpl.isServerStarted) {
			service.startServer();
		}
	}

	@Override
	public Void sendTweet(TweetRecord tweet) throws AvroRemoteException,
			SendError {

		// Echos back the contents
		System.out.println("Java server received message with id: "
				+ tweet.getTweetId() + " from user: " + tweet.getUsername()
				+ " and has text: " + tweet.getText());

		return null;
	}

	/*
	 * Start netty server to receive incoming requests from project 2
	 */
	public void startServer() {

		try {
			server = new HttpServer(new SpecificResponder(TwitterService.class,	this), port);

			server.start();
			isServerStarted = true;
		} catch (Exception e) {
			isServerStarted = false;
			server.close();
			e.printStackTrace();
		}
	}

	public void closeServer() {
		server.close();
	}

}
