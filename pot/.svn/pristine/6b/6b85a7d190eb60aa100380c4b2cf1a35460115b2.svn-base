package ifs;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class BatchUtil {

	private static String encode_mode = "KSC5601";

	static private String url_SSO = "jdbc:sqlserver://222.111.242.26:1433;databaseName=DSSSODB";
	static private String url_central = "jdbc:oracle:thin:@121.160.24.18:1521:dcora11";

	static private String uid_SSO = "sso_centraluser";
	static private String pwd_SSO = "2010!sso_central";

	static public Connection getConnection_SSO() throws Exception {
		//Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");


		
		return DriverManager.getConnection(url_SSO, uid_SSO, pwd_SSO);
	}

	static private String uid_central = "com";
	static private String pwd_central = "com";

	static public Connection getConnection_central() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		return DriverManager.getConnection(url_central, uid_central, pwd_central);
	}

	static public void close(Connection conn, PreparedStatement pstmt,
			ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		}

		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	static public void close(Connection conn, Statement stmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}

		if (conn != null) {
			try {
				conn.setAutoCommit(true);
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	static public Map toMap(ResultSet rs) throws Exception {
		Map map = new CaseInsensitiveHashMap(null);
		ResultSetMetaData rsmd = rs.getMetaData();
		int cols = rsmd.getColumnCount();
		for (int i = 1; i <= cols; i++)
			map.put(rsmd.getColumnName(i), rs.getString(i));

		return map;
	}

	private static int getBatchCnt(int[] ret) {
		int tmpCnt = 0;

		for (int i = 0; i < ret.length; i++) {
			if (ret[i] == PreparedStatement.SUCCESS_NO_INFO) {
				tmpCnt++;
			} else if (ret[i] == PreparedStatement.EXECUTE_FAILED) {
				tmpCnt = tmpCnt + 0;

			} else {
				tmpCnt = tmpCnt + ret[i];
			}
		}

		return tmpCnt;
	}

	public static String[] split(String str, String separatorChars, int max) {
		if (str == null)
			return null;
		int len = str.length();
		if (len == 0)
			return new String[0];
		List list = new ArrayList();
		int sizePlus1 = 1;
		int i = 0;
		int start = 0;
		boolean match = false;
		if (separatorChars == null)
			while (i < len)
				if (Character.isWhitespace(str.charAt(i))) {
					if (match) {
						if (sizePlus1++ == max)
							i = len;
						list.add(str.substring(start, i));
						match = false;
					}
					start = ++i;
				} else {
					match = true;
					i++;
				}
		else if (separatorChars.length() == 1) {
			char sep = separatorChars.charAt(0);
			while (i < len)
				if (str.charAt(i) == sep) {
					if (match) {
						if (sizePlus1++ == max)
							i = len;
						list.add(str.substring(start, i));
						match = false;
					}
					start = ++i;
				} else {
					match = true;
					i++;
				}
		} else {
			while (i < len)
				if (separatorChars.indexOf(str.charAt(i)) >= 0) {
					if (match) {
						if (sizePlus1++ == max)
							i = len;
						list.add(str.substring(start, i));
						match = false;
					}
					start = ++i;
				} else {
					match = true;
					i++;
				}
		}
		if (match)
			list.add(str.substring(start, i));
		return (String[]) list.toArray(new String[list.size()]);
	}

	private static class CaseInsensitiveHashMap extends HashMap {

		public boolean containsKey(Object key) {
			return super.containsKey(key.toString().toLowerCase());
		}

		public Object get(Object key) {
			return super.get(key.toString().toLowerCase());
		}

		public Object put(Object key, Object value) {
			return super.put(key.toString().toLowerCase(), value);
		}

		public void putAll(Map m) {
			Object key;
			Object value;
			for (Iterator iter = m.keySet().iterator(); iter.hasNext(); put(
					key, value)) {
				key = iter.next();
				value = m.get(key);
			}

		}

		public Object remove(Object key) {
			return super.remove(key.toString().toLowerCase());
		}

		private CaseInsensitiveHashMap() {
		}

		CaseInsensitiveHashMap(CaseInsensitiveHashMap caseinsensitivehashmap) {
			this();
		}
	}

	public static synchronized String encodeKor(String eng) {
		String kor = null;
		if (eng == null)
			return null;
		try {
			kor = new String(new String(eng.getBytes("8859_1"), encode_mode));
		} catch (UnsupportedEncodingException e) {
			kor = new String(eng);
		}
		return kor;
	}

	public static synchronized String encodeEng(String kor) {
		String eng = null;
		if (kor == null)
			return null;
		eng = new String(kor);
		try {
			eng = new String(new String(kor.getBytes(encode_mode), "8859_1"));
		} catch (UnsupportedEncodingException e) {
			eng = new String(kor);
		}
		return eng;
	}

}
