import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.AsynchronousFileChannel;
import java.nio.file.StandardOpenOption;
import java.nio.channels.CompletionHandler;
import java.nio.file.Paths;
import java.nio.file.Path;
import java.io.FileReader;
import java.io.BufferedReader;

public class WriteExample {

	public static void main (String [] args)
			throws Exception {
	
		new WriteExample().writeFile();
	}
	
	private void writeFile()
			throws IOException {

		String input = "Content to be written to the file.";
		System.out.println("Input string: " + input);
		byte [] byteArray = input.getBytes();

		ByteBuffer buffer = ByteBuffer.wrap(byteArray);
	
		Path path = Paths.get("writefile.txt");
		AsynchronousFileChannel channel =
			AsynchronousFileChannel.open(path, StandardOpenOption.WRITE);
			
		CompletionHandler<Integer, Object> handler = new CompletionHandler<Integer, Object>() {

			@Override
			public void completed(Integer result, Object attachment) { 
			
				System.out.println(attachment + " completed and " + 
									result + " bytes are written.");  
			} 
			@Override
			public void failed(Throwable e, Object attachment) {

				System.out.println(attachment + " failed with exception:");
				e.printStackTrace();
			}
		};
	
		channel.write(buffer, 0, "Write operation ALFA", handler);
	
		channel.close();
	
		printFileContents(path.toString());
	}
	
	private void printFileContents(String path)
			throws IOException {

		FileReader fr = new FileReader(path);
		BufferedReader br = new BufferedReader(fr);
		String textRead = br.readLine();
		
		System.out.println("File contents: ");
		
		while (textRead != null) {
		
			System.out.println("     " + textRead);
			textRead = br.readLine();
		}
		
		fr.close();
		br.close();
	}
}