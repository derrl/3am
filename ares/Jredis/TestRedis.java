import java.io.*;
import redis.clients.jedis.Jedis;
import java.util.Random;
import java.lang.System.*;

public class TestRedis extends Thread
{
	static Jedis redis = new Jedis("localhost");
	static int dataSize = 500*1024*1024;

	public void testWrite(int size, Jedis targetRedis){
		//byte[] b = new byte[500*1024*1024];
		byte[] b = new byte[size];
		new Random().nextBytes(b);
		long startTime = System.nanoTime();
		targetRedis.set("kkkk".getBytes(), b);
		//redis.set("kkkk".getBytes(), b);
		long endTime = System.nanoTime();
		System.out.println("SET cost "+(endTime - startTime)/1000000000.0 + " s"); 
		b = null;
	}
		
	public static void main(String[] args) throws Exception{
		TestRedis os = new TestRedis();
		os.testWrite(dataSize, redis);
	}
}
