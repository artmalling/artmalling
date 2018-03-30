import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;


public class RunCommand {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		//runCommand("C:/Java/webapps/batch/Batch/edi_recv.cmd");
		runCommand("C:/Java/webapps/batch/Batch/edi_send.cmd");
	}
	
	
	/**
	 * 커맨드 명령 실행
	 * @param fileName - 경로를 포함한 파일명
	 * @return
	 */
	public static String runCommand(String fileName) {
		String lineStr = null;
		String rtnVal = "false";
		
		Process p = null;
		BufferedReader br = null;
		
		try {
			p = Runtime.getRuntime().exec(fileName);
			//p = Runtime.getRuntime().exec("cmd /C " + fileName);
			
			br = new BufferedReader(new InputStreamReader(p.getInputStream()));
			
			while ((lineStr = br.readLine()) != null){
				System.out.println("lineStr : " + lineStr);
				if(lineStr.indexOf("- SUCCESS")>0) {
					rtnVal = "true";
					break;
				}
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(br != null) br.close(); } catch (IOException e) {}
		}
		
		System.out.println("rtnVal : " + rtnVal);
		
		return rtnVal;
	}

}
