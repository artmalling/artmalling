package dcom.socket;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
 
public class dClientLog { 
    
    private static boolean isWindows = (System.getProperty("os.name").toUpperCase().startsWith("WINDOWS")) ? true : false ;
    private static String logFilePath = (isWindows) ? "C:\\java\\data_in\\socket\\dcs\\logs\\dclient\\" :  "/socket/dcs/logs/";

    
    static BufferedWriter bw = null;    
    
    public static void log(String className, String inputStr, String outputStr, String flag) { 
        
        try {
            int idx = className.lastIndexOf(".");
            if (-1 != idx ) {
                className = className.substring(idx + 1, className.length());
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String fileName = className + "_" + (sdf.format(Calendar.getInstance().getTime()).toString() + ".log") ;
            
            sdf = new SimpleDateFormat("yyyy/MM/dd hh:MM:ss");
            String firstLine  = sdf.format(Calendar.getInstance().getTime()) + "  I ["   + inputStr  + "] " + inputStr.length();
            String secondLine = sdf.format(Calendar.getInstance().getTime()) + "  O ["   + outputStr + "] " + outputStr.length();
            String thirdLine  = sdf.format(Calendar.getInstance().getTime()) + "  " + flag ;
            
            bw = new BufferedWriter(new FileWriter(logFilePath + fileName, true));
            
            bw.newLine();
            bw.write(firstLine);
            
            bw.newLine();
            bw.write(secondLine);
            
            bw.newLine();
            bw.write(thirdLine);

            bw.close();
            
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != bw) bw.close();
            } catch(IOException ioe) {
                ioe.printStackTrace();
            }
        }
    }
    
    public static void elog(String className, String errorStr) { 
        
        try {
            int idx = className.lastIndexOf(".");
            if (-1 != idx ) {
                className = className.substring(idx + 1, className.length());
            }
            
            new File(logFilePath).mkdir();
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String fileName = className + "Error_" + (sdf.format(Calendar.getInstance().getTime()).toString() + ".log") ;
            
            sdf = new SimpleDateFormat("yyyy/MM/dd hh:MM:ss");
            String eLine  = sdf.format(Calendar.getInstance().getTime()) + errorStr;
            
            bw = new BufferedWriter(new FileWriter(logFilePath + fileName, true));
            
            bw.newLine();
            bw.write(eLine);

            bw.close();
            
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != bw) bw.close();
            } catch(IOException ioe) {
                ioe.printStackTrace();
            }
        }
    }
   
}
