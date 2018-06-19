package java.gbfiletools;

// Ping Pong
// https://gist.github.com/krisskross/70c4c425d3ef82a3be51
//import io.netty.buffer.ByteBuf;
//import io.netty.buffer.Unpooled;
//import io.reactivex.netty.RxNetty;
//import io.reactivex.netty.channel.ObservableConnection;
//import io.reactivex.netty.server.RxServer;
//
public class RxNettyTest {
//    public static void main(String[] args) throws Exception {
//        RxServer<ByteBuf, ByteBuf> tcpServer = RxNetty.createTcpServer(1111, connection -> {
//            System.out.println("Connection open");
//            return connection.getInput()
//                    .flatMap(byteBuf -> {
//                        System.out.println("req " + byteBuf.getInt(0));
//                        return connection.writeAndFlush(Unpooled.copiedBuffer(byteBuf));
//                    });
//        }).start();
//        ObservableConnection<ByteBuf, ByteBuf> connection = RxNetty.createTcpClient("localhost", 1111).connect().toBlocking().first();
//        for (int i = 0; i < 10000; i++) {
//            ByteBuf req = Unpooled.buffer().writeInt(i);
//            ByteBuf res = connection.writeAndFlush(req)
//                    .cast(ByteBuf.class)
//                    .concatWith(connection.getInput())
//                    .map(b -> Unpooled.copiedBuffer(b))
//                    .take(1)
//                    .toBlocking()
//                    .first();
//            System.out.println("res " + res.getInt(0));
//        }
//    }
}