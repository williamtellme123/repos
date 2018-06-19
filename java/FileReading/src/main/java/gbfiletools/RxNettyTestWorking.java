package java.gbfiletools;

// RX Netty Test
//import io.netty.buffer.ByteBuf;
//import io.netty.buffer.Unpooled;
//import io.reactivex.netty.RxNetty;
//import io.reactivex.netty.channel.ObservableConnection;
//import io.reactivex.netty.server.RxServer;
//
//import java.util.Iterator;
//import java.util.concurrent.atomic.AtomicInteger;
//
public class RxNettyTestWorking {
//
//    public static void main(String[] args) throws Exception {
//        RxServer<ByteBuf, ByteBuf> tcpServer = RxNetty.createTcpServer(1111, connection -> {
//            System.out.println("Connection open");
//            return connection.getInput()
//                    .flatMap(byteBuf -> connection.writeAndFlush(Unpooled.copiedBuffer(byteBuf)));
//        }).start();
//        ObservableConnection<ByteBuf, ByteBuf> connection = RxNetty.createTcpClient("localhost", 1111)
//                .connect().toBlocking().first();
//        System.out.println("Client sending");
//        AtomicInteger count = new AtomicInteger();
//        Iterator<ByteBuf> byteBufs = connection.getInput().map(b -> Unpooled.copiedBuffer(b))
//                .toBlocking().toIterable().iterator();
//        for (int j = 0; j < 100; j++) {
//            long now = System.currentTimeMillis();
//            for (int i = 0; i < 1000; i++) {
//                ByteBuf msg = Unpooled.buffer().writeInt(count.incrementAndGet());
//                connection.writeAndFlush(msg).toBlocking().subscribe();
//                ByteBuf byteBuf = byteBufs.next();
//            }
//            System.out.println(System.currentTimeMillis() - now);
//        }
//        System.out.println("Done");
//    }
}