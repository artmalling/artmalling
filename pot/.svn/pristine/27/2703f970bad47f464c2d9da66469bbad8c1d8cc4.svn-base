package ifs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class LogUtil  {

    static private LogUtil instance = null;

    static synchronized public LogUtil getInstance()
    {
        if (instance == null) {
            instance = new LogUtil();
        }

        return instance;
    }
    
//    LogUtil(){}
    
    
    public String getLeftStrAdd(String baseData, int formLen, String addStr) throws Exception {

        if (baseData == null) {
            baseData = "";
        }

        String reData = baseData;
        int dataLen = baseData.length();

        for (int i = dataLen; i < formLen; i++) {
            reData = addStr + reData;
        }

        return reData;

    }

    public String getRightStrAdd(String baseData, int formLen, String addStr) throws Exception {

        if (baseData == null) {
            baseData = "";
        }

        String reData = baseData;
        int dataLen = baseData.length();

        for (int i = dataLen; i < formLen; i++) {
            reData = reData + addStr;
        }

        return reData;

    }

	public String getCurentDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal = Calendar.getInstance();

		return sdf.format(cal.getTime());
	}

    public boolean setLog(String processorId,
                          String msgGubun,
                          String log,
                          String updateId) {

        boolean retFlag = false;
        Connection conn = null;
       
        try {

        	conn = BatchUtil.getConnection_SSO();

            retFlag = setLog(conn,
                             processorId,
                             msgGubun,
                             log,
                             updateId);

        } catch (Exception e) {

            System.out.println("CommonUtil::setLog::Error = " + e.toString());
            retFlag = false;

        } finally {

            if (conn != null) {
                try {
                 	conn.close();
                } catch (Exception e) {}
            }

        }

        return retFlag;

    }

    public boolean setLog(Connection conn,
                          String processorId,
                          String msgGubun,
                          String log,
                          String updateId) {

        boolean retFlag  = false;
        boolean autoFlag = true;
        BatchUtil util = new BatchUtil();
        ResultSet         rs = null;
        PreparedStatement ps = null;

        String strQuery  = "";
        String insYmdhms = "";
        String logSeq    = "";
        String t_log	 = "";

        try {
            autoFlag = conn.getAutoCommit();

            if (autoFlag == false) {
                conn.setAutoCommit(true);
            }

            insYmdhms = getCurentDate();
            switch (Integer.parseInt(msgGubun))
            {
                case  1:
                	log = "[정보]" + log;
                	break;
                case  2:
                	log = "[경고]" + log;
                	break;                	
                case  3:
                	log = "[심각]" + log;
            }
           
            System.out.println("Log : " + log);
//            System.out.println("insYmdhms = " + insYmdhms);

            strQuery = "select nvl(max(to_number(LOG_SEQ)), 0) + 1 "
                     + "  from D_PROC_LOG "
                     + " where INS_YMDHMS = ? ";

            ps = conn.prepareStatement(strQuery);

            ps.setString(1, insYmdhms);

            rs = ps.executeQuery();

            while (rs.next()) {
            	logSeq = rs.getString(1);
                //System.out.println("logSeq = " + logSeq);
            }

            strQuery = "";
            rs.close();
            ps.close();

            strQuery = "insert into D_PROC_LOG ("
                     + "INS_YMDHMS, LOG_SEQ, PROCESSOR_ID, MSG_GUBUN, LOG, "
                     + "CREATE_DT, CREATE_ID, UPDATE_DT, UPDATE_ID)"
                     + "values ("
                     + "?, ?, ?, ?, ?, to_char(sysdate, 'yyyymmddhh24miss'), ?, to_char(sysdate, 'yyyymmddhh24miss'), ?) ";

            ps = conn.prepareStatement(strQuery);

            ps.setString(1, insYmdhms);
            ps.setString(2, logSeq);
            ps.setString(3, processorId);
            ps.setString(4, msgGubun);
            ps.setString(5, util.encodeEng(log));
            ps.setString(6, updateId);
            ps.setString(7, updateId);

            ps.executeUpdate();

            retFlag = true;
            
        } catch (Exception e) {

            System.out.println("CommonUtil::setLog::executeUpdate Error = " + e.toString());
            retFlag = false;

        } finally {

            if (rs != null) {
                try {
                	rs.close();
                } catch (Exception e) {}
            }

            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {}
            }

            if (autoFlag == false) {
                try {
                    conn.setAutoCommit(false);
                } catch (Exception e) {}
            }

        }

        return retFlag;

    }

}
