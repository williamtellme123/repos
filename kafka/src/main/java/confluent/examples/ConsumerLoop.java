package confluent.examples;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.errors.WakeupException;
import org.apache.kafka.common.serialization.StringDeserializer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class ConsumerLoop implements Runnable {

    private final KafkaConsumer<String, String> consumer;
    private final List<String> topics;
    private final int id;

    public ConsumerLoop(int id,
                        String groupId,
                        List<String> topics) {
        this.id = id;
        this.topics = topics;
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092");
        props.put("group.id", groupId);
        props.put("key.deserializer", StringDeserializer.class.getName());
        props.put("value.deserializer", StringDeserializer.class.getName());
        this.consumer = new KafkaConsumer<>(props);
    } // end of constructor

    @Override
    public void run() {
        try {

            // CONSUMER MUST 1st SUBSCRIBE
            // Now consumer can coordinate with the rest of group
            //     to gets it partition assignment
            //     Handled automatically when you begin consuming data
            // NOTE: you can also assign partitions manually

            consumer.subscribe(topics);
            // Must indicate full list of topics once or replace existing with new

                //    POLLING
                //    Device is given a command i.e. "move read head to sec42"
                //    Device driver either poll the device or use interrupts to determine completion
                //    Polling reads device status register every so often until completion
                //    Polling device drivers use system timers to have the kernel call a routine within the device driver at some later time.
                //    This timer routine would check the status of the command and this is exactly how Linux's floppy driver works.
                //    Polling by means of timers is at best approximate, a much more efficient method is to use interrupts.
                //
                //    POLLING can be described in following steps:
                //
                //    1. Host repeatedly reads busy bit of controller until it becomes clear
                //    2. Host writes in command register and writes a byte into the data-out register
                //    3. Host sets the command-ready bit (set to 1)
                //    4. When controller senses command-ready bit set, it sets busy bit
                //    5. Controller reads command register and
                //                  since write bit is set, it performs necessary I/O operations on the device.
                //                  If the read bit is set to one instead of write bit, data from device is loaded into data-in register, which is further read by the host.
                //    5. Controller clears the command-ready bit once everything is over, clears error bit to show successful operation and resets busy bit (0).

                // Consumer needs fetch data in parallel, potentially from
                //      many partitions
                //      for many topics
                //      spread across many brokers

                // Consumer uses API style similar to unix poll
                //      once topics are registered, all future coordination,
                //      rebalancing, and data fetching is driven through a single poll call
                //      meant to be invoked in an event loop. This allows for a simple
                //      and efficient implementation which can handle all IO from a single thread.
                //
                // After subscribing to topic
                //      Must start event loop to get a partition assignment and begin fetching data.
                //      Simply call poll in a loop and the consumer handles the rest.
                //
                //      Each call to poll returns a (possibly empty) set of messages from the
                //      partitions that were assigned. The example below shows a basic poll loop which prints
                //      the offset and value of fetched records as they arrive:
            while (true) {
                ConsumerRecords<String, String> records = consumer.poll(Long.MAX_VALUE);
                // POLL
                // Poll API returns fetched records based on current position.
                // On create group position set according to the reset policy
                // either earliest or latest offset for each partition.
                // Once consumer begins committing offsets, each later
                // rebalance will reset to last committed offset.
                // The parameter passed to poll controls the maximum amount of time
                // consumer blocks while waiting 4 records at current position.
                // Consumer returns immediately as soon as any records are available,
                // or wait timeout before returning if nothing available.

                // Consumer designed to run in its own thread. Not safe for multithreading without external synch

                for (ConsumerRecord<String, String> record : records) {
                    Map<String, Object> data = new HashMap<>();
                    data.put("partition", record.partition());
                    data.put("offset", record.offset());
                    data.put("value", record.value());
                    System.out.println(this.id + ": " + data);
                }
            }
        } catch (WakeupException e) {
            // ignore for shutdown
        } finally {
            consumer.close();
        }
    } // end of run

    public void shutdown() {
        consumer.wakeup();
    }


}