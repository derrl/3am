import java.io.*;
import redis.clients.jedis.Jedis;
import java.util.Random;
//import java.lang.System;

public class FileInRedis
{
Jedis redis = new Jedis("localhost");

private static byte[] File2Bytes(String filePath) {

        FileInputStream fileInputStream = null;
        byte[] bytesArray = null;

        try {

            File file = new File(filePath);
            bytesArray = new byte[(int) file.length()];

            //read file into bytes[]
            fileInputStream = new FileInputStream(file);
            fileInputStream.read(bytesArray);
            } catch (IOException e) {
            e.printStackTrace();
            } finally {
            if (fileInputStream != null) {
            try {
            fileInputStream.close();
            } catch (IOException e) {
            e.printStackTrace();
            }
            }
            return bytesArray;
	    }
//	byte[] b = new byte[1024*1024*300];
//	new Random().nextBytes(b);
//	return b;
}

    private static void Bytes2File(byte[] bFile, String fileDest) {

        FileOutputStream fileOuputStream = null;

        try {
            fileOuputStream = new FileOutputStream(fileDest);
            fileOuputStream.write(bFile);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fileOuputStream != null) {
                try {
                    fileOuputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

//SET KEY FILE
public void setFile(String key,String path){
	redis.set(key.getBytes(), File2Bytes(path));
}

public static void getFile(String key, String FileDest){
	Jedis redis = new Jedis("localhost");
	Bytes2File(redis.get(key.getBytes()), FileDest);
}

public void testFile(String key,String path, String target)throws Exception{
	setFile(key, path);
	System.out.println("File stored.");
	getFile("rrrr", target);
	System.out.println("File get successfully.");
//BufferedReader br = new BufferedReader(new FileReader(file)); 
//String record = null; 
//while ((record = br.readLine()) != null) { 
//System.out.println("record:"+record);
//}

}

public static void main(String[] args) throws Exception{
	FileInRedis os = new FileInRedis();
	os.testFile("rrrr", "testredis.txt", "new_test_file.txt");
}
}
