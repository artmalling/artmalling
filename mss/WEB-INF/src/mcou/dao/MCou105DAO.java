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
 * <p>[상담/계약]상담일자등록</p>
 * 
 * @created  on 1.0, 2011/03/05
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by
 */

public class MCou105DAO extends AbstractDAO {

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
            //String strSStrCd	= String2.nvl(form.getParam("strSStrCd"));	 // [조회용]조회시작일
            String strSSdate	= String2.nvl(form.getParam("strSSdate"));	 // [조회용]조회시작일
            String strSEdate	= String2.nvl(form.getParam("strSEdate"));	 // [조회용]조회종료일
            String strSTitle	= String2.nvl(form.getParam("strSTitle"));	 // [조회용]제목
            String strSPlace	= String2.nvl(form.getParam("strSPlace"));	 // [조회용]장소
            String strSBrandNm	= String2.nvl(form.getParam("strSBrandNm")); // [조회용]브랜드명	
            String strSVanNm	= String2.nvl(form.getParam("strSVanNm"));	 // [조회용]협력사명
            String strSPummokNm	= String2.nvl(form.getParam("strSPummokNm"));// [조회용]취급품목
            String strSBuyerCd	= String2.nvl(form.getParam("strSBuyerCd")); // [조회용]바이어
            String strOrgCd		= String2.nvl(form.getParam("strOrgCd"));	 // [조회용]취급품목
            
            //WHERE 조건
            sql.put(svc.getQuery("SEL_MO_COUNSELREQ"));
            sql.setString(++i, userId);              
            sql.setString(++i, strOrgCd); 
            sql.setString(++i, strSSdate);              
            sql.setString(++i, strSEdate); 
            
            if (!strSBrandNm.equals("")) {
            	sql.put(svc.getQuery("SEL_WHERE_BRAND_NM"));
            	sql.setString(++i, strSBrandNm);              
            }
            if (!strSVanNm.equals("")) {
            	sql.put(svc.getQuery("SEL_WHERE_VAN_NM"));
            	sql.setString(++i, strSVanNm);              
            }
            if (!strSPummokNm.equals("")) {
            	sql.put(svc.getQuery("SEL_WHERE_PUMMOK_NM"));
            	sql.setString(++i, strSPummokNm);              
            }
            if (!strSPlace.equals("")) {
            	sql.put(svc.getQuery("SEL_WHERE_PLACE"));
            	sql.setString(++i, strSPlace);              
            }
            if (!strSTitle.equals("")) {
            	sql.put(svc.getQuery("SEL_WHERE_TITLE"));
            	sql.setString(++i, strSTitle);              
            }
            
            if (!strSBuyerCd.equals("")) {
            	sql.put(svc.getQuery("SEL_WHERE_BUYER"));
            	sql.setString(++i, strSBuyerCd);              
            }

            sql.put(svc.getQuery("SEL_ORDER_BY"));
            list = select2List(sql);
        } catch (Exception e) {//오류처리
            throw e;
        }
        return list;
    }
    
    /**
     * <p> 저장  </p>
     * @param form, mi, strID
     * @return ret
     * @throws Exception
     */
    @SuppressWarnings("unused")
	public int save(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int res = 0;
        int ret = 0;
        Util util 		= new Util();
        SqlWrapper sql 	= null;
        Service svc  	= null;
        InputStream in	= null;
        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            while (mi.next()) {
                sql.close();
                if (mi.IS_INSERT()) {
                	if (mi.getString("WRITE_SEQ").equals("")) { //신규
                    	//SEQ가져오기
                    	sql.put(svc.getQuery("SEL_MO_COUNSELDAILY_SEQ"));
                		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                    	sql.setString(1, mi.getString("STR_CD"));  
                    	sql.setString(2, mi.getString("WRITE_DT"));  
                		Map mapCntrId = (Map)selectMap(sql);
                		String strSeq = mapCntrId.get("COUNSEL_SEQ").toString();		
                    	
                    	sql.close();
                    	int i =0;
                    	sql.put(svc.getQuery("INS_MO_COUNSELDAILY"));
                    	sql.setString(++i, mi.getString("STR_CD"));  
                    	sql.setString(++i, mi.getString("WRITE_DT"));  
                    	sql.setString(++i, strSeq);  
                    	sql.setString(++i, mi.getString("REQ_DT"));  
                    	sql.setString(++i, mi.getString("REQ_SEQ"));  
                    	sql.setString(++i, mi.getString("REQ_PATH"));  
                    	sql.setString(++i, mi.getString("VAN_ATNT_NM"));  
                    	sql.setString(++i, mi.getString("BUYER_CD"));  
                    	sql.setString(++i, mi.getString("TIME_HH"));  
                    	sql.setString(++i, mi.getString("TIME_MM"));  
                    	sql.setString(++i, mi.getString("PATH"));  
                    	sql.setString(++i, mi.getString("PLACE"));  
                    	sql.setString(++i, mi.getString("CONTENT"));  
                    	sql.setString(++i, mi.getString("TITLE"));  
                    	sql.setString(++i, mi.getString("BRAND_NM"));  
                    	sql.setString(++i, mi.getString("VAN_NM"));  
                    	sql.setString(++i, mi.getString("PUMMOK_NM")); 
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
                    	sql.close();
                    	int i =0;
                    	
                    	sql.put(svc.getQuery("UPD_MO_COUNSELDAILY"));
                		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                    	sql.setString(++i, mi.getString("REQ_DT"));  
                    	sql.setString(++i, mi.getString("REQ_SEQ"));  
                    	sql.setString(++i, mi.getString("REQ_PATH"));   
                    	sql.setString(++i, mi.getString("VAN_ATNT_NM"));  
                    	sql.setString(++i, mi.getString("BUYER_CD"));  
                    	sql.setString(++i, mi.getString("TIME_HH"));  
                    	sql.setString(++i, mi.getString("TIME_MM"));  
                    	sql.setString(++i, mi.getString("PATH")); 
                    	sql.setString(++i, mi.getString("PLACE"));  
                    	sql.setString(++i, mi.getString("CONTENT"));  
                    	sql.setString(++i, mi.getString("TITLE"));  
                    	sql.setString(++i, mi.getString("BRAND_NM"));  
                    	sql.setString(++i, mi.getString("VAN_NM"));  
                    	sql.setString(++i, mi.getString("PUMMOK_NM")); 
                		sql.setString(++i, userID);  
                		sql.setString(++i, mi.getString("STR_CD"));  
                		sql.setString(++i, mi.getString("WRITE_DT"));  
                		sql.setString(++i, mi.getString("WRITE_SEQ"));  
                        res = update(sql);
                        ret += res;
                        
                        //첨부파일 저장
                    	if (res == 1) {
                    		addFileContlor(form, mi, userID, mi.getString("WRITE_SEQ"));
                    	} else {
                    		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                    				+ "데이터 입력을 하지 못했습니다.");
                    	}//첨부파일 저장 끝
                	}
                } else if (mi.IS_UPDATE()) {
                	sql.close();
                	int i =0;
                	
                	sql.put(svc.getQuery("UPD_MO_COUNSELDAILY"));
            		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                	sql.setString(++i, mi.getString("REQ_DT"));  
                	sql.setString(++i, mi.getString("REQ_SEQ"));  
                	sql.setString(++i, mi.getString("REQ_PATH"));   
                	sql.setString(++i, mi.getString("VAN_ATNT_NM"));  
                	sql.setString(++i, mi.getString("BUYER_CD"));  
                	sql.setString(++i, mi.getString("TIME_HH"));  
                	sql.setString(++i, mi.getString("TIME_MM"));  
                	sql.setString(++i, mi.getString("PATH")); 
                	sql.setString(++i, mi.getString("PLACE"));  
                	sql.setString(++i, mi.getString("CONTENT"));  
                	sql.setString(++i, mi.getString("TITLE"));  
                	sql.setString(++i, mi.getString("BRAND_NM"));  
                	sql.setString(++i, mi.getString("VAN_NM"));  
                	sql.setString(++i, mi.getString("PUMMOK_NM")); 
            		sql.setString(++i, userID);  
            		sql.setString(++i, mi.getString("STR_CD"));  
            		sql.setString(++i, mi.getString("WRITE_DT"));  
            		sql.setString(++i, mi.getString("WRITE_SEQ"));  
                    res = update(sql);
                    ret += res;
                    
                    //첨부파일 저장
                	if (res == 1) {
                		addFileContlor(form, mi, userID, mi.getString("WRITE_SEQ"));
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
     * <p>상담일지작성(신청내역pop)조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getListSelect(ActionForm form, String userID) throws Exception {

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
            //String strOrgCd		= String2.nvl(form.getParam("strOrgCd"));		// 조직코드정보

            sql.put(svc.getQuery("SEL_MO_COUNSELREQ_P"));
            sql.setString(++i, userID);              
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strDeptCd);              
            sql.setString(++i, strTeamCd);             
            sql.setString(++i, strPcCd);              
            sql.setString(++i, strSdate);              
            sql.setString(++i, strEdate);              
            sql.setString(++i, strProcStat);              
            sql.setString(++i, strBuyerCd);      
            if (strWordFlag.equals("1")) {	// 회사명
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_COMP_P"));
            	sql.setString(++i, strWord);// 대표자명  
            } else if (strWordFlag.equals("2")) {
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_REP_P"));
            	sql.setString(++i, strWord);// 신청인  
            } else if (strWordFlag.equals("3")) {
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_REQ_P"));
            	sql.setString(++i, strWord);  
            }           
            
            list = select2List(sql);
            
            //복호화
          /*list = util.decryptedStr(list,18);	// 수신번호1
            list = util.decryptedStr(list,19);	// 수신번호2
            list = util.decryptedStr(list,20);	// 수신번호3
            list = util.decryptedStr(list,21);	// 수신번호1
            list = util.decryptedStr(list,22);	// 수신번호2
            list = util.decryptedStr(list,23);	// 수신번호3
            list = util.decryptedStr(list,24);	// 이메일*/
        } catch (Exception e) {//오류처리
            throw e;
        }
        
        return list;
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
				db_file_name += "_" + mi.getString("STR_CD") + "" + mi.getString("WRITE_DT") +""+strSeq;
				db_file_name += mi.getString("FILE_NM").substring(mi.getString("FILE_NM").lastIndexOf("."));  //확장자
			}
			
    		if (mi.getString("FILE_GB").equals("Y")) {
            	sql.close();
            	i = 0; 
            	sql.put(svc.getQuery("UPD_MO_DAILYFILES"));
            	sql.setString(++i, mi.getString("STR_CD"));  
            	sql.setString(++i, mi.getString("WRITE_DT"));  
            	sql.setString(++i, strSeq);  
            	sql.setString(++i, mi.getString("FILE_SEQ_NO"));  
            	sql.setString(++i, db_file_path);  //mi.getString("FILE_PATH")
            	sql.setString(++i, db_file_name);  
        		sql.setString(++i, userID);   
        		sql.setString(++i, userID);  
        		sql.setString(++i, mi.getString("STR_CD"));  
        		sql.setString(++i, mi.getString("WRITE_DT"));  
        		sql.setString(++i, mi.getString("WRITE_SEQ")); 
        		int retFile = update(sql); 
        		
        		//파일DB저장이 정상적으로 이뤄졌을경우
        		if (retFile == 1) {
            		fileMgr.fileSave("\\"+mi.getString("FILE_NM"), mi.getString("STR_CD")+""+ mi.getString("WRITE_DT")+""+strSeq , in, db_file_path+""+mi.getString("OLD_FILE_NM"), 5);
        		}
    		} else if (mi.getString("FILE_GB").equals("D")) {
            	sql.close();
            	i = 0; 
				sql.put(svc.getQuery("DEL_MO_COUNSELDAILY"));
				sql.setString(++i, mi.getString("STR_CD"));  
				sql.setString(++i, mi.getString("WRITE_DT"));  
				sql.setString(++i, mi.getString("WRITE_SEQ"));  
				sql.setString(++i, mi.getString("FILE_SEQ_NO"));   
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
	
    /** 
     * <p>마스터 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getBuyer(ActionForm form, String userId) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;

        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strSStrCd	= String2.nvl(form.getParam("strSStrCd"));	 // [조회용]점

            //WHERE 조건
            sql.put(svc.getQuery("SEL_BUYER"));
            sql.setString(++i, userId);              
            sql.setString(++i, strSStrCd);              
            list = select2List(sql);
        } catch (Exception e) {//오류처리
            throw e;
        }
        return list;
    }
}
