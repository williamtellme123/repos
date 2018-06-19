
@SuppressWarnings("all")
@org.apache.avro.specific.AvroGenerated
public interface TwitterService {
  public static final org.apache.avro.Protocol PROTOCOL = org.apache.avro.Protocol.parse("{\"protocol\":\"TwitterService\",\"namespace\":null,\"types\":[{\"type\":\"record\",\"name\":\"TweetRecord\",\"fields\":[{\"name\":\"tweetId\",\"type\":\"int\"},{\"name\":\"text\",\"type\":\"string\"},{\"name\":\"username\",\"type\":\"string\"}]},{\"type\":\"error\",\"name\":\"SendError\",\"fields\":[{\"name\":\"message\",\"type\":\"string\"}]}],\"messages\":{\"sendTweet\":{\"request\":[{\"name\":\"tweet\",\"type\":\"TweetRecord\"}],\"response\":\"null\",\"errors\":[\"SendError\"]}}}");
  java.lang.Void sendTweet(TweetRecord tweet) throws org.apache.avro.AvroRemoteException, SendError;

  @SuppressWarnings("all")
  public interface Callback extends TwitterService {
    public static final org.apache.avro.Protocol PROTOCOL = TwitterService.PROTOCOL;
    void sendTweet(TweetRecord tweet, org.apache.avro.ipc.Callback<java.lang.Void> callback) throws java.io.IOException;
  }
}