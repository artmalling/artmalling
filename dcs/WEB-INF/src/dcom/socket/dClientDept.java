package dcom.socket;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.ConnectException;
import java.net.Socket;
import java.net.UnknownHostException;

import kr.fujitsu.ffw.base.BaseProperty;

import common.util.Util;

/**
 * <p>dClient</p>
 * 
 * 1. Parameter array should have length of 63
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
     3. POS_INFO        C   60  
     4. TRADE_GB_CD     C    6   
     5. SALE_DT         C    8   
     6. SALE_TM         C    6   
     7. STR_CD          C    2   
     8. POS_NO          C    4   
     9. TRAN_NO         C    5   
    10. RECP_NO         C   20  
                            
    11. REG_ID          C   10  
    12. IN_FLAG         C    1   
    13. CARD_NO         C   64  
    14. SS_NO           C   32  
    15. CUST_NM         C   40  
    16. BRCH_ID         C   10  
    17. PASSWD          C   40  
    18. CUST_GRADE      C    2   
    19. E_COUPON_NO1    C   20  
    20. E_COUPON_NO2    C   20  
                            
    21. E_COUPON_NO3    C   20  
    22. TYPE1_CD        C    2   
    23. TYPE1_AMT       N    9   
    24. TYPE2_CD        C    2   
    25. TYPE2_AMT       N    9    
    26. TYPE3_CD        C    2   
    27. TYPE3_AMT       N    9   
    28. TYPE4_CD        C    2   
    29. TYPE4_AMT       N    9   
    30. TYPE5_CD        C    2   
                            
    31. TYPE5_AMT       N    9   
    32. TYPE6_CD        C    2   
    33. TYPE6_AMT       N    9   
    34. TYPE7_CD        C    2   
    35. TYPE7_AMT       N    9   
    36. TYPE8_CD        C    2   
    37. TYPE8_AMT       N    9   
    38. TYPE_CNT        N    2   
    39. TRADE_AMT       N   10  
    40. TOT_POINT       N    9   
                            
    41. ADD_POINT       N    9   
    42. BASE_APOINT     N    9   
    43. CAM_ID          C   20  
    44. CAM_APOINT      N    9   
    45. EVENT_ID        C   20  
    46. EVENT_APOINT    N    9   
    47. ETC_APOINT      N    9   
    48. ADD_USE_FLAG    C    2   
    49. CONV_CUST_YN    C    1   
    50. PASSWD_EXIST_YN C    1   
                            
    51. CASH_RECPT_FLAG C    1   
    52. CAN_FLAG        C    1   
    53. O_SALE_DT       C    8   
    54. O_STR_CD        C    2   
    55. O_POS_NO        C    4   
    56. O_TRAN_NO       C    5   
    57. O_AMT           N   10  
    58. O_RECP_NO       C   20  
    59. REPLY_CD        C    4   
    60. SYSTEM_CRE_DT   C    8   
                            
    61. SYSTEM_CRE_TM   C    6   
    62. REPLY_MESG1     C   40  
    63. REPLY_MESG2     C   40  
   -------------------------------
 *  
 * @created  on 1.0, 2010.04.06
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 * Referenced by DMbo602Action,
 *               DMbo604Action,
 *               DMbo609Action,
 *               DMbo613Action,
 *               DMbo615Action,
 *               DMbo606Dao
 */

public class dClientDept {
	final int TR_PARAM_LEN 		= 61;	// 전문전송 항목 갯수 -- REV201110
	final int REPLY_CD_POS    	= 42;	// 응답코드 인덱스
	final int REPLY_MESG1_POS 	= 56;	// 응답메세지1 인덱스
    /**
     * sendData
     * @param String[]
     * @return String[]
     * 
     * @throws Exception
     */
	public String[] sendData ( String[] inputArr ) throws Exception {
		//System.out.println("MSG_ARR_LEN:" + inputArr.length);
	    boolean isWindow = (System.getProperty("os.name").toUpperCase().startsWith("WINDOWS")) ? true : false;
	    System.out.println(isWindow);
	    Socket client = null;
	    
	    //String serverIp =  (isWindow) ? "127.0.0.1" : "152.149.63.41";
	    //String serverIp =  "127.0.0.1";
	    //String serverIp =  "192.168.122.106";
	    String serverIp =  "192.168.123.146";
	    //int serverPort  =  Integer.parseInt(BaseProperty.get("dServerDeptPort")) ;
	    int serverPort  =  9974 ;
	    System.out.println("serverIp:serverPort:[" + serverIp +":"+ serverPort +"]");
        BufferedReader br = null; 
        PrintWriter    pw = null;
        
        
        
        
		String[] outputArr = new String[TR_PARAM_LEN];	
		String outputStr   = null; 
		
		try {
			System.out.println("inputArr.length:[" + inputArr.length +":"+ TR_PARAM_LEN +"]");
		    if (null != inputArr && inputArr.length == TR_PARAM_LEN) 
		    {
    			client = new Socket( serverIp, serverPort );
//    			client.setSoTimeout(5000);
    			

    			InputStream input = client.getInputStream();
    			pw = new PrintWriter(client.getOutputStream());
    			System.out.println("i111111:[" );
    			String inputStr = PR_DMBO504_IN (inputArr);
    		
    			pw.write(inputStr);				
    			pw.flush();
    			ByteArrayOutputStream sendByteArrayOutputStream = new ByteArrayOutputStream();
    			byte[] headbyte = new byte[4];
    			int headLen = input.read(headbyte);
    			int totoalsize = Integer.parseInt(new String(headbyte).trim()) - 4;
    			int byteRead;
    			int offset = 0;
    			byte[] buffer = new byte[totoalsize];
    			int si = 0;
    			while ((byteRead = input.read(buffer)) != -1) {
    				sendByteArrayOutputStream.write(buffer, (si * totoalsize), byteRead);
    				offset += byteRead;
    				if (offset >= totoalsize) {
    					break;
    				}
    			}
    			
    			sendByteArrayOutputStream.close();
    			byte[] resBuff = sendByteArrayOutputStream.toByteArray();
    			byte[] responseMessage = new byte[headbyte.length + resBuff.length];
    			System.arraycopy(headbyte, 0, responseMessage, 0, headbyte.length);
    			System.arraycopy(resBuff, 0, responseMessage, headbyte.length, resBuff.length);
    			outputStr = new String(responseMessage);
    			client.close();
    			System.out.println("CLIENT1 2222[");
    			String msg = "Contacted to socket server but the result depend on the return code!!!";
                dClientLog.log(this.getClass().getName(), inputStr, outputStr, msg); //Contact sucess;
                
    			outputArr = PR_DMBO504_OUT(outputStr);
    			System.out.println("CLIENT1 1111111[");
                for (int i = 0 ; i < outputArr.length; i++) {
                    System.out.println("CLIENT1 INPUT[" + (i + 1) + "] : " + outputArr[i].length() + " : " +  "[" + outputArr[i] + "]");
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
		        outputArr[REPLY_MESG1_POS] = "Data does not match the protocol.";		        
		        
		    }
		} catch (ConnectException e) {   
            e.printStackTrace();
            dClientLog.elog(this.getClass().getName(), e.getMessage());
            outputArr[REPLY_CD_POS] = "9999";
            outputArr[REPLY_MESG1_POS] = "Can not connect to server.";            
            //throw e;
		} catch (UnknownHostException e) {
		    e.printStackTrace();
		    dClientLog.elog(this.getClass().getName(), e.getMessage());
		    outputArr[REPLY_CD_POS] = "9999";
		    outputArr[REPLY_MESG1_POS] = "IP address of the host could not be determined";		    
		    //throw e;
		} catch (IOException e) {
		    e.printStackTrace();
		    dClientLog.elog(this.getClass().getName(), e.getMessage());
            outputArr[REPLY_CD_POS] = "9999";
            outputArr[REPLY_MESG1_POS] = "I/O error occured when creating the socket";            
            //throw e;
		} catch (SecurityException e) {
		    e.printStackTrace();
		    dClientLog.elog(this.getClass().getName(), e.getMessage());
            outputArr[REPLY_CD_POS] = "9999";
            outputArr[REPLY_MESG1_POS] = "Security manager doesn't allow this operation";            
            //throw e;
        } catch( Exception e) {
        	e.printStackTrace();
        	dClientLog.elog(this.getClass().getName(), e.getMessage());
        	outputArr[REPLY_CD_POS] = "9999";        	
        	if (null == outputArr[REPLY_MESG1_POS] || "".equals(outputArr[REPLY_MESG1_POS].trim())) {
                outputArr[REPLY_MESG1_POS] = e.getMessage();
            } 
        	//throw e;
        } finally {
            if (null != pw) pw.close();
            if (null != br) br.close();
            if (null != client) client.close();
        }
        return outputArr;
    }
	
	/**
     * PR_DMBO504_IN
     * @param String[]
     * @return String
     * 
     * @throws Exception
     */
	public String PR_DMBO504_IN ( String[] inputArr ) throws Exception {
        
	    String inputStr = "";
        int[] msgLen = {
                             4, 10, 60,  6,  8,  6,  20, 10,  1, 20  // 0~9 ;
                          ,  4, 10,  2,  2,  9,  2,   2,  9,  2,  2  // 10~19 ;
                          ,  9,  2,  2,  9,  2,  2,   9,  2,  2,  9  // 20~29 ;
                          ,  2,  2,  9,  2,  2,  9,   2,  9,  9, 20  // 30~39 ;
                          , 17,  2,  4, 17, 40,  2,   8,  6,  9,  9, 9  // 40~50 ;
                          ,  9, 20,  9, 20,  9,  9,  40, 40,  9, 30  // 51~60 ;
                        };
        
        for (int i = 0 ; i < inputArr.length; i++) {
            if (null == inputArr[i] || inputArr[i].length() <= 0) {
                inputArr[i] = "";
            }
            switch(i) {
                //NUMBER
                case  0:
                case 14:
                case 17:
                case 20:
                case 23:
                case 26:
                case 29:
                case 32:
                case 35:
                case 36:
                case 37: 	
                case 38:
                case 48:
                case 49:
                case 50:
                case 51:
                case 53:
                case 55:
                case 56:
                    inputArr[i] = nLpad(inputArr[i], msgLen[i]);
                    break;
                case 13:
                case 16:
                case 19:
                case 22:
                case 25:
                case 28:
                case 31:
                case 34:
                	inputArr[i] = nLpad(inputArr[i], msgLen[i]);
                    break;  
                //STRING
                default:
                    inputArr[i] = Util.substring(inputArr[i], msgLen[i]);
                    System.out.println("input["+ i +"]:["+ inputArr[i] +"]"+ inputArr[i].getBytes().length);
                    break;
            }
        }
        
        for (int i = 0 ; i < inputArr.length; i++) {
            inputStr = inputStr + inputArr[i] ;
            System.out.println("input["+ i +"]:["+ inputArr[i] +"]"+ inputArr[i].getBytes().length);
        }
        System.out.println("input string:["+ inputStr +"]"+ inputStr.getBytes().length);
        return inputStr;
    }
	
	
	/**
     * PR_DMBO504_OUT
     * @param String[]
     * @return String
     * 
     * @throws Exception
     */
	public String[] PR_DMBO504_OUT ( String outputStr ) throws Exception {
	    
	    String[] outputArr = new String[TR_PARAM_LEN];
	    System.out.println("output:["+ outputStr.getBytes().length +"]");
	    System.out.println("output:["+ outputStr +"]");
	    outputArr[0]  = Util.substring(outputStr,  0,   4).trim(); //MSG_LEN         N   4
        outputArr[1]  = Util.substring(outputStr,  4,  14).trim(); //MSG_TEXT        C   10
        outputArr[2]  = Util.substring(outputStr, 14,  74).trim(); //POS_INFO        C   60
        outputArr[3]  = Util.substring(outputStr, 74,  80).trim(); //TRADE_CD        C   6
        outputArr[4]  = Util.substring(outputStr, 80,  88).trim(); //SALE_DT         C   8
        outputArr[5]  = Util.substring(outputStr, 88,  94).trim(); //SALE_TM         C   6
        outputArr[6]  = Util.substring(outputStr, 94, 114); //RECP_NO         C   20
        outputArr[7]  = Util.substring(outputStr,114, 124).trim(); //REG_ID          C   10
        outputArr[8]  = Util.substring(outputStr,124, 125).trim(); //IN_FLAG         C   1
        
        outputArr[9]  = Util.substring(outputStr,125, 145).trim(); //CARD_CD         C   20
        outputArr[10] = Util.substring(outputStr,145, 149).trim(); //PASSWD          C   4
        outputArr[11] = Util.substring(outputStr,149, 159).trim(); //BRCH_ID         C   10
        
        outputArr[12] = Util.substring(outputStr,159, 161).trim(); //TYPE1_CD        C   2
        outputArr[13] = Util.substring(outputStr,161, 163).trim(); //TYPE1_DTL       C   2
        outputArr[14] = Util.substring(outputStr,163, 172).trim(); //TYPE1_AMT       N   9
        outputArr[15] = Util.substring(outputStr,172, 174).trim(); //TYPE2_CD        C   2
        outputArr[16] = Util.substring(outputStr,174, 176).trim(); //TYPE2_DTL       C   2
        outputArr[17] = Util.substring(outputStr,176, 185).trim(); //TYPE2_AMT       N   9
        outputArr[18] = Util.substring(outputStr,185, 187).trim(); //TYPE3_CD        C   2
        outputArr[19] = Util.substring(outputStr,187, 189).trim(); //TYPE3_DTL       C   2
        outputArr[20] = Util.substring(outputStr,189, 198).trim(); //TYPE3_AMT       N   9
        outputArr[21] = Util.substring(outputStr,198, 200).trim(); //TYPE4_CD        C   2
        outputArr[22] = Util.substring(outputStr,200, 202).trim(); //TYPE4_DTL       C   2
        outputArr[23] = Util.substring(outputStr,202, 211).trim(); //TYPE4_AMT       N   9
        outputArr[24] = Util.substring(outputStr,211, 213).trim(); //TYPE5_CD        C   2
        outputArr[25] = Util.substring(outputStr,213, 215).trim(); //TYPE5_DTL       C   2
        outputArr[26] = Util.substring(outputStr,215, 224).trim(); //TYPE5_AMT       N   9
        outputArr[27] = Util.substring(outputStr,224, 226).trim(); //TYPE6_CD        C   2
        outputArr[28] = Util.substring(outputStr,226, 228).trim(); //TYPE6_DTL       C   2
        outputArr[29] = Util.substring(outputStr,228, 237).trim(); //TYPE6_AMT       N   9
        outputArr[30] = Util.substring(outputStr,237, 239).trim(); //TYPE7_CD        C   2
        outputArr[31] = Util.substring(outputStr,239, 241).trim(); //TYPE7_DTL       C   2
        outputArr[32] = Util.substring(outputStr,241, 250).trim(); //TYPE7_AMT       N   9
        outputArr[33] = Util.substring(outputStr,250, 252).trim(); //TYPE8_CD        C   2
        outputArr[34] = Util.substring(outputStr,252, 254).trim(); //TYPE8_DTL       C   2
        outputArr[35] = Util.substring(outputStr,254, 263).trim(); //TYPE8_AMT       N   9        
        outputArr[36] = Util.substring(outputStr,263, 265).trim(); //TYPE_CNT       N   2    
       
        outputArr[37] = Util.substring(outputStr,265, 274).trim(); //TRADE_AMT       N   9
        outputArr[38] = Util.substring(outputStr,274, 283).trim(); //O_AMT           N   9
        outputArr[39] = Util.substring(outputStr,283, 303).trim(); //O_RECP_NO       C   20        
        outputArr[40] = Util.substring(outputStr,303, 320).trim(); //O_RECPT_NO      C   17  
        
        outputArr[41] = Util.substring(outputStr,320, 322).trim(); //ADD_USE_FLAG    C   2
        outputArr[42] = Util.substring(outputStr,322, 326).trim(); //REPLY_CD        C   4
        outputArr[43] = Util.substring(outputStr,326, 343).trim(); //APPR_NO         C   17
        outputArr[44] = Util.substring(outputStr,343, 383).trim(); //CUST_NM         C   40
        outputArr[45] = Util.substring(outputStr,383, 385).trim(); //CUST_GRADE      C   2
        outputArr[46] = Util.substring(outputStr,385, 393).trim(); //SYSTEM_CRE_DT   C   8
        outputArr[47] = Util.substring(outputStr,393, 399).trim(); //SYSTEM_CRE_TM   C   6 
        outputArr[48] = Util.substring(outputStr,399, 408).trim(); //USABLE_POINT    N   9
        outputArr[49] = Util.substring(outputStr,408, 417).trim(); //TOT_POINT       N   9
        outputArr[50] = Util.substring(outputStr,417, 426).trim(); //ADD_POINT       N   9        
        
        outputArr[51] = Util.substring(outputStr,426, 435).trim(); //BASE_APOINT     N   9
        outputArr[52] = Util.substring(outputStr,435, 455).trim(); //CAM_ID          C   20
        outputArr[53] = Util.substring(outputStr,455, 464).trim(); //CAM_APOINT      N   9
        outputArr[54] = Util.substring(outputStr,464, 484).trim(); //EVENT_ID        C   20
        outputArr[55] = Util.substring(outputStr,484, 493).trim(); //EVENT_APOINT    N   9
        outputArr[56] = Util.substring(outputStr,493, 502).trim(); //ETC_APOINT      N   9        

        outputArr[57] = Util.substring(outputStr,502, 542).trim(); //REPLY_MESG1     C   40
        outputArr[58] = Util.substring(outputStr,542, 582).trim(); //REPLY_MESG2     C   40
        outputArr[59] = Util.substring(outputStr,582, 591).trim(); //CUST_ID         C    9
        outputArr[60] = Util.substring(outputStr,591, 621).trim(); //FILLER          C   30
        
        for (int i=0; i<outputArr.length;i++) {
        	System.out.println("outputArr["+i+"]:["+ outputArr[i] +"]");
        }
        
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
