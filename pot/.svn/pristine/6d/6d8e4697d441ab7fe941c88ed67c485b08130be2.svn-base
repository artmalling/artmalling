package ifs;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

public class DataFromSSO {


	private static Connection conn_SSO = null;
	private static Connection conn_central = null;
	private static String DEFALT_PASSWD = "1";

	static LogUtil clog  = LogUtil.getInstance();
	
	
	public static void main(String arg[]) {
		Statement stmt = null;
		ResultSet rs = null;
		String passwd = null;
		if(arg.length > 0 )passwd = arg[0];  	//비밀번호 
		System.out.println("[입력 DATA ]");
		System.out.println(" 패스워드 : "+ passwd);
		

		try {
			Timer t = new Timer();
			
			t.start();
//			clog.setLog("D_201S", "1","사용자정보배치작업 시작","");
			System.out.println("========= 사용자정보배치 Started ===========");
			conn_SSO = BatchUtil.getConnection_SSO();
			conn_SSO.setAutoCommit(false);
			conn_central = BatchUtil.getConnection_central();
			conn_central.setAutoCommit(false);

			createTempTable(); // Create temporary table
		
			rs = selectData(); // Retrieve User data from SSO

			insertData2TempTable(rs);  // Insert data to temporary table

			updateTargetTable(passwd); // Insert data to temporary table
			
//						while (rs.next()){
//				System.out.println(rs.getString(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
//				System.out.println(rs.getString(4));
//				System.out.println(rs.getString(5));
//				System.out.println(rs.getString(6));
//				System.out.println(rs.getString(7));
//			}
			


			conn_central.commit();
			t.stop();
			System.out.println(" Total time : " + t.toString() );

		} catch (Exception e) {
			e.printStackTrace();
			try {

				conn_SSO.rollback();
			} catch (SQLException re) {
			}
		} finally {
			BatchUtil.close(conn_central, stmt, rs);
			BatchUtil.close(conn_SSO, stmt, rs);
		}
	}


	public static void createTempTable() throws Exception {
		String sql = "";
		Statement stmt = null;

		try {
			stmt = conn_central.createStatement();
			
			sql += "DROP TABLE TC_USRMST_TEMP      \n";
			stmt.executeQuery(sql);

			sql = "";
			sql += "CREATE TABLE COM.TC_USRMST_TEMP\n"; 
			sql += "(                              \n"; 
			sql += "  USER_ID    VARCHAR2(10),     \n"; 
			sql += "  KOR_NAME   VARCHAR2(20),     \n"; 
			sql += "  PHONE1_NO  VARCHAR2(20),     \n"; 
			sql += "  PHONE2_NO  VARCHAR2(20),     \n"; 
			sql += "  PHONE3_NO  VARCHAR2(20),     \n";
			sql += "  HP1_NO     VARCHAR2(20),     \n";
			sql += "  HP2_NO     VARCHAR2(20),     \n";
			sql += "  HP3_NO     VARCHAR2(20),     \n";
			sql += "  USE_YN     VARCHAR2(1) ,     \n"; 
			sql += "  EMAIL      VARCHAR2(40),     \n"; 
			sql += "  DEPT_NAME  VARCHAR2(50)      \n"; 
			sql += ")                              \n"; 
			stmt.executeQuery(sql);

			sql = "";
			sql += "ALTER TABLE TC_USRMST_TEMP      \n";
			sql += "ADD CONSTRAINT PK_TC_USRMST_TEMP\n";
			sql += "PRIMARY KEY ( USER_ID)          \n";
			stmt.executeQuery(sql);
			
			
		} catch (Exception e) {
			System.out.println(">>>ERROR : 템프테이블 생성중오류: "+ sql);
			throw e;
		} finally{
			stmt.close();
		}
	}



	public static ResultSet selectData() throws Exception { 
		CallableStatement cbstmt = null ;
		String query ;

			query = "{call dbo.DSP_SSO_USER_DBH_QR }";
			
			cbstmt = conn_SSO.prepareCall(query);
			
		return	cbstmt.executeQuery();
	}
	
	
	public static void insertData2TempTable(ResultSet rs) throws Exception {
		PreparedStatement pstmt = null;
		int dispatch=1000;
		int cnt = 0;
		String sql = null;

		try {

			while(rs.next()) {

				cnt++;
				if (pstmt == null) pstmt = conn_central.prepareStatement(makeUpdateQuery());
				sql= bindUpdateQuery(pstmt, BatchUtil.toMap(rs));
				if (cnt%dispatch == 0) {
					Timer t = new Timer();
					t.start();
					pstmt.executeBatch();
					t.stop();
					System.out.println("------------------------------------------");
					System.out.println("INSERT: " + t.toString());
					System.out.println("------------------------------------------");
				}
			}
			pstmt.executeBatch();
			System.out.println("[ISERTED DATA : " + cnt +" 건]");
			
		} catch (Exception e) {
			if (cnt<1){
				System.out.println("========= !halted due to no date! ==========");
			}else{
				System.out.println(">>>ERROR\n Insert Query : " + sql);
			}
			throw e;
		} finally{
			pstmt.close();
		}
	}

	public static void updateTargetTable(String passwd) throws Exception {
		String sql = "";
		String enPasswd = "";
		Statement stmt = null;
		if(passwd == null){
			enPasswd = encryptedPasswd(DEFALT_PASSWD);
		} else {
			enPasswd = encryptedPasswd(passwd);
		}

		try {

			stmt = conn_central.createStatement();
			sql += "MERGE INTO COM.TC_USRMST U        \n";
			sql += "      USING COM.TC_USRMST_TEMP UT \n";
			sql += "      ON (U.USER_ID = UT.USER_ID) \n";
			sql += " WHEN MATCHED THEN                \n";
			sql += "    UPDATE SET                    \n";
			sql += "	  U.USER_NAME	 = UT.KOR_NAME,   \n";
			sql += "		U.PWD_NO	 = '"+ enPasswd +"',\n";
			sql += "		U.HP1_NO	 = UT.HP1_NO,       \n";
			sql += "		U.HP2_NO	 = UT.HP2_NO,       \n";
			sql += "		U.HP3_NO	 = UT.HP3_NO,       \n";
			sql += "		U.PHONE1_NO	 = UT.PHONE1_NO,  \n";
			sql += "		U.PHONE2_NO	 = UT.PHONE2_NO,  \n";
			sql += "		U.PHONE3_NO	 = UT.PHONE3_NO,  \n";
			sql += "		U.E_MAIL	 = UT.EMAIL,        \n";
			sql += "		U.USE_YN	 = UPPER(UT.USE_YN),\n";
			sql += "		U.PART_NM	 = UT.DEPT_NAME     \n";
			sql += " WHEN NOT MATCHED THEN   \n";
			sql += "      INSERT (           \n";
			sql += "        U.USER_ID,       \n";
			sql += "        U.USER_NAME,     \n";
			sql += "        U.PWD_NO,        \n";
			sql += "        U.HP1_NO,        \n";
			sql += "        U.HP2_NO,        \n";
			sql += "        U.HP3_NO,        \n";
			sql += "        U.PHONE1_NO,     \n";
			sql += "        U.PHONE2_NO,     \n";
			sql += "        U.PHONE3_NO,     \n";
			sql += "        U.E_MAIL,        \n";
			sql += "        U.USE_YN,        \n";
			sql += "        U.PART_NM,       \n";
			sql += "        U.REG_ID,        \n";
			sql += "        U.REG_DATE )     \n";
			sql += "      VALUES (           \n";
			sql += "        UT.USER_ID,      \n";
			sql += "        UT.KOR_NAME,     \n";
			sql += "'" +    enPasswd + "',   \n";
			sql += "        UT.HP1_NO,       \n";
			sql += "        UT.HP2_NO,       \n";
			sql += "        UT.HP3_NO,       \n";
			sql += "        UT.PHONE1_NO,    \n";
			sql += "        UT.PHONE2_NO,    \n";
			sql += "        UT.PHONE3_NO,    \n";
			sql += "        UT.EMAIL,        \n";
			sql += "        UPPER(UT.USE_YN),\n";
			sql += "        UT.DEPT_NAME,    \n";
			sql += "        'SSO',           \n";
			sql += "        SYSDATE          \n";
			sql += "        )  \n";
			stmt.executeQuery(sql);
		} catch (Exception e) {
			System.out.println(">>>ERROR : Merge Query : "+ sql);
			throw e;
		} finally{
			stmt.close();
		}
	}


	private static String bindUpdateQuery(PreparedStatement pstmt, Map map) throws Exception {
		
		String USER_ID   = (String) map.get("USER_ID");
		String KOR_NAME  = (String) map.get("KOR_NAME");
		String PHONE1_NO = "";
		String PHONE2_NO = "";
		String PHONE3_NO = "";	
		if(((String) map.get("TEL1")).replace("-", "").length() > 0 ){
			PHONE1_NO = ((String) map.get("TEL1")).split("-")[0];
			PHONE2_NO = ((String) map.get("TEL1")).split("-")[1];
			PHONE3_NO = ((String) map.get("TEL1")).split("-")[2];
		}
		String HP1_NO    = "";
		String HP2_NO    = "";
		String HP3_NO    = "";
		if(((String) map.get("TEL2")).replace("-", "").length() > 0 ){
			HP1_NO    = ((String) map.get("TEL2")).split("-")[0];
			HP2_NO    = ((String) map.get("TEL2")).split("-")[1];
			HP3_NO    = ((String) map.get("TEL2")).split("-")[2]; 
		}
		String USE_YN    = (String) map.get("USE_YN");
		String EMAIL     = (String) map.get("EMAIL");
		String DEPT_NAME = (String) map.get("DEPT_NAME");
                
		String temp[] = BatchUtil.split(makeUpdateQuery(), "?",-1);
		String printedSql = temp[0];

		pstmt.setString (1 ,USER_ID  );
		printedSql += temp[1] + USER_ID  ;  		
		pstmt.setString (2 ,KOR_NAME );
		printedSql += temp[2] + KOR_NAME ;  		
		pstmt.setString (3 ,PHONE1_NO);
		printedSql += temp[3] + PHONE1_NO;
		pstmt.setString (4 ,PHONE2_NO);
		printedSql += temp[4] + PHONE2_NO;
		pstmt.setString (5 ,PHONE3_NO);
		printedSql += temp[5] + PHONE3_NO;
		pstmt.setString (6 ,HP1_NO   );
		printedSql += temp[6] + HP1_NO   ;  		
		pstmt.setString (7 ,HP2_NO   );
		printedSql += temp[7] + HP2_NO   ;
		pstmt.setString (8 ,HP3_NO   );
		printedSql += temp[8] + HP3_NO   ;
		pstmt.setString (9 ,USE_YN   );
		printedSql += temp[9] + USE_YN   ;  		
		pstmt.setString (10,EMAIL    );
		printedSql += temp[10] + EMAIL    ;  		
		pstmt.setString (11,DEPT_NAME);
		printedSql += temp[11] + DEPT_NAME;  

		printedSql += temp[temp.length-1];
		pstmt.addBatch();
		
		return printedSql;
	}

	private static String makeUpdateQuery() {
		String qry = "";
		  qry += " INSERT INTO COM.TC_USRMST_TEMP(  \n";
	        qry += "   USER_ID,	KOR_NAME, PHONE1_NO, PHONE2_NO, PHONE3_NO, \n";
	        qry += "   HP1_NO,  HP2_NO,   HP3_NO,    USE_YN,    EMAIL,     \n";
	        qry += "   DEPT_NAME )   \n";
	        qry += " VALUES(                \n";
	        qry += "     ?, ?, ?, ?, ?,     \n";
	        qry += "     ?, ?, ?, ?, ?,     \n";
	        qry += "     ? )  \n";     
		return qry;
	}
	

	/**
	 * 일방향 암호화 대상 : 비밀번호
	 * 
	 * @param text
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public static String encryptedPasswd(String text)
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		MessageDigest md;
		md = MessageDigest.getInstance("SHA-1");
		byte[] sha1hash = new byte[40];
		md.update(text.getBytes("iso-8859-1"), 0, text.length());
		sha1hash = md.digest();
		return convertToHex(sha1hash);
	}

	/**
	 * convertToHex
	 * 
	 * @param data
	 * @return
	 */
	private static String convertToHex(byte[] data) {
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < data.length; i++) {
			int halfbyte = (data[i] >>> 4) & 0x0F;
			int two_halfs = 0;
			do {
				if ((0 <= halfbyte) && (halfbyte <= 9))
					buf.append((char) ('0' + halfbyte));
				else
					buf.append((char) ('a' + (halfbyte - 10)));
				halfbyte = data[i] & 0x0F;
			} while (two_halfs++ < 1);
		}
		return buf.toString();
	}
	
	
	public static class Timer {
		private final int MILLIS_IN_SECOND = 1000;

		private final int MILLIS_IN_MINUTE = 60 * 1000;

		private final int MILLIS_IN_HOUR = 60 * 60 * 1000;

		private long startTime = -1;

		private long stopTime = -1;

		public Timer() {
		}

		public void start() {
			stopTime = -1;
			startTime = System.currentTimeMillis();
		}

		public void stop() {
			stopTime = System.currentTimeMillis();
		}

		public void reset() {
			startTime = -1;
			stopTime = -1;
		}

		public void split() {
			stopTime = System.currentTimeMillis();
		}

		public void unsplit() {
			stopTime = -1;
		}

		public void suspend() {
			stopTime = System.currentTimeMillis();
		}

		public void resume() {
			startTime += (System.currentTimeMillis() - stopTime);
			stopTime = -1;
		}

		public long getTime() {
			if (stopTime == -1) {
				if (startTime == -1) {
					return 0;
				}
				return (System.currentTimeMillis() - this.startTime);
			}
			return (this.stopTime - this.startTime);
		}

		public String toString() {
			return formatISO(getTime());
		}

		public String formatISO(long millis) {
			int hours, minutes, seconds, milliseconds;

			hours = (int) (millis / MILLIS_IN_HOUR);
			millis = millis - (hours * MILLIS_IN_HOUR);
			minutes = (int) (millis / MILLIS_IN_MINUTE);
			millis = millis - (minutes * MILLIS_IN_MINUTE);
			seconds = (int) (millis / MILLIS_IN_SECOND);
			millis = millis - (seconds * MILLIS_IN_SECOND);
			milliseconds = (int) millis;

			StringBuffer buf = new StringBuffer(32);
			buf.append(hours);
			buf.append(':');
			buf.append((char) (minutes / 10 + '0'));
			buf.append((char) (minutes % 10 + '0'));
			buf.append(':');
			buf.append((char) (seconds / 10 + '0'));
			buf.append((char) (seconds % 10 + '0'));
			buf.append('.');

			if (milliseconds < 10) {
				buf.append('0').append('0');
			} else if (milliseconds < 100) {
				buf.append('0');
			}

			buf.append(milliseconds);
			return buf.toString();
		}
	}
}
