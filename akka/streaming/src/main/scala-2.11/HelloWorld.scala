
//    import akka.actor.ActorSystem
//    import akka.stream.ActorMaterializer
//    import akka.stream.javadsl.Sink incorrect Sink for val sink = Sink.fold[Int, Int](0)(_ + _)
import akka.actor._
import akka.stream._
import akka.stream.scaladsl._
import scala.concurrent._


object HelloWorld {
  def main(args: Array[String]): Unit = {
//    println(" ----------------------------------------- Example No. 1!")
//    // http://doc.akka.io/docs/akka/2.4.2/scala/stream/stream-quickstart.html#stream-quickstart-scala
//    // create actor system
//    // create materializer
//    implicit val system = ActorSystem("QuickStart")
//    implicit val materializer = ActorMaterializer() // ActorMaterializer factory for strm exec engines
//    val source: Source[Int, NotUsed] = Source(1 to 100)
//    // pass a consumer function to a actor who runs it
//    source.runForeach(i => println(i))(materializer)
//    println(" --------------- Prints 1 - 100")
//
//
//    println(" ----------------------------------------- Example No. 2!")
//    //    http://doc.akka.io/docs/akka/2.4.2/scala/stream/stream-quickstart.html#stream-quickstart-scala
//    val factorials = source.scan(BigInt(1))((acc, next) => acc * next)
//    // BigInt is a combinator
//    // Scan combinator
//    //    1. computes stream: starting number 1 (BigInt(1))
//    //    2. multiplies each incoming number
//    //    3. emits initial value and calculation result
//    //    4. converts results into a stream of ByteString objects (lines)    //
//    //       Note: Yields factorials, and stored nothing actually computed just described
//    //
//    //    5. Run by attaching file as receiver (sink)
//    //       Note: IOResult is type that IO operations return from Akka Streams
//    //        in order to tell you how many bytes or elements were consumed and
//    //        whether the stream terminated normally or exceptionally
//    val result: Future[IOResult] =
//      factorials
//        .map(num => ByteString(s"$num\n"))
//        .runWith(FileIO.toFile(new File("factorials.txt")))

    println(" ----------------------------------------- Example No. 3!")
    //  PHILOSOPHY
    //  http://doc.akka.io/docs/akka/2.4.2-RC3/general/stream/stream-design.html#stream-design
    //   RULES
    //      All features are explicit in API
    //      Supreme compositionality: combined pieces retain the function of each part
    //      Exhaustive model of the domain of distributed bounded stream processing
    //
    //    ALL TOOLS NECESSARY
    //      back-pressure
    //      buffering
    //      transformations
    //      failure recovery
    //
    //    AKKA STREAMS
    //        Do not send dropped e's to dead letter office
    //        Cannot ensure all e's sent are processed
    //        E's can be dropped:
    //          - plain code consumes e1 in a map(...) results e2
    //          - common stream ops drop e's intentionally
    //              e.g. take/drop/filter/conflate/buffer/…
    //          - stream failure tears down stream no wait to finish, all e's inflight discarded
    //          - stream cancellation propagates upstream, upstream terminated before process done
    //              e.g. from a take operator
    //    AKKA CLEANUP
    //        Requires user to ensure cleanup outside Akka Streams facilities e.g.
    //          - cleaning them up after a timeout
    //          - after results observed
    //          - using finalizers




    // VOCABULARY
    //    Source: something with exactly one output stream
    //      Sink: something with exactly one input stream
    //      Flow: something with exactly one input and one output stream
    //  BidiFlow: something with exactly two input streams and two output streams
    //            conceptually behave like two Flows of opposite direction
    //     Graph: packaged stream processing topology that exposes certain set of
    //            input and output ports, characterized by an object of type Shape
    //
    // REACTIVE MANIFESTO
    // http://www.reactivemanifesto.org/
    //
    //    FAILURE VS ERROR
    //
    //    FAILURE
    //      Unexpected within service,
    //      Preventing continuance
    //      Generally prevents responses to current & following requests
    //      Are unexpected and require intervention before normal ops
    //      Examples hardware,  resource exhaustion, defects create corrupted internal state
    //      Not always fatal, but system reduced
    //
    //    ERROR
    //      Expected: input error commed back to client, normal after error




    println(" --------------- Create ActorSystem")
    implicit val system = ActorSystem("QuickStream")
    println(" --------------- Create Materializer")
    implicit val materializer = ActorMaterializer()
    println(" --------------- Create Source")
    val source = Source(1 to 10)

    val sink = Sink.fold[Int, Int](0)(_ + _)
    // connect the Source to the Sink, obtaining a RunnableGraph
    val runnable: RunnableGraph[Future[Int]] = source.toMat(sink)(Keep.right)

    // materialize the flow and get the value of the FoldSink
    val sum: Future[Int] = runnable.run()


    //    http://doc.akka.io/docs/akka-stream-and-http-experimental/2.0.3/scala/stream-flows-and-basics.html#core-concepts-scala
    // connect the Source to the Sink, obtaining a RunnableGraph
    //    val runnable: RunnableGraph[Future[Int]] = source.toMat(sink)(Keep.right)
    // materialize the flow and get the value of the FoldSink
    //    val sum: Future[Int] = runnable.run()
    //    println(" ----------------------------------------- Example No. 3!")
    //    // http://doc.akka.io/docs/akka-stream-and-http-experimental/2.0.3/scala/stream-quickstart.html#stream-quickstart-scala
    //    final case class Author(handle: String)
    //
    //    final case class Hashtag(name: String)
    //
    //    final case class Tweet(author: Author, timestamp: Long, body: String) {
    //      def hashtags: Set[Hashtag] =
    //        body.split(" ").collect { case t if t.startsWith("#") => Hashtag(t) }.toSet
    //    }
    //    val akka = Hashtag("#akka")



  }
}
