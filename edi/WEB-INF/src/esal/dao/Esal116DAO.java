package esal.dao;

import java.util.List;
import java.util.Map;

import ecom.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


public class Esal116DAO extends AbstractDAO{
	public String getMaster(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		String strQuery = null;
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service) form.getService(); 
		
			String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
			String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
			String strEmpName 	= String2.nvl(form.getParam("strEmpName"));
			String strEmpFlag 	= String2.nvl(form.getParam("strEmpFlag"));
			String strHpNo 		= String2.nvl(form.getParam("strHpNo"));
			String strIsuYn 	= String2.nvl(form.getParam("strIsuYn"));
			String strDelYn 	= String2.nvl(form.getParam("strDelYn"));
			String strSearchGb 	= String2.nvl(form.getParam("strSearchGb"));
			String strEntrDt 	= String2.nvl(form.getParam("strEntrDt"));
			String strRetrDt 	= String2.nvl(form.getParam("strRetrDt"));

			connect("pot");
			
			strQuery = svc.getQuery("SEL_EMPLIST") + "\n"; 
			
			
			sql.setString(++i, strStrCd);		//점코드
			sql.setString(++i, strPumbunCd);	//브랜드코드
			sql.setString(++i, strEmpName);		//사원명
			sql.setString(++i, strEmpFlag);		//사원구분
			sql.setString(++i, strHpNo);		//연락처
			sql.setString(++i, strIsuYn);		//교육이수여부
			sql.setString(++i, strDelYn);		//삭제여부
			
			if (strSearchGb.equals("1")){				// 근무 기간으로 검색
				strQuery = strQuery + svc.getQuery("SEL_EMPLIST_OPT1") + "\n";
				sql.setString(++i, strEntrDt);
				sql.setString(++i, strRetrDt);
			} else if (strSearchGb.equals("2")) {		// 입사일자로 검색
				strQuery = strQuery + svc.getQuery("SEL_EMPLIST_OPT2") + "\n";
				sql.setString(++i, strEntrDt);
			} else if (strSearchGb.equals("3")) {		// 퇴사일자로 검색
				strQuery = strQuery + svc.getQuery("SEL_EMPLIST_OPT3") + "\n";
				sql.setString(++i, strRetrDt);
			}
			
			
			sql.put(strQuery);
			
			list = select2List(sql);
			
			Util util = new Util(); 
			String	cols= "STR_CD,PUMBUN_CD,PUMBUN_NAME,EMP_SEQ,EMP_FLAG,EMP_NAME,HP_NO,ENTR_DT,RETR_DT,ISU_YN,DEL_YN,ISU_DATE";
			
			rtJson = util.listToJsonOBJ(list, cols);
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
			
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
	
public String delete(ActionForm form, String userId) throws Exception {
    	
    	int ret 		= 0;
    	SqlWrapper sql 	= null;
    	Service svc 	= null;
    	Util util 		= new Util();
    	String rtString 	= null;
    	ProcedureWrapper psql = null;
    	String strQuery = null;
    	
    	try {
    		
    		connect("pot");
    		begin();
    		
    		
            int i=1;        
            ProcedureResultSet prs = null;
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		//psql = new ProcedureWrapper();
    		
    		
    	
    		   String strStrCd    =     String2.nvl(form.getParam("strStrCd"));
			   String strPumbunCd    =     String2.nvl(form.getParam("strPumbunCd"));
			   String strEmpSeq    =     String2.nvl(form.getParam("strEmpSeq"));
    		
			 strQuery = svc.getQuery("DEL_EMPLIST") + "\n";
	    		
	    	 sql.setString(i++, userId);
	    	 sql.setString(i++, strStrCd);
	    	 sql.setString(i++, strPumbunCd);
	    	 sql.setString(i++, strEmpSeq);
	    		
	    	 System.out.println("strQuery : " + strQuery); 
	    	 
             sql.put(strQuery);  
	
             ret = update(sql);

	          System.out.println("ret : " + ret); 
	            
	            if ( String.valueOf(ret).equals("0")) {
	            	rtString = "[{'CD':'F','MSG':'저장에 실패하였습니다.'}]";
	            	rollback();
	            }
	            else {
		            System.out.println("################### rtJson : " + rtString);
		            String Msg = "처리가 완료되었습니다.";
		            rtString = "[{'CD':'T','MSG':'"+Msg+"'}]";
		            commit();
	            }
	            
		}catch(Exception e){
			System.out.println("######################## DAO e : " + e);
			rollback();
			throw e;
			
		} finally {
			end();
		}
    	return rtString;
    }
	
public String searchEmp(ActionForm form) throws Exception { 
	int i = 0;
	SqlWrapper sql = null;
	Service svc = null;
	List list = null;
	String rtJson = null;
	String strQuery = null;
	
	try{ 
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
	
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
		String strEmpSeq 	= String2.nvl(form.getParam("strEmpSeq"));

		connect("pot");
		
		strQuery = svc.getQuery("SEL_EMP") + "\n"; 
		
		
		sql.setString(++i, strStrCd);		//점코드
		sql.setString(++i, strPumbunCd);	//브랜드코드
		sql.setString(++i, strEmpSeq);		//사원순번
		
		sql.put(strQuery);
		
		list = select2List(sql);
		
		Util util = new Util(); 
		String	cols= "STR_CD,STR_NM,PUMBUN_CD,PUMBUN_NAME,EMP_SEQ,EMP_FLAG,EMP_NAME,HP_NO,ENTR_DT,RETR_DT,ISU_YN,DEL_YN,ISU_DATE";
		
		rtJson = util.listToJsonOBJ(list, cols);
		System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
		
	}catch(Exception e){
		throw e;
	}
	
	return rtJson;
	}

public String save(ActionForm form, String userId) throws Exception {
	
	int ret 				= 0;
	SqlWrapper sql 			= null;
	Service svc 			= null;
	Util util 				= new Util();
	String rtString 		= null;
	ProcedureWrapper psql 	= null;
	String strQuery 		= null;
	
	// 변수 초기화
	String strStrCd    	= String2.nvl(form.getParam("strStrCd"));
	String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));
	String strEmpSeq	= String2.nvl(form.getParam("strEmpSeq"));
	String strEmpName   = String2.nvl(form.getParam("strEmpName"));
	String strHpNo		= String2.nvl(form.getParam("strHpNo"));
	String strEntrDt	= String2.nvl(form.getParam("strEntrDt"));
	String strRetrDt    = String2.nvl(form.getParam("strRetrDt"));
	String strEmpFlag	= String2.nvl(form.getParam("strEmpFlag"));
	String strDelYn		= String2.nvl(form.getParam("strDelYn"));
	String strProcFlag  = String2.nvl(form.getParam("strProcFlag"));
		
	try {
		
		connect("pot");
		begin();
		
		
        int i=1;        
        ProcedureResultSet prs = null;
		svc  = (Service)form.getService();
		sql  = new SqlWrapper();
		//psql = new ProcedureWrapper();
		
		if (strProcFlag.equals("U")) { // 내용 수정
		
			strQuery = svc.getQuery("UPD_EMPLIST") + "\n";

			sql.setString(i++, strEmpName);
			sql.setString(i++, strEmpFlag);
			sql.setString(i++, strHpNo);
			sql.setString(i++, strEntrDt);
			sql.setString(i++, strRetrDt);
			sql.setString(i++, userId);
			sql.setString(i++, strDelYn);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strEmpSeq);
    		
			System.out.println("strQuery : " + strQuery); 
    	 
			sql.put(strQuery);
			
			
		} else if (strProcFlag.equals("I")) {
			
			sql.put(svc.getQuery("SEL_EMPSEQ"));		// SEQ 채번
			
			sql.setString(1, strStrCd);
			sql.setString(2, strPumbunCd);

			Map mapSeqno = (Map)selectMap(sql);
			strEmpSeq = mapSeqno.get("SEQ").toString();
			sql.close();
			
			strQuery = svc.getQuery("INS_EMPLIST") + "\n";
			
			sql.put(strQuery); 
			
            sql.setString(i++, strStrCd);
        	sql.setString(i++, strPumbunCd);
        	sql.setString(i++, strEmpSeq);
        	sql.setString(i++, strEmpFlag);
        	sql.setString(i++, strEmpName);
			sql.setString(i++, strHpNo);
			sql.setString(i++, strEntrDt);
			sql.setString(i++, strRetrDt);
			sql.setString(i++, userId);
			sql.setString(i++, userId);

	    	System.out.println("strQuery : " + strQuery); 
	    	
	        
		}
		
         ret = update(sql);
         sql.close();
          System.out.println("ret : " + ret); 
            
            if ( String.valueOf(ret).equals("0")) {
            	rtString = "[{'CD':'F','MSG':'저장에 실패하였습니다.'}]";
            	rollback();
            }
            else {
	            System.out.println("################### rtJson : " + rtString);
	            String Msg = "처리가 완료되었습니다.";
	            rtString = "[{'CD':'T','MSG':'"+Msg+"'}]";
	            commit();
            }
            
            
	}catch(Exception e){
		System.out.println("######################## DAO e : " + e);
		rollback();
		throw e;
		
	} finally {
		end();
	}
	return rtString;
}


}
