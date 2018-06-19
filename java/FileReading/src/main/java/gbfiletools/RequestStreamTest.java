package java.gbfiletools;

//import io.reactivesocket.*;
//import io.reactivesocket.aeron.client.AeronClientDuplexConnection;
//import io.reactivesocket.aeron.client.AeronClientDuplexConnectionFactory;
//import io.reactivesocket.aeron.server.ReactiveSocketAeronServer;
//import org.reactivestreams.Publisher;
//import rx.Observable;
//import rx.RxReactiveStreams;
//import uk.co.real_logic.aeron.driver.MediaDriver;
//import uk.co.real_logic.aeron.driver.ThreadingMode;
//import uk.co.real_logic.agrona.concurrent.BackoffIdleStrategy;
//import uk.co.real_logic.agrona.concurrent.NoOpIdleStrategy;
//
//import java.net.InetSocketAddress;
//import java.nio.ByteBuffer;
//import java.util.List;
//
//import static uk.co.real_logic.aeron.driver.MediaDriver.launch;

public class RequestStreamTest {
//    private static MediaDriver mediaDriver;
//    static int port = 39792;
//    static String host = "localhost";
//
//    public static void main(String[] args) throws Exception {
//        startMediaDriver();
//        ReactiveSocketAeronServer server = ReactiveSocketAeronServer.create(host, port, setupPayload -> {
//            return new RequestHandler.Builder().withRequestStream(payload ->
//                    RxReactiveStreams.toPublisher(Observable.just(payload(1), payload(2), payload(3)))).build();
//        });
//
//        ReactiveSocket client = createClient();
//
//        for (int i = 0; i < 10; i++) {
//            System.out.println();
//            List<Payload> list = RxReactiveStreams
//                    .toObservable(client.requestStream(payload(0)))
//                    .toList().toBlocking().first();
//            for (Payload p : list) {
//                System.out.print(p.getData().getInt(0) + " ");
//            }
//        }
//        System.out.println("Closing client");
//        client.close();
//        System.out.println("Closing server");
//        server.close();
//        System.out.println("Closing media driver");
//        mediaDriver.close();
//        System.out.println("Done");
//    }
//
//    public static ReactiveSocket createClient() {
//        AeronClientDuplexConnectionFactory cf = AeronClientDuplexConnectionFactory.getInstance();
//        InetSocketAddress address = new InetSocketAddress(host, port);
//        cf.addSocketAddressToHandleResponses(address);
//        Publisher<AeronClientDuplexConnection> udpConnection = cf.createAeronClientDuplexConnection(address);
//        AeronClientDuplexConnection connection = RxReactiveStreams.toObservable(udpConnection).toBlocking().single();
//        ConnectionSetupPayload setup = ConnectionSetupPayload.create("UTF-8", "UTF-8", ConnectionSetupPayload.NO_FLAGS);
//        ReactiveSocket reactiveSocket = ReactiveSocket.fromClientConnection(connection, setup);
//        reactiveSocket.startAndWait();
//        return reactiveSocket;
//    }
//
//    public static void startMediaDriver() {
//        ThreadingMode threadingMode = ThreadingMode.SHARED;
//
//        boolean dedicated = Boolean.getBoolean("dedicated");
//
//        if (dedicated) {
//            threadingMode = ThreadingMode.DEDICATED;
//        }
//
//        System.out.println("ThreadingMode => " + threadingMode);
//
//        final MediaDriver.Context ctx = new MediaDriver.Context()
//                .threadingMode(threadingMode)
//                .dirsDeleteOnStart(true)
//                .conductorIdleStrategy(new BackoffIdleStrategy(1, 1, 100, 1000))
//                .receiverIdleStrategy(new NoOpIdleStrategy())
//                .senderIdleStrategy(new NoOpIdleStrategy());
//        ctx.driverTimeoutMs(Long.MAX_VALUE);
//
//        mediaDriver = launch(ctx);
//    }
//
//    public static Payload payload(int i) {
//        ByteBuffer data = ByteBuffer.allocate(4).putInt(0, i);
//        data.position(0);
//        return new Payload() {
//            @Override
//            public ByteBuffer getData() {
//                return data;
//            }
//
//            @Override
//            public ByteBuffer getMetadata() {
//                return Frame.NULL_BYTEBUFFER;
//            }
//        };
//    }
}