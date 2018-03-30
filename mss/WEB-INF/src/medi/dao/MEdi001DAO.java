package medi.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/16
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */


public class MEdi001DAO extends AbstractDAO {

	/**
	 * <p> 협력사 사원 관리 </p>
	 *  db 연결 조회
	 */
	
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		
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
		
	
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
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
		
		ret = select2List(sql);
		System.out.println("ret size :"+ ret.size());
		
		return ret;
	}
	/**
	 * <p> 협력사 사원 등록/수정 </p>
	 *  저장
	 */
	public int save(ActionForm form, MultiInput mi,String userid)throws Exception{
		
		SqlWrapper sql = null;
		Service svc = null;
		int ret = 0;
		int i = 0;
		Util        util = new Util();
		
		try{
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			
			while( mi.next() ){
				i = 1;
				if( mi.IS_UPDATE() ){	// 자료 갱신시 
										
					sql.put(svc.getQuery("UPD_EMPLIST"));
					
					sql.setString(i++, mi.getString("EMP_NAME").toString());					
					sql.setString(i++, mi.getString("EMP_FLAG").toString());
					sql.setString(i++, mi.getString("HP_NO").toString());
					sql.setString(i++, mi.getString("ENTR_DT").toString());
					sql.setString(i++, mi.getString("RETR_DT").toString());
					sql.setString(i++, userid);
					sql.setString(i++, mi.getString("ISU_YN").toString());
					sql.setString(i++, mi.getString("ISU_DATE").toString());
					sql.setString(i++, mi.getString("STR_CD").toString());
					sql.setString(i++, mi.getString("PUMBUN_CD").toString());
					sql.setString(i++, mi.getString("EMP_SEQ").toString());
					
					ret += update(sql);					
					sql.close();
					
				}
				else if ( mi.IS_INSERT() ) {	// 자료 신규 추가시
					
					sql.put(svc.getQuery("SEL_EMPSEQ"));		// SEQ 채번
					
					sql.setString(1, mi.getString("STR_CD").toString());
					sql.setString(2, mi.getString("PUMBUN_CD").toString());

					Map mapSeqno = (Map)selectMap(sql);
					String seq = mapSeqno.get("SEQ").toString();
					sql.close();
					
					sql.put(svc.getQuery("INS_EMPLIST"));
					
					sql.setString(i++, mi.getString("STR_CD").toString());
					sql.setString(i++, mi.getString("PUMBUN_CD").toString());
					//sql.setString(i++, mi.getString("EMP_SEQ").toString());
					sql.setString(i++, seq);
					sql.setString(i++, mi.getString("EMP_FLAG").toString());
					sql.setString(i++, mi.getString("EMP_NAME").toString());					
					sql.setString(i++, mi.getString("HP_NO").toString());
					sql.setString(i++, mi.getString("ENTR_DT").toString());
					sql.setString(i++, mi.getString("RETR_DT").toString());
					sql.setString(i++, mi.getString("ISU_YN").toString());
					sql.setString(i++, userid);
					sql.setString(i++, userid);
					sql.setString(i++, mi.getString("ISU_DATE").toString());
					
					ret += update(sql);					
					sql.close();
				}
				
				if (ret < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
			}
			
		}catch(Exception e){
			rollback();
			throw e;
		}finally{
			end();
		}
			
		return ret;
	}
	
	/**
	 * <p> 협력사 사원 삭제 처리 </p>
	 *  
	 */
	public int delete(ActionForm form, String userid)throws Exception{
		
		SqlWrapper sql = null;
		Service svc = null;
		int ret = 0;
		int i = 1;
		Util        util = new Util();
		
		try{
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
			String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
			String strEmpSeq	= String2.nvl(form.getParam("strEmpSeq"));
			

			sql.put(svc.getQuery("DEL_EMPLIST"));

			sql.setString(i++, userid);					
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strEmpSeq);
			
			ret += update(sql);					
			sql.close();
					
			if (ret < 1) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
				
		}catch(Exception e){
			rollback();
			throw e;
		}finally{
			end();
		}
		return ret;
	}
	
}
