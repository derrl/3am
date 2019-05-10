import java.io.*;
import redis.clients.jedis.*;
import java.util.Random;
import java.util.Set;
import java.util.HashSet;
import java.lang.System.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
//import redis.clients.jedis.Jedis;
//import redis.clients.jedis.JedisPool;
//import redis.clients.jedis.JedisPoolConfig;

class TestRedis extends Thread
{
	static int DATASIZE = 16*1024*1024;
	static int COUNT = 64;
        //JedisPool jedisPool = new JedisPool("ares.ares.lcoal");
        //JedisPool jedisPool = new JedisPool("ares.ares.lcoal", 6379);
        JedisPool jedisPool;
	Set<HostAndPort> jedisClusterNode;
	static String hostname;
	static int num_threads=0;

TestRedis(JedisPool jedisPoolll){
	jedisPool = jedisPoolll;
}

TestRedis(Set<HostAndPort> jedisClusterNodeee, String hostnameee, int nt){
	jedisClusterNode = jedisClusterNodeee;
	hostname = hostnameee;
	num_threads =nt;
}

TestRedis(Set<HostAndPort> jedisClusterNodeee, String hostnameee, int nt,int ds, int cnt){
	jedisClusterNode = jedisClusterNodeee;
	hostname = hostnameee;
	num_threads =nt;
	DATASIZE=ds;
	COUNT=cnt;
}

public void run() 
    { 
        try
        { 
            System.out.println ("Thread " + Thread.currentThread().getId() + " is running"); 
	    //Jedis redis = jedisPool.getResource();
            JedisCluster redis = new JedisCluster(jedisClusterNode);
            //System.out.println ("Get resource success"); 
	    testWrite(DATASIZE, redis);
	    redis.close();
	    //jedisPool.close();
        } 
        catch (Exception e) 
        { 
            System.out.println ("Exception is caught"); 
        } 
    } 

	//public static void testWrite(int size, Jedis targetRedis){
	public static void testWrite(int size, JedisCluster targetRedis) throws IOException
	{
		byte[] b = new byte[size];
		new Random().nextBytes(b);
		long runtime = 0;


		long startTime = System.nanoTime();
		for (int i = 0; i < COUNT; i++) {
			String key = hostname + Thread.currentThread().getId()  + i+DATASIZE;
                	//System.out.println ("Start writing. key is " + key); 
			//long startTime = System.nanoTime();
			//targetRedis.set(key.getBytes(), b);
			targetRedis.get(key.getBytes());
			//long endTime = System.nanoTime();
			//runtime += endTime - startTime;
		}
		long endTime = System.nanoTime();
		runtime = endTime - startTime;
		//System.out.println("SET "+COUNT+"*"+DATASIZE+" Bytes cost "+runtime/1000000000.0 + " s"); 
		System.out.println("GET "+COUNT+"*"+DATASIZE+" Bytes cost "+runtime/1000000000.0 + " s"); 

		FileWriter fileWriter = new FileWriter("RedisTestRes"+num_threads+hostname+".txt", true);
	    	PrintWriter printWriter = new PrintWriter(fileWriter);
	    	printWriter.println("Start time is " + startTime);
	    	printWriter.println("End time is " + endTime);
    		//printWriter.printf("Run time is %f\n", runtime/1000000000.0);
		printWriter.println("SET "+COUNT+"*"+DATASIZE+" Bytes cost "+runtime/1000000000.0 + " s"); 
		printWriter.close();

		b = null;
	}
}


public class MultithreadTestRedisCluster 
{ 
    private static int THREADS = 10;
    static JedisPool jedisPool = new JedisPool("localhost", 6379);
    //static JedisPool jedisPool = new JedisPool("ares.ares.local", 6379);


    public static void main(String[] args) throws IOException
    { 

	InetAddress ip;
	String hostname = "ares";
	try {
		ip = InetAddress.getLocalHost();
	 	hostname = ip.getHostName();	
		System.out.println("Current Hostname is: "+ hostname);
	} catch (UnknownHostException e) {
		e.printStackTrace();
	}

        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(300);
        config.setMaxIdle(2);
	Set<HostAndPort> jedisClusterNode = new HashSet<HostAndPort>();
	jedisClusterNode.add(new HostAndPort("172.25.201.01", 7001));
	jedisClusterNode.add(new HostAndPort("172.25.201.02", 7001));
	jedisClusterNode.add(new HostAndPort("172.25.201.03", 7001));
	jedisClusterNode.add(new HostAndPort("172.25.201.04", 7001));
	jedisClusterNode.add(new HostAndPort("172.25.201.05", 7001));
	jedisClusterNode.add(new HostAndPort("172.25.201.06", 7001));
	jedisClusterNode.add(new HostAndPort("172.25.201.07", 7001));
	jedisClusterNode.add(new HostAndPort("172.25.201.08", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.09", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.10", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.11", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.12", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.13", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.14", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.15", 7001));
//	jedisClusterNode.add(new HostAndPort("172.25.201.16", 7001));

	jedisClusterNode.add(new HostAndPort("172.25.201.01", 7002));
	jedisClusterNode.add(new HostAndPort("172.25.201.02", 7002));
	jedisClusterNode.add(new HostAndPort("172.25.201.03", 7002));
	jedisClusterNode.add(new HostAndPort("172.25.201.04", 7002));
	jedisClusterNode.add(new HostAndPort("172.25.201.05", 7002));
	jedisClusterNode.add(new HostAndPort("172.25.201.06", 7002));
	jedisClusterNode.add(new HostAndPort("172.25.201.07", 7002));
	jedisClusterNode.add(new HostAndPort("172.25.201.08", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.09", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.10", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.11", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.12", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.13", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.14", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.15", 7002));
//	jedisClusterNode.add(new HostAndPort("172.25.201.16", 7002));


        //JedisCluster jc = new JedisCluster(jedisClusterNode, config);
        //JedisCluster jcd = new JedisCluster(jedisClusterNode);
        //jcd.set("name","doge");
        //String value = jcd.get("name");
        //System.out.println(value);
        //jcd.flushDB();
	//jcd.close();

	if (args.length != 0)
		THREADS = Integer.parseInt(args[0]);
	int ds=0;
	int cnt=0;
	if (args.length == 3){
		ds=Integer.parseInt(args[1]);
		cnt=Integer.parseInt(args[2]);
	}

		

        int n = THREADS; // Number of threads 
        for (int i=0; i<n; i++) 
        { 
            //TestRedis object = new TestRedis(); 
            //TestRedis object = new TestRedis(jedisPool); 
            //TestRedis object = new TestRedis(jedisClusterNode, hostname, n); 
	    if(args.length == 3){
                TestRedis object = new TestRedis(jedisClusterNode, hostname, n, ds, cnt); 
            	object.start(); 
	    }
	    else{
                TestRedis object = new TestRedis(jedisClusterNode, hostname, n); 
            	object.start(); 
            }
        } 
	

	String fileContent = "Thread number:"+THREADS;
     
    	FileWriter fileWriter = new FileWriter("RedisTestRes"+THREADS+hostname+".txt", true);
    	PrintWriter printWriter = new PrintWriter(fileWriter,true);
    	printWriter.println(fileContent);
	printWriter.close();

    } 
} 
