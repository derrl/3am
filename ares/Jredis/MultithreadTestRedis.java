import java.io.*;
import redis.clients.jedis.Jedis;
import java.util.Random;
import java.lang.System.*;

class TestRedis extends Thread
{
	private static final int DATASIZE = 1*1024*1024;
	private static final int COUNT = 300;

public void run() 
    { 
        try
        { 
            System.out.println ("Thread " + Thread.currentThread().getId() + " is running"); 
	    Jedis redis = new Jedis("localhost");
	    testWrite(DATASIZE, redis);
        } 
        catch (Exception e) 
        { 
            System.out.println ("Exception is caught"); 
        } 
    } 

	public static void testWrite(int size, Jedis targetRedis){
		byte[] b = new byte[size];
		new Random().nextBytes(b);
		long runtime = 0;
		for (int i = 0; i < COUNT; i++) {
			String key = "kkkk" + Thread.currentThread().getId() + i;
                	System.out.println ("Start writing. key is " + key); 
			long startTime = System.nanoTime();
			targetRedis.set(key.getBytes(), b);
			long endTime = System.nanoTime();
			runtime += endTime - startTime;
		}
		System.out.println("SET "+COUNT+"*"+DATASIZE+" Bytes cost "+runtime/1000000000.0 + " s"); 
		b = null;
	}
}


public class MultithreadTestRedis
{ 
    private static final int THREADS = 10;
    public static void main(String[] args) 
    { 
        int n = THREADS; // Number of threads 
        for (int i=0; i<n; i++) 
        { 
            TestRedis object = new TestRedis(); 
            object.start(); 
        } 
    } 
} 
