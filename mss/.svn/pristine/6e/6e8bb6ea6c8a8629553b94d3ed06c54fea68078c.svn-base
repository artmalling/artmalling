/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcou.dao;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import common.util.FileControlMgr;
import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>[상담/계약]신규상담내역</p>
 * 
 * @created  on 1.0, 2011/01/24
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCou101DAO extends AbstractDAO {

    /**
     * <p>마스터 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getMaster(ActionForm form, String userId) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
            String strStrCd		= String2.nvl(form.getParam("strStrCd"));		// 점코드
            String strDeptCd	= String2.nvl(form.getParam("strDeptCd"));		// 부문
            String strTeamCd	= String2.nvl(form.getParam("strTeamCd"));		// 팀
            String strPcCd		= String2.nvl(form.getParam("strPcCd"));		// PC
            String strSdate		= String2.nvl(form.getParam("strSdate"));		// 조회시작일
            String strEdate		= String2.nvl(form.getParam("strEdate"));		// 조회종료일
            String strWordFlag	= String2.nvl(form.getParam("strWordFlag"));	// 검색어구분
            String strWord		= String2.nvl(form.getParam("strWord"));		// 검색어
            String strProcStat	= String2.nvl(form.getParam("strProcStat"));	// 상담진행상태
            String strBuyerCd	= String2.nvl(form.getParam("strBuyerCd"));		// 바이어코드

            sql.put(svc.getQuery("SEL_MO_COUNSELREQ"));
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strDeptCd);              
            sql.setString(++i, strTeamCd);             
            sql.setString(++i, strPcCd);              
            sql.setString(++i, strSdate);              
            sql.setString(++i, strEdate);              
            sql.setString(++i, strProcStat);              
            sql.setString(++i, strBuyerCd);      
            if (strWordFlag.equals("1")) {	// 회사명
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_COMP"));
            	sql.setString(++i, strWord);// 대표자명  
            } else if (strWordFlag.equals("2")) {
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_REP"));
            	sql.setString(++i, strWord);// 신청인  
            } else if (strWordFlag.equals("3")) {
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_REQ"));
            	sql.setString(++i, strWord);  
            }
            	
            list = select2List(sql);
        } catch (Exception e) {//오류처리
            throw e;
        }
        return list;
    }
    
    /**
     * <p>POP(마스터) 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getListMaster(ActionForm form, String userId) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            //화면(JSP)에서 입력된 (조회)파라미터(Paramater)	
            String strReqDt		= String2.nvl(form.getParam("strReqDt"));		//신청일
            String strReqSeq	= String2.nvl(form.getParam("strReqSeq"));		//신청SEQ

            sql.put(svc.getQuery("SEL_MO_COUNSELREQ_P"));
            sql.setString(++i, userId);              
            sql.setString(++i, strReqDt);              
            sql.setString(++i, strReqSeq);              
            list = select2List(sql);
            
            //복호화
         /* list = util.decryptedStr(list,6);	// 수신번호1
            list = util.decryptedStr(list,7);	// 수신번호2
            list = util.decryptedStr(list,8);	// 수신번호3
            list = util.decryptedStr(list,9);	// 수신번호1
            list = util.decryptedStr(list,10);	// 수신번호2
            list = util.decryptedStr(list,11);	// 수신번호3
            list = util.decryptedStr(list,13);	// 이메일  */
            
            List tmp = (List) list.get(0);
            String strTmp = tmp.get(14).toString();
            
            //열람기록을 UPDATE한다.
            if (!strTmp.equals("N")) {
            	begin();
            	sql.close();
                sql.put(svc.getQuery("UPD_CHANGE_PROC_STAT"));
                sql.setString(1, strReqDt);              
                sql.setString(2, strReqSeq);   
            	update(sql); 
            	end();
            }
            	
        } catch (Exception e) {//오류처리
            throw e;
        }
        return list;
    }
    
    /**
     * <p>POP(마스터) 조회(첨부파일)</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getListMasterFiles(ActionForm form, String userId) throws Exception {
    	
    	List       list = null;
    	SqlWrapper  sql = null;
    	Service     svc = null;
    	try {
    		connect("pot");
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		int i = 0;
    		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)	
    		String strReqSeq	= String2.nvl(form.getParam("strReqSeq"));		//신청SEQ
    		String strReqDt		= String2.nvl(form.getParam("strReqDt"));		//신청일
    		
    		sql.put(svc.getQuery("SEL_MO_REQFILSE"));
    		sql.setString(++i, strReqSeq);              
    		sql.setString(++i, strReqDt);              
    		list = select2List(sql);
    	} catch (Exception e) {//오류처리
    		throw e;
    	}
    	return list;
    }
    
    /**
     * <p> POP(상세) 조회 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getListDetail(ActionForm form) throws Exception {
    	
    	List       list = null;
    	SqlWrapper  sql = null;
    	Service     svc = null;
    	
    	try {
    		connect("pot");
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		int i = 0;
    		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
    		String strReqDt	= String2.nvl(form.getParam("strReqDt"));		//신청일
    		String strReqSeq	= String2.nvl(form.getParam("strReqSeq"));	//신청SEQ
    		
    		sql.put(svc.getQuery("SEL_MO_COUNSELANS_P"));
    		sql.setString(++i, strReqDt);              
    		sql.setString(++i, strReqSeq);              
    		list = select2List(sql);
    	} catch (Exception e) {//오류처리
    		throw e;
    	}
    	return list;
    }
    
    /**
     * <p>POP답변처리</p>
     * @param form, mi, strID
     * @return ret
     * @throws Exception
     */
    @SuppressWarnings("unused")
	public int listSave(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        Util util 		= new Util();
        SqlWrapper sql 	= null;
        Service svc 	= null;
        InputStream in	= null;
        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            while (mi.next()) {
                sql.close();
                
                if (mi.IS_INSERT()) { //DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
                	if (mi.getString("ANS_SEQ").equals("")) { //신규
                    	//SEQ가져오기
                    	sql.put(svc.getQuery("SEL_MO_COUNSELAN_SEQ"));
                		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                    	sql.setString(1, mi.getString("REQ_DT"));  
                    	sql.setString(2, mi.getString("REQ_SEQ"));  
                		Map mapCntrId = (Map)selectMap(sql);
                		String strSeq = mapCntrId.get("SEQ").toString();	
                    	
                    	
                        int i = 0;
                        sql.close();
                        sql.put(svc.getQuery("INS_MO_COUNSELREQ_P"));
                        //JSP에서 등록한 DataSet의 내역
                        sql.setString(++i, mi.getString("REQ_DT"));
                        sql.setString(++i, mi.getString("REQ_SEQ"));
                        sql.setString(++i, strSeq);
                        sql.setString(++i, mi.getString("PROC_STAT"));
                        sql.setString(++i, mi.getString("DELI_DT"));
                        sql.setString(++i, mi.getString("DELI_TIME_HH") + mi.getString("DELI_TIME_MM"));
                        sql.setString(++i, mi.getString("DELI_PLACE"));
                        sql.setString(++i, mi.getString("ONOFF_FLAG"));
                        sql.setString(++i, mi.getString("ANS_TYPE"));
                        sql.setString(++i, mi.getString("RJT_REASON"));
                        sql.setString(++i, mi.getString("ANS_CONTENT"));
                        sql.setString(++i, mi.getString("BUYER_PHONE1_NO"));
                        sql.setString(++i, mi.getString("BUYER_PHONE2_NO"));
                        sql.setString(++i, mi.getString("BUYER_PHONE3_NO"));
                        //Action에서 넘겨받은 session의 사용자 ID
                        sql.setString(++i, userID);   
                        sql.setString(++i, userID);   
                        
                        res = update(sql);
                        ret += res;
                        //첨부파일 저장
                    	if (res == 1) {
                    		addFileContlor(form, mi, userID, strSeq);
                    	} else {
                    		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                    				+ "데이터 입력을 하지 못했습니다.");
                    	}//첨부파일 저장 끝
                    	
                	} else {  //파일변경으로 인한 강제INSERT
                        int i = 0;
                        sql.put(svc.getQuery("UPD_MO_COUNSELREQ_P"));
                        //JSP에서 등록한 DataSet의 내역
                        sql.setString(++i, mi.getString("DELI_DT"));
                        sql.setString(++i, mi.getString("DELI_TIME_HH") + mi.getString("DELI_TIME_MM"));
                        sql.setString(++i, mi.getString("DELI_PLACE"));
                        sql.setString(++i, mi.getString("ONOFF_FLAG"));
                        sql.setString(++i, mi.getString("ANS_TYPE"));
                        sql.setString(++i, mi.getString("RJT_REASON"));
                        sql.setString(++i, mi.getString("ANS_CONTENT"));
                        sql.setString(++i, mi.getString("BUYER_PHONE1_NO"));
                        sql.setString(++i, mi.getString("BUYER_PHONE2_NO"));
                        sql.setString(++i, mi.getString("BUYER_PHONE3_NO"));
                        //Action에서 넘겨받은 session의 사용자 ID
                        sql.setString(++i, userID);   
                        sql.setString(++i, mi.getString("REQ_DT"));
                        sql.setString(++i, mi.getString("REQ_SEQ"));
                        sql.setString(++i, mi.getString("ANS_SEQ"));
                        
                        res = update(sql);
                        ret += res;
                		//첨부파일 저장
                    	if (res == 1) {
                    		addFileContlor(form, mi, userID, mi.getString("ANS_SEQ"));
                    	} else {
                    		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                    				+ "데이터 입력을 하지 못했습니다.");
                    	}//첨부파일 저장 끝
                	}

                } else if (mi.IS_UPDATE()) { //DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
                	int i = 0;
                    sql.put(svc.getQuery("UPD_MO_COUNSELREQ_P"));
                    //JSP에서 등록한 DataSet의 내역
                    sql.setString(++i, mi.getString("DELI_DT"));
                    sql.setString(++i, mi.getString("DELI_TIME_HH") + mi.getString("DELI_TIME_MM"));
                    sql.setString(++i, mi.getString("DELI_PLACE"));
                    sql.setString(++i, mi.getString("ONOFF_FLAG"));
                    sql.setString(++i, mi.getString("ANS_TYPE"));
                    sql.setString(++i, mi.getString("RJT_REASON"));
                    sql.setString(++i, mi.getString("ANS_CONTENT"));
                    sql.setString(++i, mi.getString("BUYER_PHONE1_NO"));
                    sql.setString(++i, mi.getString("BUYER_PHONE2_NO"));
                    sql.setString(++i, mi.getString("BUYER_PHONE3_NO"));
                    //Action에서 넘겨받은 session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, mi.getString("REQ_DT"));
                    sql.setString(++i, mi.getString("REQ_SEQ"));
                    sql.setString(++i, mi.getString("ANS_SEQ"));
                    
                    res = update(sql);
                    ret += res;
            		//첨부파일 저장
                	if (res == 1) {
                		addFileContlor(form, mi, userID, mi.getString("ANS_SEQ"));
                	} else {
                		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                				+ "데이터 입력을 하지 못했습니다.");
                	}//첨부파일 저장 끝
                } else {
                    //throw new Exception("" + "등록/수정 외 작업이 실행되었습니다.");
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
    
    /**
     * <p> 현재 바이어 정보 조회 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getBuyer(ActionForm form) throws Exception {
    	
    	List       list = null;
    	SqlWrapper  sql = null;
    	Service     svc = null;
    	
    	try {
    		connect("pot");
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		int i = 0;
    		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
    		String strBuyerCd	= String2.nvl(form.getParam("strBuyerCd"));		//바이어코드
    		
    		sql.put(svc.getQuery("SEL_CHANGE_BUYER"));
    		sql.setString(++i, strBuyerCd);              
    		list = select2List(sql);
    	} catch (Exception e) {//오류처리
    		throw e;
    	}
    	return list;
    }
    
    /**
     * <p> 답변삭제 </p>
     * 
     */
    public int listDel(ActionForm form, MultiInput mi) throws Exception {
    	int res = 0;
    	SqlWrapper  sql = null;
    	Service     svc = null;
    	
    	 FileControlMgr fileMgr	= null;
 		try {
 			fileMgr = new FileControlMgr();
 			
    		connect("pot");
    		begin(); //DB트렌젝션 시작
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		int i = 0;
    		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
    		String strReqDt	= String2.nvl(form.getParam("strReqDt"));		//신청일
    		String strReqSeq	= String2.nvl(form.getParam("strReqSeq"));	//신청SEQ
    		
    		while (mi.next()) {
    			//답변삭제
    			sql.close();
        		sql.put(svc.getQuery("DEL_MO_COUNSELREQ_P"));
        		sql.setString(++i, strReqDt);              
        		sql.setString(++i, strReqSeq);              
        		sql.setString(++i, mi.getString("ANS_SEQ"));              
        		res = update(sql);
        		
                if (res == 1) {
        			//답변삭제
                	i = 0;
        			sql.close();
            		sql.put(svc.getQuery("DEL_MO_ANSFILES"));
            		sql.setString(++i, strReqDt);              
            		sql.setString(++i, strReqSeq);              
            		sql.setString(++i, mi.getString("ANS_SEQ"));              
            		sql.setString(++i, "%");              
            		res = update(sql);
            		//파일삭제
            		fileMgr.fileDelete(fileMgr.WEB_DIR+""+mi.getString("OLD_FILE_NM"));
                } else {
            		throw new Exception("" + "데이터의 적합성 문제로 인하여"
            				+ "데이터 입력을 하지 못했습니다.");
            	}
    		}
    		
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }
    	return res;
    }
    
    /**
     * <p> 바이어변경저장/이력저장  </p>
     * @param form, mi, strID
     * @return ret
     * @throws Exception
     */
    @SuppressWarnings("unused")
	public int buyerCngSave(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        Util util = new Util();
        SqlWrapper sql = null;
        Service svc = null;
        List	list = null;

        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();

            while (mi.next()) {
            	String strReqDt	= String2.nvl(form.getParam("strReqDt"));	// 신청일
            	String strReqSeq= String2.nvl(form.getParam("strReqSeq"));	// 신청SEQ
                sql.close();
                if (mi.IS_INSERT()) {
                	//신규 없음!
                } else if (mi.IS_UPDATE()) {
                	
                	//바이어 조직정보 가져오기
                	sql.put(svc.getQuery("SEL_BUYER_INFO"));
            		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                	sql.setString(1, mi.getString("NEW_BUYER_CD"));  
            		list = select2List(sql);
            		List rowList = (List) list.get(0);
            		
                	String strStr = rowList.get(0).toString();
                	String strDept = rowList.get(1).toString();
                	String strTeam = rowList.get(2).toString();
                	String strPc = rowList.get(3).toString();
                	sql.close();
                	//상담신청정보 변경
            		int i = 0;
                	sql.put(svc.getQuery("UPD_CHANGE_BUYER"));
            		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                	sql.setString(++i, strStr);
                	sql.setString(++i, strDept);
                	sql.setString(++i, strTeam);
                	sql.setString(++i, strPc);
                	sql.setString(++i, mi.getString("NEW_BUYER_CD")); 
                	sql.setString(++i, userID);   
                	sql.setString(++i, strReqDt);
                	sql.setString(++i, strReqSeq);
                	res = update(sql);

                	//바이어 변경 히스토리 입력
                	if (res == 1) {
                		sql.close();
                		ret += res;
                		sql.put(svc.getQuery("INS_MO_BUYERMODHIS"));
                		i = 0;
                		//JSP에서 등록한 DataSet의 내역
                		sql.setString(++i, strReqDt);
                		sql.setString(++i, strReqSeq);
                		sql.setString(++i, mi.getString("OLD_BUYER_CD"));
                		sql.setString(++i, mi.getString("NEW_BUYER_CD"));
                		//Action에서 넘겨받은 session의 사용자 ID
                		sql.setString(++i, userID);   
                		sql.setString(++i, userID);  
                		res = update(sql);
                	} else {
                		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                				+ "데이터 입력을 하지 못했습니다.");
                	}
                	
                	ret += res;
                } else {
                    throw new Exception("" + "등록/수정 외 작업이 실행되었습니다.");
                }
                
                if (ret != 2) {
            		throw new Exception("" + "데이터의 적합성 문제로 인하여"
            				+ "데이터 입력을 하지 못했습니다.");
            	}
            }

        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }
        return res;
    }
    
	/**
	 * <p> 파일컨트롤  </p>
	 * @param form, mi, strID
	 * @return ret
	 * @throws Exception
	 */
    public Boolean addFileContlor(ActionForm form, MultiInput mi, String userID, String strSeq)
	throws Exception {
        SqlWrapper sql = null;
        Service svc = null;
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        InputStream in	= null;
        
        FileControlMgr fileMgr	= null;
		try {
			fileMgr = new FileControlMgr();
			
			in = (InputStream) mi.get("FILE_PATH");
			String db_file_path = fileMgr.WEB_DIR;
			
			int i = 0;
			String db_file_name = "";
			//DB저장 파일저장에 사용할 실제위치와 WAS위치의 파일명
			if (!mi.getString("FILE_NM").equals("")) {
				db_file_name = mi.getString("FILE_NM").substring(0,mi.getString("FILE_NM").lastIndexOf(".")); //기존파일명
				db_file_name += "_" + mi.getString("REQ_DT") + "" + mi.getString("REQ_SEQ") +""+strSeq;
				db_file_name += mi.getString("FILE_NM").substring(mi.getString("FILE_NM").lastIndexOf("."));  //확장자
			}
    		
    		if (mi.getString("FILE_GB").equals("Y")) {
            	sql.close();
            	i = 0; 
            	sql.put(svc.getQuery("UPD_MO_ANSFILES"));
            	sql.setString(++i, mi.getString("REQ_DT"));  
            	sql.setString(++i, mi.getString("REQ_SEQ"));  
            	sql.setString(++i, strSeq);    
            	sql.setString(++i, mi.getString("SEQ_NO"));  
            	sql.setString(++i, db_file_path);  //mi.getString("FILE_PATH")
            	sql.setString(++i, db_file_name);  
        		sql.setString(++i, userID);   
        		sql.setString(++i, userID);  
        		sql.setString(++i, mi.getString("REQ_DT"));  
        		sql.setString(++i, mi.getString("REQ_SEQ"));  
        		sql.setString(++i, mi.getString("ANS_SEQ")); 
        		int retFile = update(sql); 
        		
        		//파일DB저장이 정상적으로 이뤄졌을경우
        		if (retFile == 1) {
            		fileMgr.fileSave("\\"+mi.getString("FILE_NM"), mi.getString("REQ_DT")+""+ mi.getString("REQ_SEQ")+""+strSeq , in, db_file_path+""+mi.getString("OLD_FILE_NM"), 5);
        		}
    		} else if (mi.getString("FILE_GB").equals("D")) {
            	sql.close();
            	i = 0; 
				sql.put(svc.getQuery("DEL_MO_ANSFILES"));
				sql.setString(++i, mi.getString("REQ_DT"));  
				sql.setString(++i, mi.getString("REQ_SEQ"));  
				sql.setString(++i, mi.getString("ANS_SEQ"));  
				sql.setString(++i, mi.getString("SEQ_NO"));   
				int retFile = update(sql); 
				
        		//파일DB삭제 정상적으로 이뤄졌을경우
        		if (retFile == 1) {
        			fileMgr.fileDelete(db_file_path+""+mi.getString("OLD_FILE_NM"));
        		}
    		}
		} catch (Exception e) {
			throw e;
		} 
		
		return true;
	}
}
