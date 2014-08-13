package front.member.controller;

import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

public class code {

	static String strKey = null;
	
	public static String enCrypt(String content,String strKey) throws Exception{  
    	String str = content;  
        strKey = "ea40b367b0876f6bd4a802442f40eb";
        
        KeyGenerator keygen;          
        SecretKey desKey;  
        Cipher c;         
        byte[] cByte;  
        
          
        keygen = KeyGenerator.getInstance("AES");  
        keygen.init(128, new SecureRandom(strKey.getBytes()));  
          
        desKey = keygen.generateKey();        
        c = Cipher.getInstance("AES");  
          
        c.init(Cipher.ENCRYPT_MODE, desKey);  
          
        cByte = c.doFinal(str.getBytes("UTF-8"));      
        String encrytStr = parseByte2HexStr(cByte);     //二進位轉16進位
        return encrytStr;  
    }  
      
    
    public static String deCrypt (String src,String strKey) throws Exception{  
 
        strKey = "ea40b367b0876f6bd4a802442f40eb";
        KeyGenerator keygen;          
        SecretKey desKey;  
        Cipher c;         
        byte[] cByte;     
        byte[] encrytByte;   
        
        //16進位轉二進位
        encrytByte = parseHexStr2Byte(src);    
        
        
        keygen = KeyGenerator.getInstance("AES");  
        keygen.init(128, new SecureRandom(strKey.getBytes()));  
          
        desKey = keygen.generateKey();  
        c = Cipher.getInstance("AES");  
          
        c.init(Cipher.DECRYPT_MODE, desKey);  
          
          
        cByte = c.doFinal(encrytByte);   
        String decode = new String(cByte,"UTF-8");  
        
        return decode;  
    }  
      
      
    /**2進位轉16進位
     
     */  
    public static String parseByte2HexStr(byte buf[]) {  
        StringBuffer sb = new StringBuffer();  
        for (int i = 0; i < buf.length; i++) {  
            String hex = Integer.toHexString(buf[i] & 0xFF);  
            if (hex.length() == 1) {  
                hex = '0' + hex;  
                }  
            sb.append(hex.toUpperCase());  
            }  
        return sb.toString();  
        }  
      
      
    /**16進位轉為二進位 
    
     */       
    public static byte[] parseHexStr2Byte(String hexStr) {   
            if (hexStr.length() < 1)   
                    return null;   
            byte[] result = new byte[hexStr.length()/2];   
            for (int i = 0;i< hexStr.length()/2; i++) {   
                    int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);   
                    int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);   
                    result[i] = (byte) (high * 16 + low);   
            }   
            return result;   
    }


	

}
