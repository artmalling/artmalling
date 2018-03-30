/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
 * <p>월마감관리</p>
 * 
 * @created  on 1.0, 2010/06/07
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

/*
 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
 */
public class PStk311DAO extends AbstractDAO {
	
	/**
	 * 월마감조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
    public List searchMaster(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));     //점
		String strCloseDtS     = String2.nvl(form.getParam("strCloseDtS"));   //마감년월 시작
		String strAffairsFlag  = String2.nvl(form.getParam("strAffairsFlag"));   //업무구분
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MCLOSE") + "\n";

		sql.setString(i++, strCloseDtS);
		sql.setString(i++, strStrCd);
		

		if (!"%".equals(strAffairsFlag)){
			strQuery += svc.getQuery("SEL_MCLOSE_AFFAIRS") + "\n";;
			sql.setString(i++, strAffairsFlag);
		}

		strQuery += svc.getQuery("SEL_MCLOSE_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

	/**
	 * 업무구분 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
    public List searchAffairs(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_AFFAIRS_FLAG") + "\n";
		

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

    /**
     * 월마감
     * 
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
	public int close(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		// 업무 코드 정의
		String saleBizCd       = "41";   // 매출
		String orderBizCd      = "42";   // 매입
		//String commissionBizCd = "44";   // 임대을수수료율 산출
		//String paymentBizCd    = "46";   // 대금지불
		String recDisBizCd     = "43";   // 수불
		String proLosBizCd     = "45";   // 손익
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		
		Map bizClsMap = new HashMap();  // 마감상관관계 체크 
		//bizClsMap.put(commissionBizCd,Arrays.asList(saleBizCd));                               // 임대을수수료산출
		//bizClsMap.put(paymentBizCd   ,Arrays.asList(saleBizCd,orderBizCd,commissionBizCd));    // 대금지불
		bizClsMap.put(recDisBizCd    ,Arrays.asList(saleBizCd,orderBizCd));                    // 수불
		bizClsMap.put(proLosBizCd    ,Arrays.asList(saleBizCd,orderBizCd,recDisBizCd));        // 손익

		Map bizUnClsMap = new HashMap();  // 마감취소상관관계 체크 
		bizUnClsMap.put(saleBizCd       ,Arrays.asList(proLosBizCd,recDisBizCd));           // 매출
		bizUnClsMap.put(orderBizCd      ,Arrays.asList(proLosBizCd,recDisBizCd));              // 매입
		//bizUnClsMap.put(commissionBizCd ,Arrays.asList(paymentBizCd));                                      // 임대을수수료산출
		bizUnClsMap.put(recDisBizCd     ,Arrays.asList(proLosBizCd));                                       // 수불
		Map map = null;
		
		String closeYn;
		String closeFlag;
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_UPDATE()) {
					closeYn = mi.getString("CLOSE_YN");
					i = 0;
					if(closeYn.equals("Y")){
						// 업무별 사전 마감여부 조회
						if( bizClsMap.containsKey(mi.getString("CLOSE_UNIT_FLAG"))){
							List chList = (List)bizClsMap.get(mi.getString("CLOSE_UNIT_FLAG"));
							
							for(int idx = 0 ; idx < chList.size() ; idx++){
								sql.close();
								i = 0;
								String tmp = "SELECT NVL((" ;
								tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN") + "\n";
								tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN_WHERE_YM") + "\n";
								tmp += "),'N') AS CLOSE_YN "+ "\n";
								tmp += "FROM DUAL ";
								
								sql.put(tmp);							
								sql.setString(++i, mi.getString("STR_CD"));					
								sql.setString(++i, (String)chList.get(idx));			
								sql.setString(++i, mi.getString("CLOSE_YM"));		
								
								map = selectMap( sql );	
								
								System.out.println(sql);
								closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
								if( !closeFlag.equals("Y")) {
									throw new Exception("[USER]"+"마감 되지 않은 업무가 존재합니다.");
								}
							}
						}
						
						// 이전월 마감여부
						sql.close();
						i = 0;
						String tmp = "SELECT NVL((";
						tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN")+ "\n";
						tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN_WHERE_YM_ADD")+ "\n";
						tmp += "),'N') AS CLOSE_YN "+ "\n";
						tmp += "FROM DUAL ";
						
						sql.put(tmp);							
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_YM"));				
						sql.setInt(++i, -1);	
						
						map = selectMap( sql );							
						closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
						if( !closeFlag.equals("Y")) {
							throw new Exception("[USER]"+"이전 월이 마감 되지 않았습니다.");
						}
						
						System.out.println("mi.getString(CLOSE_UNIT_FLAG) : " + mi.getString("CLOSE_UNIT_FLAG"));
						System.out.println("mi.getString(STR_CD) : " + mi.getString("STR_CD"));
						System.out.println("mi.getString(CLOSE_TASK_FLAG) : " + mi.getString("CLOSE_TASK_FLAG"));
						System.out.println("mi.getString(CLOSE_UNIT_FLAG) : " + mi.getString("CLOSE_UNIT_FLAG"));
						System.out.println("mi.getString(CLOSE_YM) : " + mi.getString("CLOSE_YM"));
						
						// 마감 프로시저 실행
						procedureExcute(Integer.valueOf(mi.getString("CLOSE_UNIT_FLAG")), mi.getString("STR_CD"), mi.getString("CLOSE_TASK_FLAG"), mi.getString("CLOSE_UNIT_FLAG"), mi.getString("CLOSE_YM"), strID);
						
						// 임시로 바로 업데이트
						sql.close();
						i = 0;
						sql.put(svc.getQuery("MERGE_MCLOSE"));
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));		
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_YM"));			
						sql.setString(++i, mi.getString("CLOSE_YN"));			
						sql.setString(++i, mi.getString("SAP_IF_YN"));		
						sql.setString(++i, strID);	

						res = update(sql);

						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
						
					}else{
						// 업무별 사전 마감여부 조회
						if( bizUnClsMap.containsKey(mi.getString("CLOSE_UNIT_FLAG"))){
							List chList = (List)bizUnClsMap.get(mi.getString("CLOSE_UNIT_FLAG"));

							for(int idx = 0 ; idx < chList.size() ; idx++){
								sql.close();
								i = 0;
								String tmp = "SELECT NVL((";
								tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN");
								tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN_WHERE_YM");
								tmp += "),'N') AS CLOSE_YN ";
								tmp += "FROM DUAL ";
								
								sql.put(tmp);							
								sql.setString(++i, mi.getString("STR_CD"));					
								sql.setString(++i, (String)chList.get(idx));			
								sql.setString(++i, mi.getString("CLOSE_YM"));		
								
								map = selectMap( sql );							
								closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
								if( !closeFlag.equals("N")) {
									throw new Exception("[USER]"+"마감 되어있는 업무가 존재합니다.");
								}
							}
						}
						
						// 이후 월 마감여부
						sql.close();
						i = 0;
						String tmp = "SELECT NVL((";
						tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN");
						tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN_WHERE_YM_ADD");
						tmp += "),'N') AS CLOSE_YN ";
						tmp += "FROM DUAL ";
						
						sql.put(tmp);							
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_YM"));				
						sql.setInt(++i, 1);	
						
						map = selectMap( sql );							
						closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
						if( !closeFlag.equals("N")) {
							throw new Exception("[USER]"+"이후 월이 마감 되어 있습니다.");
						}

						sql.close();
						i = 0;
						sql.put(svc.getQuery("MERGE_MCLOSE"));
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));		
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_YM"));			
						sql.setString(++i, mi.getString("CLOSE_YN"));			
						sql.setString(++i, mi.getString("SAP_IF_YN"));		
						sql.setString(++i, strID);	

						res = update(sql);

						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
						
					}
					
				} else {
					continue;
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
     * 월마감
     * 
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
	public int sapSend(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		Map map = null;
		
		String sapIF;
		String closeFlag;
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_UPDATE()) {
					sapIF = mi.getString("SAP_IF");
					i = 0;
					if(sapIF.equals("T")){
						
						// 마감여부
						sql.close();
						i = 0;
						String tmp = "SELECT NVL((";
						tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN")+ "\n";
						tmp += svc.getQuery("SEL_MCLOSE_CLOSE_YN_WHERE_YM")+ "\n";
						tmp += "),'N') AS CLOSE_YN "+ "\n";
						tmp += "FROM DUAL ";						
						sql.put(tmp);							
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_YM"));
						
						map = selectMap( sql );							
						closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
						if( !closeFlag.equals("Y")) {
							throw new Exception("[USER]"+"마감 되지 않았습니다.");
						}

						// 전송여부를 'N' 로 변경
						sql.close();
						i = 0;
						sql.put(svc.getQuery("UPD_MCLOSE_SAP"));		
						sql.setString(++i, "N");		
						sql.setString(++i, strID);	
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));		
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_YM"));	

						update(sql);
						
						// Sap 프로시저 실행
						//procedureExcute(Integer.valueOf(99, mi.getString("STR_CD"), mi.getString("CLOSE_TASK_FLAG"), mi.getString("CLOSE_UNIT_FLAG"), mi.getString("CLOSE_YM"), strID);
						

						//임시로  전송여부를 'Y' 로 변경
						sql.close();
						i = 0;
						sql.put(svc.getQuery("UPD_MCLOSE_SAP"));		
						sql.setString(++i, "Y");		
						sql.setString(++i, strID);	
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));		
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_YM"));	

						update(sql);
						
					}
					
				} else {
					continue;
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
	 * 프로시저를 실행한다.
	 * 
	 * @param caseFlag
	 * @param strCd
	 * @param closeTaskFlag
	 * @param closeUnitFlag
	 * @param closeYm
	 * @param strID
	 * @throws Exception
	 */
	private void procedureExcute( int caseFlag, String strCd, String closeTaskFlag, String closeUnitFlag, String closeYm, String strID ) throws Exception  {

		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = new ProcedureWrapper();	//프로시저 사용위함
		ProcedureResultSet prs = null;

		switch(caseFlag){
		    case 41: // 매출
			    break;
		    case 42: // 매입
			    break;
		    case 43: // 수불

				psql.put("DPS.PR_PTPBNIW", 4); // 품번이월
				
		        psql.setString(1, strCd);      // 점코드
		        psql.setString(2, closeYm);    // 이월년월          
		        psql.registerOutParameter(3, DataTypes.INTEGER);// RETURN결과
		        psql.registerOutParameter(4, DataTypes.VARCHAR);// RETURN메시지
		        
		        prs = updateProcedure(psql);
		        		            
		        resp = prs.getInt(3);
		        if( resp != 0 ){
		        	throw new Exception("[USER]" + prs.getString(4));
		        }
		        
		        
		        psql.close();
		        
				psql.put("DPS.PR_PTSKUIW", 4); // 단품이월
				
		        psql.setString(1, strCd);      // 점코드
		        psql.setString(2, closeYm);    // 이월년월          
		        psql.registerOutParameter(3, DataTypes.INTEGER);// RETURN결과
		        psql.registerOutParameter(4, DataTypes.VARCHAR);// RETURN메시지
		        
		        prs = updateProcedure(psql);
		        		            
		        resp = prs.getInt(3);
		        if( resp != 0 ){
		        	throw new Exception("[USER]" + prs.getString(4));
		        }   
			    break;
		    case 44: // 대금지불
			    break;
		    case 45: // 손익
			    break;
		    case 99: // SAP_IF
			    break;
		}
	}

}
