package dcom.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ConnectException;
import java.net.Socket;
import java.net.UnknownHostException;

import kr.fujitsu.ffw.base.BaseProperty;

/**
 * <p>dClientPark</p>
 * 
 * 1. Parameter array should have length of 22
 * 2. Each address can be null or blank except mandatory ones.
 * 3. if data overflow it`s limit length, it will be shortened within limit.
 *    so, if you`re care about incorrect operation, use sRPad or jLpad in utility class before passing parameter into this client.
 * 4. if you have return of value "0000" at address 58 then the result is success. if not it`s failure. 
 * 
 * Please refer to this protocol !!!
 *  
 * transfer text protocol
 * -------------------------------
 *  field          type     length
 * -------------------------------
     1. MSG_LEN         N    4   
     2. MSG_TEXT        C   10  
     3. TRADE_GB_CD     C    6   
     4. SALE_DT         C    8   
     5. SALE_TM         C    6   
     6. RECP_NO         C   20     
     7. REG_ID          C   10  
     8. CARD_NO         C   64  
     9. BRCH_ID         C   10  
    10. PASSWD          C   40  
    11. TYPE1_AMT       N    9   
    12. TRADE_AMT       N   10  
    13. TOT_POINT       N    9   
    14. ADD_POINT       N    9   
    15. CAN_FLAG        C    1   
    16. O_AMT           N   10  
    17. O_RECP_NO       C   20  
    18. REPLY_CD        C    4   
    19. SYSTEM_CRE_DT   C    8   
    20. SYSTEM_CRE_TM   C    6   
    21. FREE_PARK_YN    C    1  
    22. PARKING_TIME    N    2  
   -------------------------------
 *  
 * @created  on 1.0, 2010.04.07
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class dClientPark {
	
    
    /**
     * sendData
     * @param String[]
     * @return String[]
     * 
     * @throws Exception
     */
	public String[] sendData ( String[] inputArr ) throws Exception {
		
	    boolean isWindow = (System.getProperty("os.name").toUpperCase().startsWith("WINDOWS")) ? true : false;
	    
	    Socket client = null;
	    
	    String serverIp = (isWindow) ? BaseProperty.get("remoteSocketServerIp") : BaseProperty.get("socketServerIp");
        int serverPort  = Integer.parseInt(BaseProperty.get("dServerParkPort")) ;
        
        BufferedReader br = null;
        PrintWriter    pw = null;
        
        int REPLY_CD_POS    = 17;
        
		String[] outputArr = new String[22];	
		String outputStr   = null; 
		
		try 
		{
		    if (null != inputArr && inputArr.length == 22) 
		    {
    			client = new Socket( serverIp, serverPort );
    			
    			br = new BufferedReader(new InputStreamReader(client.getInputStream()));
    			pw = new PrintWriter(client.getOutputStream());
    			
    			String inputStr = PR_DMBO504_IN (inputArr);
    			
    			//server Data 송신;
    			pw.write(inputStr);				
    			pw.flush();
    			
    			String buff;
    			
    			boolean bContinue =true;
    			
    			while((buff = br.readLine()) != null) {
    				bContinue = false;
    				//server Data 수신;
    				outputStr = buff;
    			}
                
    			client.close();
    			
    			String msg = "Contacted to socket server but the result depend on the return code!!!";
                dClientLog.log(this.getClass().getName(), inputStr, outputStr, msg); //Contact sucess;
                
    			outputArr = PR_DMBO504_OUT(outputStr);
    			
    			//System log;
    			if (isWindow) {
    			    System.out.println("CLIENT inputStr.length :" + inputStr.length());
                    for (int i = 0 ; i < outputArr.length; i++) {
                        System.out.println("CLIENT INPUT[" + (i + 1) + "] : " + outputArr[i].length() + " : " +  "[" + outputArr[i] + "]");
                    }
    			}
		    }
		    else
		    {
		        String inputStr = "";
		        for (int i = 0 ; i < inputArr.length; i++) {
		            outputArr[i] = inputArr[i];
		            inputStr += inputArr[i];
		        }
		        
		        String msg = "Data does not match the protocol, program did not even try to connect socket server!!!";
                dClientLog.log(this.getClass().getName(), inputStr, "", msg); 
                
		        outputArr[REPLY_CD_POS] = "9999";
		    }
		} catch (ConnectException e) {   
            e.printStackTrace();
            dClientLog.elog(this.getClass().getName(), e.getMessage());
            outputArr[REPLY_CD_POS] = "9999";
            System.out.println("Can not connect to server.");
            //throw e;
		} catch (UnknownHostException e) {
		    e.printStackTrace();
		    dClientLog.elog(this.getClass().getName(), e.getMessage());
		    outputArr[REPLY_CD_POS] = "9999";
		    System.out.println("IP address of the host could not be determined");
		    //throw e;
		} catch (IOException e) {
		    e.printStackTrace();
		    dClientLog.elog(this.getClass().getName(), e.getMessage());
            outputArr[REPLY_CD_POS] = "9999";
            System.out.println("I/O error occured when creating the socket");
            //throw e;
		} catch (SecurityException e) {
		    e.printStackTrace();
		    dClientLog.elog(this.getClass().getName(), e.getMessage());
            outputArr[REPLY_CD_POS] = "9999";
            System.out.println("Security manager doesn't allow this operation");
            //throw e;
        } catch( Exception e) {
        	e.printStackTrace();
        	dClientLog.elog(this.getClass().getName(), e.getMessage());
        	outputArr[REPLY_CD_POS] = "9999";
        	System.out.println(e.getMessage());
        	//throw e;
        } finally {
            if (null != pw) pw.close();
            if (null != br) br.close();
            if (null != client) client.close();
            
            return outputArr;
        }
    }
	
	/**
     * PR_DMBO504_IN
     * @param String[]
     * @return String
     * 
     * @throws Exception
     */
	public String PR_DMBO504_IN ( String[] inputStr ) throws Exception {
        
	    String outputStr = "";
        int[] msgLen = {
                             4, 10,  6,  8,  6, 20, 10, 64, 10, 40  //  0~ 9 ;
                          ,  9, 10,  9,  9, 10, 20, 17,  4, 17,  8  // 10~19 ;
                          ,  6,  1,  2,  2                          // 20~23 ;
                        };
        
        for (int i = 0 ; i < inputStr.length; i++) {
            if (null == inputStr[i] || inputStr[i].length() <= 0) {
                inputStr[i] = "";
            }
            switch(i) {
                //NUMBER
                case  0:
                case 10:
                case 11:
                case 12:
                case 13:
                case 14:
                case 15:
                case 22:
                case 23:
                    inputStr[i] = nLpad(inputStr[i], msgLen[i]);
                    break;
                //STRING
                default:
                    inputStr[i] = sRPad(inputStr[i], msgLen[i], " ");
                    break;
            }
        }
        
        for (int i = 0 ; i < inputStr.length; i++) {
            outputStr = outputStr + inputStr[i] ;
        }
        
        return outputStr;
    }
	
	
	/**
     * PR_DMBO504_OUT
     * @param String[]
     * @return String
     * 
     * @throws Exception
     */
	public String[] PR_DMBO504_OUT ( String outputStr ) throws Exception {
	    
	    String[] outputArr = new String[24];
	    
	    outputArr[0]  = outputStr.substring(  0,   4); //MSG_LEN         N    4
        outputArr[1]  = outputStr.substring(  4,  14); //MSG_TEXT        C   10
        outputArr[2]  = outputStr.substring( 14,  20); //TRADE_CD        C    6
        outputArr[3]  = outputStr.substring( 20,  28); //SALE_DT         C    8
        outputArr[4]  = outputStr.substring( 28,  34); //SALE_TM         C    6
        outputArr[5]  = outputStr.substring( 34,  54); //RECPT_NO        C   20
        outputArr[6]  = outputStr.substring( 54,  64); //REG_ID          C   10
        outputArr[7]  = outputStr.substring( 64, 128); //CARD_CD         C   64
        outputArr[8]  = outputStr.substring(128, 138); //BRCH_ID         C   10
        outputArr[9]  = outputStr.substring(138, 178); //PASSWD          C   40
        
        outputArr[10] = outputStr.substring(178, 187); //POINT_AMT       N    9
        outputArr[11] = outputStr.substring(187, 197); //TRADE_AMT       N   10
        outputArr[12] = outputStr.substring(197, 206); //TOT_POINT       N    9
        outputArr[13] = outputStr.substring(206, 215); //ADD_POINT       N    9
       
        outputArr[14] = outputStr.substring(215, 225); //O_AMT           N   10
        outputArr[15] = outputStr.substring(225, 245); //O_RECP_NO       C   20
        outputArr[16] = outputStr.substring(245, 262); //O_APPR_NO       C   17
        outputArr[17] = outputStr.substring(262, 266); //REPLY_CD        C    4
        outputArr[18] = outputStr.substring(266, 283); //APPR_NO         C   17
        outputArr[19] = outputStr.substring(283, 291); //SYSTEM_CRE_DT   C    8
        outputArr[20] = outputStr.substring(291, 297); //SYSTEM_CRE_TM   C    6
        outputArr[21] = outputStr.substring(297, 298); //FREE_PARK_YN    C    1
        outputArr[22] = outputStr.substring(298, 300); //FREE_TIME       N    2
        outputArr[23] = outputStr.substring(300, 302); //PARKING_TIME    N    2
        
        return outputArr;
	}
	
	/**
     * sRPad
     * @param String, int, String
     * @return String
     * 
     * @throws Exception
     */ 
    public static String sRPad ( String str, int size, String fStr ) throws Exception {
        if (null == str) str = "";
        int len = str.length();
        int tmp = size - len;
        
        for (int i = 0; i < tmp; i++) {
            str = str + fStr;
        }
        return str.substring(0, size);
    }
    
    /**
     * nLpad
     * @param String, int
     * @return String
     * 
     * @throws Exception
     */
    public static String nLpad ( String num, int size ) throws Exception {
        if (null == num) num = "";      
        int len = size - num.length();
        for(int i = 0; i < len; i++) {
            num = "0" + num;
        }
        return num.substring(num.length() - size, num.length());
    }
	
}
