package medi.dao;

import java.io.InputStream;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.FileControlMgr;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/18
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MEdi106DAO extends AbstractDAO {
	
	public List getMaster(ActionForm form) throws Exception  {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = ""; 
		sql = new SqlWrapper();		
		svc = (Service)form.getService();  

		String strcd = String2.nvl(form.getParam("strcd"));			//사원번호
		
		connect("pot");
		sql.setString(++i, strcd);
		query = svc.getQuery("SEL_VEN"); 
		
		sql.put(query);
		list = select2List(sql);
				
		return list;
	}
	
	public List getBuyerCd(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		String userid = String2.nvl(form.getParam("userid"));			//사원번호
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		sql.setString(++i, userid);
		query = svc.getQuery("SEL_BUYERCD");
		sql.put(query);
		list = select2List(sql);
		
		return list;
	}
	
	/*
	 * 바이어코드 콤보 조회
	 */
	public List getComboBuyer(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		String userid = String2.nvl(form.getParam("userid"));			//사원번호
		String org_flag = String2.nvl(form.getParam("org_flag"));			//사원번호
		String strcd = String2.nvl(form.getParam("strcd"));			//사원번호
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		sql.setString(++i, userid);
		sql.setString(++i, org_flag);
		sql.setString(++i, userid);
		sql.setString(++i, strcd);
		
		query = svc.getQuery("SEL_COMBOBUYER");
		
		
		sql.put(query);
		
		list = select2List(sql);
		
		return list;
	}
	
	
	public int save(ActionForm form, MultiInput mi, String userid) throws Exception {
		
		SqlWrapper sql = null;
        Service svc = null;
        int res = 0;
        try{
        	
        	connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            while( mi.next() ){
            	if( mi.IS_UPDATE() ){
            		//파일명 변경
            		String file_name = "";
            		String file_webDir = "";
            		if (mi.getString("FILE_NAME").length() > 0) {
            			file_name = mi.getString("FILE_NAME").substring((mi.getString("FILE_NAME").lastIndexOf("\\")+1),mi.getString("FILE_NAME").lastIndexOf(".")); //기존파일명
            			file_name += "_" + mi.getString("SEQ_NO");
            			file_name += mi.getString("FILE_NAME").substring(mi.getString("FILE_NAME").lastIndexOf("."));  //확장자
            			file_webDir = FileControlMgr.WEB_DIR;
            		}
            		
            		sql.put(svc.getQuery("UPD_NOTICE"));
            		int i= 0;
            		sql.setString(++i, mi.getString("TITLE02"));
            		sql.setString(++i, mi.getString("AUTH_FLAG"));
            		sql.setString(++i, mi.getString("CONTEN"));
            		sql.setString(++i, file_name);
            		sql.setString(++i, file_webDir);
            		sql.setString(++i, userid);
            		sql.setString(++i, mi.getString("STR_CD"));
            		sql.setString(++i, mi.getString("SEQ_NO"));
            		sql.setString(++i, mi.getString("REG_DT"));
            		
            		int ret = 0;
            		ret += update(sql);
            		res += ret;
            		sql.close();
            		
                    //첨부파일 저장
                	if (ret == 1) {
                		addFileContlor(form, mi, userid, mi.getString("SEQ_NO"));
                	} else {
                		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                				+ "데이터 입력을 하지 못했습니다.");
                	}//첨부파일 저장 끝
            	} else if( mi.IS_INSERT() ){
            		if (mi.getString("SEQ_NO").equals("")) { //신규
                    	//SEQ가져오기
                    	sql.put(svc.getQuery("SEL_SEQ_NO"));
                		Map mapSeqNo = (Map)selectMap(sql);
                		String strSeq = mapSeqNo.get("SEQ_NO").toString();	
                		sql.close();
                		
                		//파일명 변경
                		String file_name = "";
                		String file_webDir = "";
                		if (mi.getString("FILE_NAME").length() > 0) {
                			file_name = mi.getString("FILE_NAME").substring((mi.getString("FILE_NAME").lastIndexOf("\\")+1),mi.getString("FILE_NAME").lastIndexOf(".")); //기존파일명
                			file_name += "_" + strSeq;
                			file_name += mi.getString("FILE_NAME").substring(mi.getString("FILE_NAME").lastIndexOf("."));  //확장자
                			file_webDir = FileControlMgr.WEB_DIR;
                		}
                		
                		sql.put(svc.getQuery("INS_NOTICE"));
                		int i= 0;
                		sql.setString(++i, mi.getString("STR_CD"));
                		sql.setString(++i, strSeq);
                		sql.setString(++i, mi.getString("TITLE02"));
                		sql.setString(++i, mi.getString("CONTEN"));
                		sql.setString(++i, mi.getString("BUYER_CD"));
                		sql.setString(++i, mi.getString("AUTH_FLAG"));
                		sql.setString(++i, mi.getString("READ_CNT"));
                		sql.setString(++i, file_name);
                		sql.setString(++i, file_webDir);
                		sql.setString(++i, userid);
                		sql.setString(++i, userid);
                		
                		int ret = 0;
                		ret += update(sql);
                		res += ret;
                		sql.close();
                		
                        //첨부파일 저장
                    	if (ret == 1) {
                    		addFileContlor(form, mi, userid, strSeq);
                    	} else {
                    		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                    				+ "데이터 입력을 하지 못했습니다.");
                    	}//첨부파일 저장 끝
                    	
            		} else { //파일변경으로 인한 강제INSERT
            			System.out.println("############## 파일변경으로 인한 강제INSERT");
            			
                		//파일명 변경
                		String file_name = "";
                		String file_webDir = "";
                		if (mi.getString("FILE_NAME").length() > 0) {
                			file_name = mi.getString("FILE_NAME").substring((mi.getString("FILE_NAME").lastIndexOf("\\")+1),mi.getString("FILE_NAME").lastIndexOf(".")); //기존파일명
                			file_name += "_" + mi.getString("SEQ_NO");
                			file_name += mi.getString("FILE_NAME").substring(mi.getString("FILE_NAME").lastIndexOf("."));  //확장자
                			file_webDir = FileControlMgr.WEB_DIR;
                		}
            			
                		sql.put(svc.getQuery("UPD_NOTICE"));
                		int i= 0;
                		sql.setString(++i, mi.getString("TITLE02"));
                		sql.setString(++i, mi.getString("AUTH_FLAG"));
                		sql.setString(++i, mi.getString("CONTEN"));
                		sql.setString(++i, file_name);
                		sql.setString(++i, file_webDir);
                		sql.setString(++i, userid);
                		sql.setString(++i, mi.getString("STR_CD"));
                		sql.setString(++i, mi.getString("SEQ_NO"));
                		sql.setString(++i, mi.getString("REG_DT"));
                		
                		int ret = 0;
                		ret += update(sql);
                		res += ret;
                		sql.close();
                		
                        //첨부파일 저장
                    	if (ret == 1) {
                    		addFileContlor(form, mi, userid, mi.getString("SEQ_NO"));
                    	} else {
                    		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                    				+ "데이터 입력을 하지 못했습니다.");
                    	}//첨부파일 저장 끝
            		}
            	} 
            }
        	
        }catch(Exception e){
        	rollback();
            throw e;
        } finally {
        	 end();
        }
		
		return res;
	}
	
	public int delete(ActionForm form, MultiInput mi) throws Exception{
		
		SqlWrapper sql = null;
        Service svc = null;
        int res = 0;
        FileControlMgr fileCnt = new FileControlMgr();
        try{
        	mi.next();
        	connect("pot");
        	
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            String strCd = String2.nvl(form.getParam("strCd"));
            String strReg_dt = String2.nvl(form.getParam("reg_dt"));
            String strSeq_no = String2.nvl(form.getParam("seq_no"));
            
            sql.put(svc.getQuery("DEL_NOTICE"));
            sql.setString(1, strCd);
            sql.setString(2, strSeq_no);
            sql.setString(3, strReg_dt);
            
            res = update(sql);
            sql.close();
            
            if (res  < 1) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			} else {
				//첨부파일 삭제
				fileCnt.fileDelete(mi.getString("FILE_NAME"));
			}
            
        }catch(Exception e){
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
        InputStream in	= null;
		try {
			FileControlMgr fileMgr = new FileControlMgr();
			in = (InputStream) mi.get("FILE_PATH");
			String db_file_path = FileControlMgr.WEB_DIR;
			
    		if (mi.getString("FILE_GB").equals("Y")) {
    			fileMgr.fileSave("\\"+mi.getString("FILE_NAME"), strSeq , in, db_file_path+mi.getString("OLD_FILE_NAME"), 5);
    		} else if (mi.getString("FILE_GB").equals("D")) {
    			fileMgr.fileDelete(mi.getString("OLD_FILE_NAME"));
    		}
		} catch (Exception e) {
			throw e;
		} 
		
		return true;
	}
}
