/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>시스템메뉴-권한관리</p>
 * 
 * @created  on 1.0, 2010/02/12
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom104DAO extends AbstractDAO {
	
	/**
	 * <p>
	 * 그룹 정보를 위한 List를 리턴한다.
	 * </p>
	 * 
	 */
	public List getPgroup(ActionForm form) throws Exception {

		List result = null;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			sql.put(svc.getQuery("SEL_PGROUP"));
			result = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return result;
	}
	/**
	 * <p>
	 * 트리뷰를 위한 List를 리턴한다.
	 * </p>
	 * 
	 */
	public List getTreeList(ActionForm form) throws Exception {
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;

		String strSubSystem	= null;
        try {
        	
        	strSubSystem = String2.nvl(form.getParam("strSubSystem"));	// 시스템구분
            sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_TREE_VIEW"));  
            sql.setString(1, strSubSystem);     

    		connect("pot");	
            list = select2List(sql);
             
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>사용자별 프로그램 사용권한 : 사용자리스트 </p>
	 * Tab1,3
	 */
	
	public List getUsrmstCond(ActionForm form) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try {

			String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직코드
			String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드 	 
			String strDeptCd  = String2.nvl(form.getParam("strDeptCd"));	//부문코드
			String strTeamCd  = String2.nvl(form.getParam("strTeamCd"));	//팀코드
			String strPcCd    = String2.nvl(form.getParam("strPcCd"));		//PC코드 
			String strGroupCd = String2.nvl(form.getParam("strGroupCd"));	//그룹코드 
			String strUserCd  = URLDecoder.decode(String2.nvl(form.getParam("strUserCd")), "UTF-8");//사용자id/명  
			String strGbn 	  = String2.nvl(form.getParam("strGbn"));		//탭구분 
			/*
			System.out.println( "--------------------------strOrgFlag  ===> " + strOrgFlag );
			System.out.println( "--------------------------strStrCd    ===> " + strStrCd   ); 
			System.out.println( "--------------------------strDeptCd   ===> " + strDeptCd  );
			System.out.println( "--------------------------strTeamCd   ===> " + strTeamCd  );
			System.out.println( "--------------------------strPcCd     ===> " + strPcCd    );
			System.out.println( "--------------------------strGroupCd  ===> " + strGroupCd );
			System.out.println( "--------------------------strUserCd   ===> " + strUserCd  );
			System.out.println( "--------------------------strGbn      ===> " + strGbn     );
			*/
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			
			if ("U".equals(strGbn))
				strQuery = svc.getQuery("SEL_USER_LIST_TAB1") + "\n";
			else
				strQuery = svc.getQuery("SEL_USER_LIST_TAB3") + "\n";

			if( !strOrgFlag.equals("%")){ 
				sql.setString(i++, strOrgFlag);
				strQuery += svc.getQuery("SEL_USER_WHERE_ORG_FLAG") + "\n";
			}
			
			if( !strStrCd.equals("%") && !strStrCd.equals("")){ 
				sql.setString(i++, strStrCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_STR_CD") + "\n";
			} 
			
			if( !strDeptCd.equals("%")){ 
				sql.setString(i++, strDeptCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_DEPT_CD") + "\n";
			}
			
			if( !strTeamCd.equals("%")){ 
				sql.setString(i++, strTeamCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_TEAM_CD") + "\n";
			}
			
			if( !strPcCd.equals("%")){ 
				sql.setString(i++, strPcCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_PC_CD") + "\n";
			}  
			
			if( !strGroupCd.equals("%")&&!strGroupCd.equals("")){
 
				sql.setString(i++, strGroupCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_GROUP_CD") + "\n";
			}
			
			if( !strUserCd.equals("%")&&!strUserCd.equals("")){ 
				sql.setString(i++, strUserCd);
				sql.setString(i++, strUserCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_USER_CD") + "\n";
			}
			
			if ("U".equals(strGbn))
				strQuery += svc.getQuery("SEL_USER_ORDER");
			else
				strQuery += svc.getQuery("SEL_USER_ORDER_TAB3");
			
			sql.put(strQuery);  
			list = select2List(sql);
			
        } catch (Exception e) {
            throw e;
        }
        return list; 
        
	}
	
    /**
	 * <p>
	 * 프로그램 권한리스트를  조회한다.
	 * Tab1,2
	 * </p> 
	 */
	public List getUsrpgm(ActionForm form) throws Exception {

		List result 	= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;

		String strGbn	= null;
		String strVal	= null;
		try {

			strGbn	 = String2.nvl(form.getParam("strGbn"));	// 시스템구분
			strVal 	 = String2.nvl(form.getParam("strVal"));	// 그룹코드/사용자아이디
	/*
        	System.out.println(" strGbn _________________" + strGbn);
        	System.out.println(" strVal _________________" + strVal); 
        	System.out.println("  S _________________"  ); 
	*/
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			if(("U").equals(strGbn)) 
	            sql.put(svc.getQuery("SEL_USER_PGM"));   
			else if(("G").equals(strGbn)) 
	            sql.put(svc.getQuery("SEL_GROUP_PGM"));   
			
            sql.setString(1, strVal);     
			   
			result = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	/**
	 * <p>
	 * 프로그램을 위한 List를 리턴한다.
	 * </p>
	 * 
	 */
	public List getPgmmst(ActionForm form) throws Exception {

		List result = null;
		SqlWrapper sql = null;
		Service svc = null;

		String strLcdoe	= null;
		String strMcdoe	= null;
		String strScdoe	= null;
		
		int i = 0;
		try {

			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper(); 

			strLcdoe	 = String2.nvl(form.getParam("strLcdoe"));	// 대분류코드
			strMcdoe 	 = String2.nvl(form.getParam("strMcdoe"));	// 중분류코드
			strScdoe 	 = String2.nvl(form.getParam("strScdoe"));	// 소분류코드
/*
        	System.out.println(" strLcdoe _________________" + strLcdoe);
        	System.out.println(" strMcdoe _________________" + strMcdoe); 
        	System.out.println(" strScdoe _________________" + strScdoe);  
*/
			sql.put(svc.getQuery("SEL_PGMMST"));
			sql.setString(++i, strLcdoe);
			sql.setString(++i, strMcdoe);
			sql.setString(++i, strScdoe); 
			result = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return result;
	}
	   /**
	 * <p>
	 * 그룹별 프로그램 권한 변경사항을 저장한다.
	 * </p>
	 * Tab1,2
	 */
	public int updatePrAuth(ActionForm form, MultiInput mi, String strID) throws Exception {
		
		int 		ret = 0;
        SqlWrapper  sql = null;
        Service     svc = null;

        try {

			begin();
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
			int res = 0;

			// U:tab1, G:tab2
			String strGbn		= String2.nvl(form.getParam("strGbn"));	
			
			int i = 0;
			while (mi.next()) 
			{ 
				sql.close(); 
				if (mi.IS_INSERT()) 
				{  
					i = 0;			
					if( ("U").equals(strGbn)) 
						sql.put(svc.getQuery("SEL_USRPGM_CNT"));	 
					if( ("G").equals(strGbn)) 
						sql.put(svc.getQuery("SEL_GRPPGM_CNT"));	 

					sql.setString(++i,  mi.getString("CODE"));
					sql.setString(++i, 	mi.getString("PID")); 
					
					Map map = selectMap(sql);
					String cnt = String2.nvl((String)map.get("CNT"));
 
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복 데이터 입니다. :: " + mi.getString("CODE"));
					}
					sql.close(); 
					
					i=0; 
					if( ("U").equals(strGbn)) 
						sql.put(svc.getQuery("INS_USRPGM"));	 
					if( ("G").equals(strGbn)) 
						sql.put(svc.getQuery("INS_GRPPGM"));	 

					sql.setString(++i,  mi.getString("CODE"));
					sql.setString(++i,  mi.getString("PID"));
					sql.setString(++i,  "T".equals(mi.getString("IS_RET"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_NEW"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_DEL"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_SAVE"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_EXCEL"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_PRINT"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_CONFIRM"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_ALL"))?"Y":"N");
					sql.setString(++i,  strID);
				} 
				else if (mi.IS_UPDATE()) 
				{
					i=0;  
					if( ("U").equals(strGbn)) 
						sql.put(svc.getQuery("UPD_USRPGM"));	 
					if( ("G").equals(strGbn)) 
						sql.put(svc.getQuery("UPD_GRPPGM"));	  
					 
					sql.setString(++i,  "T".equals(mi.getString("IS_RET"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_NEW"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_DEL"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_SAVE"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_EXCEL"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_PRINT"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_CONFIRM"))?"Y":"N");
					sql.setString(++i,  "T".equals(mi.getString("IS_ALL"))?"Y":"N");
					sql.setString(++i,  strID);
					sql.setString(++i,  mi.getString("CODE"));
					sql.setString(++i, 	mi.getString("PID"));
				}
				else 
				{
					i=0;  

					if( ("U").equals(strGbn)) 
						sql.put(svc.getQuery("DEL_USRPGM"));	 
					if( ("G").equals(strGbn)) 
						sql.put(svc.getQuery("DEL_GRPPGM")); 

					sql.setString(++i, mi.getString("CODE"));
					sql.setString(++i, mi.getString("PID"));
				}
				res = update(sql);
				if (res < 1) {
					throw new Exception("데이터의 정합성 문제로 인하여  데이터 수정을 하지 못했습니다.");
				}
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret; 
	}
	

    /**
	 * <p> 권한복사POPUP</p>
	 * Tab1. 권한복사 팝업 : 권한복사
	 */
	public int saveCopyAuth(ActionForm form, MultiInput mi, String UserId) throws Exception {

		List result = null;
		SqlWrapper sql = null;
		Service svc = null;

		int 	res 	= 0;
		int 	ret 	= 0;
		int 	i 		= 0; 	 

		try {
			connect("pot");
			begin();  
			svc = (Service) form.getService();
			sql = new SqlWrapper();  

			String strGubun		= String2.nvl(form.getParam("strGubun"));	
			
			while (mi.next()) {
				
				if(mi.IS_INSERT())
				{
					if(strGubun.equals("User"))
					{ 
					// 사용자별 프로그램권한관리
					// 피복사자 권한삭제
					sql.close(); 
	
					sql.put(svc.getQuery("DEL_S_USER_AUTH"));
					sql.setString(1, mi.getString("S_USER_ID"));  
					
					res = update(sql);     
					
					// 피복사자 권한복사
					sql.close(); 

					sql.put(svc.getQuery("COPY_S_USER_AUTH"));
					sql.setString(++i, mi.getString("S_USER_ID")); 
					sql.setString(++i, UserId); 
					sql.setString(++i, UserId); 
					sql.setString(++i, mi.getString("T_USER_ID")); 

					res = update(sql);     
					} 
					else
					{
					// 조직권한관리	
						// 피복사자 권한삭제
						sql.close(); 
		
						sql.put(svc.getQuery("DEL_JOJIK_AUTH"));
						sql.setString(1, mi.getString("S_USER_ID"));  
						
						res = update(sql);     
						
						// 피복사자 권한복사
						sql.close(); 

						sql.put(svc.getQuery("COPY_JOJIK_AUTH"));
						sql.setString(++i, mi.getString("S_USER_ID")); 
						sql.setString(++i, UserId); 
						sql.setString(++i, UserId); 
						sql.setString(++i, mi.getString("T_USER_ID")); 

						res = update(sql);   
					} 
				}
				if (res < 1) 
					throw new Exception("[USER]권한복사 대상자(A)의 권한이<br>존재하지 않습니다.");
			}

		} catch (Exception e) { 
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
    /**
	 * <p>그룹권한관리 : 그룹 더블클릭시 사용자리스트 조회. </p>
	 * Tab2
	 */
	public List getUsrmst(ActionForm form) throws Exception {

		List result = null;
		SqlWrapper sql = null;
		Service svc = null;

		try {

			String strGroupCd = String2.nvl(form.getParam("strGroupCd"));	// 그룹코드
			
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper(); 

			sql.put(svc.getQuery("SEL_USRMST"));
			sql.setString(1, strGroupCd); 
			result = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return result;
	}

    /**
	 * <p>사용자별 프로그램 조직권한 정보를 리턴한다.</p>
	 * Tab3. 조직권한
	 * 
	 */
	public List selectJjauthList(ActionForm form) throws Exception {

		List result = null;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper(); 

			String strUserCd	= String2.nvl(form.getParam("strUserCd"));		// 사용자아이디 
			
			sql.put(svc.getQuery("SEL_JJAUTH"));
			sql.setString(1, strUserCd); 
			
			result = select2List(sql); 
		} catch (Exception e) {
			throw e;
		}
		return result;
	}

	/**
	 * 점 정보조회 
	 * Tab3. 조직권한
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectStrCd(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null; 
 
        try {
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_STR_CD")); 

    		connect("pot");	
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
 
	/**
	 * 부문 정보조회 
	 * Tab3. 조직권한
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectDeptCd(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;

        int	i = 0;	
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직구분 	
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드 

        try {
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_DEPT_CD")); 
            sql.setString(++i, strStrCd);
            sql.setString(++i, strOrgFlag);

    		connect("pot");	
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
 
	/**
	 * 팀정보조회 
	 * Tab3. 조직권한
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectTeamCd(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;

        int	i = 0;
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직구분 	
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드  
		String strDeptCd  = String2.nvl(form.getParam("strDeptCd"));	//부문코드 	
        try {
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_TEAM_CD")); 
            sql.setString(++i, strStrCd);
            sql.setString(++i, strOrgFlag);
            sql.setString(++i, strDeptCd);

    		connect("pot");	
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	/**
	 * PC정보조회 
	 * Tab3. 조직권한
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectPcCd(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;

        int	i = 0;
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직구분 	
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드  
		String strDeptCd  = String2.nvl(form.getParam("strDeptCd"));	//부문코드 	
		String strTeamCd  = String2.nvl(form.getParam("strTeamCd"));	//팀코드 	
        try {
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_PC_CD")); 
            sql.setString(++i, strStrCd);
            sql.setString(++i, strOrgFlag);
            sql.setString(++i, strDeptCd);
            sql.setString(++i, strTeamCd);

    		connect("pot");	
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	/**
	 * 품번정보조회 
	 * Tab3. 조직권한
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectPumbunCd(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;

        int	i = 0;
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직구분
		String strOrgCd   = String2.nvl(form.getParam("strOrgCd"));		//조직코드   
        try {
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
    		if (strOrgFlag.equals("1")) {
    			sql.put(svc.getQuery("SEL_PUMBUN_CD_SALE")); 
    		} else {
    			sql.put(svc.getQuery("SEL_PUMBUN_CD")); 
    		}
             
            sql.setString(++i, strOrgFlag); 
            sql.setString(++i, strOrgCd); 

    		connect("pot");	
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	 


    /**
	 * <p>
	 * 조직 권한정보 수정한다. 
	 * </p>
	 * 
	 */
	public int setJjauth(ActionForm form, MultiInput mi, String userId)  throws Exception {
		
        SqlWrapper  sql = null;
        Service     svc = null; 
		int 		res = 0;
		int 		ret = 0; 

		int i = 0;
        try {

			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) 
			{ 
				sql.close();
				if (mi.IS_INSERT())
				{
					i = 0;
					sql.put(svc.getQuery("INS_JJAUTH"));
					sql.setString(++i,  mi.getString("USER_ID")); 
					sql.setString(++i,  mi.getString("USER_ID")); 
					sql.setString(++i,  mi.getString("AUTH_LEVEL"));
					sql.setString(++i,  mi.getString("ORG_CD"));
					sql.setString(++i,  mi.getString("ORG_FLAG"));
					sql.setString(++i,  mi.getString("STR_CD"));
					sql.setString(++i,  mi.getString("DEPT_CD"));
					sql.setString(++i,  mi.getString("TEAM_CD"));
					sql.setString(++i,  mi.getString("PC_CD"));
					sql.setString(++i,  mi.getString("PUMBUN_CD"));
					sql.setString(++i,  mi.getString("ORG_LEVEL"));
					sql.setString(++i,  userId);
					
				} else if (mi.IS_DELETE()) {
					i = 0;
					sql.put(svc.getQuery("DEL_JJAUTH"));
					sql.setString(++i,  mi.getString("USER_ID"));
					sql.setString(++i,  mi.getString("SEQ"));
				} 

				res = update(sql);
				ret += res;

				if (res < 1) {
					throw new Exception("데이터의 정합성 문제로 인하여  데이터 처리하지 못했습니다.");
				}
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
		
	}
}
