package main.java.java8channels;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;

import static java.lang.Integer.MAX_VALUE;
import static java.lang.System.out;
import static java.nio.channels.FileChannel.MapMode.READ_ONLY;
import static java.nio.channels.FileChannel.MapMode.READ_WRITE;

//    RandomAccessFile	write=337,244,246	read=741,693,073 bytes/sec
//    RandomAccessFile	write=450,134,622	read=745,540,589 bytes/sec
//    RandomAccessFile	write=339,086,882	read=944,431,634 bytes/sec
//    RandomAccessFile	write=341,589,525	read=781,679,389 bytes/sec
//    RandomAccessFile	write=344,404,271	read=851,470,741 bytes/sec
//    BufferedStreamFile	write=62,740,292	read=293,767,481 bytes/sec
//    BufferedStreamFile	write=223,568,582	read=297,199,245 bytes/sec
//    BufferedStreamFile	write=245,012,711	read=293,241,695 bytes/sec
//    BufferedStreamFile	write=246,605,858	read=292,446,094 bytes/sec
//    BufferedStreamFile	write=245,541,468	read=292,310,437 bytes/sec
//    BufferedChannelFile	write=333,116,460	read=359,708,439 bytes/sec
//    BufferedChannelFile	write=204,590,294	read=358,763,247 bytes/sec
//    BufferedChannelFile	write=281,676,580	read=757,326,430 bytes/sec
//    BufferedChannelFile	write=287,499,122	read=359,014,812 bytes/sec
//    BufferedChannelFile	write=280,903,885	read=357,901,175 bytes/sec
//    MemoryMappedFile	write=122,104,635	read=335,366,602 bytes/sec
//    MemoryMappedFile	write=241,267,597	read=294,147,217 bytes/sec
//    MemoryMappedFile	write=314,242,970	read=367,321,316 bytes/sec
//    MemoryMappedFile	write=303,654,829	read=370,796,179 bytes/sec
//    MemoryMappedFile	write=327,065,117	read=382,821,627 bytes/sec
//



public final class TestSequentialIoPerf
{
    public static final int PAGE_SIZE = 1024 * 4;
    public static final long FILE_SIZE = PAGE_SIZE * 2000L * 1000L;
    public static final String FILE_NAME = "Twitter.data";
    public static final byte[] BLANK_PAGE = new byte[PAGE_SIZE];

    public static void main(final String[] arg) throws Exception
    {
        preallocateTestFile(FILE_NAME);

        for (final PerfTestCase testCase : testCases)
        {
            for (int i = 0; i < 5; i++)
            {
                System.gc();
                long writeDurationMs = testCase.test(PerfTestCase.Type.WRITE,
                        FILE_NAME);

                System.gc();
                long readDurationMs = testCase.test(PerfTestCase.Type.READ,
                        FILE_NAME);

                long bytesReadPerSec = (FILE_SIZE * 1000L) / readDurationMs;
                long bytesWrittenPerSec = (FILE_SIZE * 1000L) / writeDurationMs;

                out.format("%s\twrite=%,d\tread=%,d bytes/sec\n",
                        testCase.getName(),
                        bytesWrittenPerSec, bytesReadPerSec);
            }
        }

        deleteFile(FILE_NAME);
    }

    private static void preallocateTestFile(final String fileName)
            throws Exception
    {
        RandomAccessFile file = new RandomAccessFile(fileName, "rw");

        for (long i = 0; i < FILE_SIZE; i += PAGE_SIZE)
        {
            file.write(BLANK_PAGE, 0, PAGE_SIZE);
        }

        file.close();
    }

    private static void deleteFile(final String testFileName) throws Exception
    {
        File file = new File(testFileName);
        if (!file.delete())
        {
            out.println("Failed to delete test file=" + testFileName);
            out.println("Windows does not allow mapped files to be deleted.");
        }
    }

    public abstract static class PerfTestCase
    {
        public enum Type { READ, WRITE }

        private final String name;
        private int checkSum;

        public PerfTestCase(final String name)
        {
            this.name = name;
        }

        public String getName()
        {
            return name;
        }

        public long test(final Type type, final String fileName)
        {
            long start = System.currentTimeMillis();

            try
            {
                switch (type)
                {
                    case WRITE:
                    {
                        checkSum = testWrite(fileName);
                        break;
                    }

                    case READ:
                    {
                        final int checkSum = testRead(fileName);
                        if (checkSum != this.checkSum)
                        {
                            final String msg = getName() +
                                    " expected=" + this.checkSum +
                                    " got=" + checkSum;
                            throw new IllegalStateException(msg);
                        }
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }

            return System.currentTimeMillis() - start;
        }

        public abstract int testWrite(final String fileName) throws Exception;
        public abstract int testRead(final String fileName) throws Exception;
    }

    private static PerfTestCase[] testCases =
            {
                    new PerfTestCase("RandomAccessFile")
                    {
                        public int testWrite(final String fileName) throws Exception
                        {
                            RandomAccessFile file = new RandomAccessFile(fileName, "rw");
                            final byte[] buffer = new byte[PAGE_SIZE];
                            int pos = 0;
                            int checkSum = 0;

                            for (long i = 0; i < FILE_SIZE; i++)
                            {
                                byte b = (byte)i;
                                checkSum += b;

                                buffer[pos++] = b;
                                if (PAGE_SIZE == pos)
                                {
                                    file.write(buffer, 0, PAGE_SIZE);
                                    pos = 0;
                                }
                            }

                            file.close();

                            return checkSum;
                        }

                        public int testRead(final String fileName) throws Exception
                        {
                            RandomAccessFile file = new RandomAccessFile(fileName, "r");
                            final byte[] buffer = new byte[PAGE_SIZE];
                            int checkSum = 0;
                            int bytesRead;

                            while (-1 != (bytesRead = file.read(buffer)))
                            {
                                for (int i = 0; i < bytesRead; i++)
                                {
                                    checkSum += buffer[i];
                                }
                            }

                            file.close();

                            return checkSum;
                        }
                    },

                    new PerfTestCase("BufferedStreamFile")
                    {
                        public int testWrite(final String fileName) throws Exception
                        {
                            int checkSum = 0;
                            OutputStream out =
                                    new BufferedOutputStream(new FileOutputStream(fileName));

                            for (long i = 0; i < FILE_SIZE; i++)
                            {
                                byte b = (byte)i;
                                checkSum += b;
                                out.write(b);
                            }

                            out.close();

                            return checkSum;
                        }

                        public int testRead(final String fileName) throws Exception
                        {
                            int checkSum = 0;
                            InputStream in =
                                    new BufferedInputStream(new FileInputStream(fileName));

                            int b;
                            while (-1 != (b = in.read()))
                            {
                                checkSum += (byte)b;
                            }

                            in.close();

                            return checkSum;
                        }
                    },


                    new PerfTestCase("BufferedChannelFile")
                    {
                        public int testWrite(final String fileName) throws Exception
                        {
                            FileChannel channel =
                                    new RandomAccessFile(fileName, "rw").getChannel();
                            ByteBuffer buffer = ByteBuffer.allocate(PAGE_SIZE);
                            int checkSum = 0;

                            for (long i = 0; i < FILE_SIZE; i++)
                            {
                                byte b = (byte)i;
                                checkSum += b;
                                buffer.put(b);

                                if (!buffer.hasRemaining())
                                {
                                    buffer.flip();
                                    channel.write(buffer);
                                    buffer.clear();
                                }
                            }

                            channel.close();

                            return checkSum;
                        }

                        public int testRead(final String fileName) throws Exception
                        {
                            FileChannel channel =
                                    new RandomAccessFile(fileName, "rw").getChannel();
                            ByteBuffer buffer = ByteBuffer.allocate(PAGE_SIZE);
                            int checkSum = 0;

                            while (-1 != (channel.read(buffer)))
                            {
                                buffer.flip();

                                while (buffer.hasRemaining())
                                {
                                    checkSum += buffer.get();
                                }

                                buffer.clear();
                            }

                            return checkSum;
                        }
                    },

                    new PerfTestCase("MemoryMappedFile")
                    {
                        public int testWrite(final String fileName) throws Exception
                        {
                            FileChannel channel =
                                    new RandomAccessFile(fileName, "rw").getChannel();
                            MappedByteBuffer buffer =
                                    channel.map(READ_WRITE, 0,
                                            Math.min(channel.size(), MAX_VALUE));
                            int checkSum = 0;

                            for (long i = 0; i < FILE_SIZE; i++)
                            {
                                if (!buffer.hasRemaining())
                                {
                                    buffer =
                                            channel.map(READ_WRITE, i,
                                                    Math.min(channel.size() - i , MAX_VALUE));
                                }

                                byte b = (byte)i;
                                checkSum += b;
                                buffer.put(b);
                            }

                            channel.close();

                            return checkSum;
                        }

                        public int testRead(final String fileName) throws Exception
                        {
                            FileChannel channel =
                                    new RandomAccessFile(fileName, "rw").getChannel();
                            MappedByteBuffer buffer =
                                    channel.map(READ_ONLY, 0,
                                            Math.min(channel.size(), MAX_VALUE));
                            int checkSum = 0;

                            for (long i = 0; i < FILE_SIZE; i++)
                            {
                                if (!buffer.hasRemaining())
                                {
                                    buffer =
                                            channel.map(READ_WRITE, i,
                                                    Math.min(channel.size() - i , MAX_VALUE));
                                }

                                checkSum += buffer.get();
                            }

                            channel.close();

                            return checkSum;
                        }
                    },
            };
}