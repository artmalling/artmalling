/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package meis.dao;

import java.util.List;
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>경영실적보고서조회</p>
 * 
 * @created on 1.0, 2011/07/08
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis072DAO extends AbstractDAO {

	/**
	 * 매출계획분석
	 * 
	 * @param form
	 * @param pFlag TODO
	 * @return
	 * @throws Exception
	 */
	public List<Map> searchTAB1(ActionForm form, boolean pFlag) throws Exception {
		List<Map> ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strOrgLevel = null;
		String strSumGb = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strOrgLevel = String2.trimToEmpty(form.getParam("strOrgLevel")); 	//조직레벨(1:점,3:팀,4:PC)
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			//점
			if(strOrgLevel.equals("1")) {
				strLoc = "SEL_TAB1_STR";
				if(pFlag) strLoc = "SEL_TAB1_STR_PRINT";	//출력
			//팀
			} else if(strOrgLevel.equals("3")) {
				strLoc = "SEL_TAB1_TEAM";
				if(pFlag) strLoc = "SEL_TAB1_TEAM_PRINT";	//출력
			//PC
			} else if(strOrgLevel.equals("4")) {
				strLoc = "SEL_TAB1_PC";
				if(pFlag) strLoc = "SEL_TAB1_PC_PRINT";		//출력
			}	
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			
			//점
			if(strOrgLevel.equals("3") || strOrgLevel.equals("4")) {
				sql.setString(i++, strStrCd);
			} 
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}
	
	/**
	 * 매출실적분석(엑셀용)
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List<Map> searchTAB1_EXCEL(ActionForm form) throws Exception {
		List<Map> ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strOrgLevel = null;
		String strSumGb = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strOrgLevel = String2.trimToEmpty(form.getParam("strOrgLevel")); 	//조직레벨(1:점,3:팀,4:PC)
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			strLoc = "SEL_TAB1_EXCEL";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			
			sql.setString(i++, strStrCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}	
	
	/**
	 * 매출구성실적분석
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTAB2(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strOrgLevel = null;
		String strSumGb = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strOrgLevel = String2.trimToEmpty(form.getParam("strOrgLevel")); 	//조직레벨(1:점,3:팀,4:PC)
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			//점
			if(strOrgLevel.equals("1")) {
				strLoc = "SEL_TAB2_STR";
				strStrCd = "%";
			//팀
			} else if(strOrgLevel.equals("3")) {
				strLoc = "SEL_TAB2_TEAM";
			//PC
			} else if(strOrgLevel.equals("4")) {
				strLoc = "SEL_TAB2_PC";
			}			
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strStrCd);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strOrgLevel);
			sql.setString(i++, strSumGb);
			
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			
			//점
			if(strOrgLevel.equals("3") || strOrgLevel.equals("4")) {
				sql.setString(i++, strStrCd);
			} 
			
			connect("pot");

			ret = select2List(sql);
			this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}
	
	/**
	 * 매출구성실적분석(엑셀용)
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTAB2_EXCEL(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strOrgLevel = null;
		String strSumGb = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strOrgLevel = String2.trimToEmpty(form.getParam("strOrgLevel")); 	//조직레벨(1:점,3:팀,4:PC)
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			strLoc = "SEL_TAB2_EXCEL";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strStrCd);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strOrgLevel);
			sql.setString(i++, strSumGb);
			
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strSumGbRsltYm);
			sql.setString(i++, strRsltYm);
			
			sql.setString(i++, strStrCd);
			
			connect("pot");

			ret = select2List(sql);
			//this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}	
	
	/**
	 * 매출구성실적분석차트조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chartTAB2(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String CHART_GUBUN = null;
		String ORG_CD = null;
		String SUM_GUBUN = null;
		String GROUP_GUBUN = null;
		String HD_ORG_CD = null;
		String STR_CD = null;
		String BIZ_RSLT_YM = null;
		String ORG_LEVEL = null;
		String SUM_GB = null;
		
		String strCd = null;
		String deptCd = null;
		String teamCd = null;
		String pcCd = null;
		String commCd = "";
		
		String strSumGbRsltYm = null;

		try {
			//파라미터 값 가져오기
			CHART_GUBUN = String2.trimToEmpty(form.getParam("CHART_GUBUN")); 
			ORG_CD = String2.trimToEmpty(form.getParam("ORG_CD")); 
			SUM_GUBUN = String2.trimToEmpty(form.getParam("SUM_GUBUN"));
			GROUP_GUBUN = String2.trimToEmpty(form.getParam("GROUP_GUBUN")); 
			HD_ORG_CD = String2.trimToEmpty(form.getParam("HD_ORG_CD")); 
			STR_CD = String2.trimToEmpty(form.getParam("STR_CD"));			
			BIZ_RSLT_YM = String2.trimToEmpty(form.getParam("BIZ_RSLT_YM")); 
			ORG_LEVEL = String2.trimToEmpty(form.getParam("ORG_LEVEL"));
			SUM_GB = String2.trimToEmpty(form.getParam("SUM_GB"));
			
			strCd = HD_ORG_CD.substring(0, 2).equals("00") ? "%" : HD_ORG_CD.substring(0, 2);
			deptCd = HD_ORG_CD.substring(2, 4);
			teamCd = HD_ORG_CD.substring(4, 6);
			pcCd = HD_ORG_CD.substring(6, 8);
			
			//당월
			if(SUM_GB.equals("1")) {
				strSumGbRsltYm = BIZ_RSLT_YM; 
			//누계
			} else if(SUM_GB.equals("2")) {
				strSumGbRsltYm = BIZ_RSLT_YM.substring(0, 4) + "01";
			}
			
			if(CHART_GUBUN.equals("SALES_RATIO")) commCd = "1";				//매출구성비
			else if(CHART_GUBUN.equals("SALES_PROFIT_RATIO")) commCd = "3";	//매출이익구성비

				
			//점
			if(ORG_LEVEL.equals("1")) {
				strLoc = "SEL_TAB2_CHART_STR";
			//팀	
			} else if(ORG_LEVEL.equals("3")) {
				strLoc = "SEL_TAB2_CHART_TEAM";
			//PC	
			} else if(ORG_LEVEL.equals("4")) {
				strLoc = "SEL_TAB2_CHART_PC";
			}
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			//점
			if(ORG_LEVEL.equals("1")) {
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);

				sql.setString(i++, strCd);
			//팀	
			} else if(ORG_LEVEL.equals("3")) {
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				//원본
				if(GROUP_GUBUN.equals("00")) {
					sql.setString(i++, strCd + deptCd + teamCd);
				//팀합계	
				} else if(GROUP_GUBUN.equals("11")) {
					sql.setString(i++, strCd + "%");
				}
				
			//PC	
			} else if(ORG_LEVEL.equals("4")) {
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				sql.setString(i++, commCd);
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, BIZ_RSLT_YM);
				//원본
				if(GROUP_GUBUN.equals("000")) {
					sql.setString(i++, strCd + deptCd + teamCd + pcCd);
				//팀별소계	
				} else if(GROUP_GUBUN.equals("001")) {
					sql.setString(i++, strCd + deptCd + teamCd + "%");
				//전체합계	
				} else if(GROUP_GUBUN.equals("111")) {
					sql.setString(i++, strCd + "%");
				}
			}
			
			connect("pot");

			//ret = select2List(sql);
			
			ret = this.select(sql);
			
		} catch (Exception e) {
			//e.printStackTrace();
			//throw e;
		}
		return ret;

	}	
	
	
	/**
	 * 손익실적분석 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTAB3(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strSumGb = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); 	//부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); 	//팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); 		//PC코드)

			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}
			
			
			strLoc = "SEL_TAB3";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, strRsltYm);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPcCd);
			}
			
			connect("pot");

			ret = select2List(sql);
			//this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}
	
	/**
	 * 손익실적분석 엑셀조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTAB3_EXCEL(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strSumGb = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); 	//부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); 	//팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); 		//PC코드)

			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			strLoc = "SEL_TAB3_EXCEL";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, strRsltYm);
				sql.setString(i++, strStrCd);
			}
			
			connect("pot");

			ret = select2List(sql);
			//this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}	

	/**
	 * 손익실적분석차트조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chartTAB3(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strSumGb = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); 	//부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); 	//팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); 		//PC코드)

			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}
			
			
			strLoc = "SEL_TAB3_CHART";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, strRsltYm);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPcCd);
			}
			
			connect("pot");

			ret = this.select(sql);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}	
	
	/**
	 * 판관비중분류실적분석 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTAB4_M(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strSumGb = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); 	//부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); 	//팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); 		//PC코드)

			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			strLoc = "SEL_TAB4_M";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();

			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strRsltYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSumGb);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			
			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, strRsltYm);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPcCd);
			}
			
			connect("pot");

			ret = select2List(sql);
			//this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}	
	
	/**
	 * 판관비소분류실적분석 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTAB4_S(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strSumGb = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;
		
		String strBizCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); 	//부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); 	//팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); 		//PC코드)

			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}
			
			strBizCd = String2.trimToEmpty(form.getParam("strBizCd")); 		//실적항목코드

			strLoc = "SEL_TAB4_S";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();

			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strRsltYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSumGb);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			
			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, strRsltYm);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPcCd);
				sql.setString(i++, strBizCd);
			}
			
			connect("pot");

			ret = select2List(sql);
			//this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}	
	
	/**
	 * 판관비계획분석 엑셀 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTAB4_EXCEL(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strSumGb = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); 	//부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); 	//팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); 		//PC코드)

			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			strLoc = "SEL_TAB4_EXCEL";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, strRsltYm);
				sql.setString(i++, strStrCd);
			}
			
			connect("pot");

			ret = select2List(sql);
			//this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}	
	
	/**
	 * 판매관리실적차트조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chartTAB4(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strSumGbRsltYm = null;
		String strRsltYm = null;
		String strSumGb = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); 			//점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); 		//경영계획년도
			strSumGb = String2.trimToEmpty(form.getParam("strSumGb")); 			//누계구분(1:당월,2:누계)
			
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); 	//부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); 	//팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); 		//PC코드)

			//당월
			if(strSumGb.equals("1")) {
				strSumGbRsltYm = strRsltYm; 
			//누계
			} else if(strSumGb.equals("2")) {
				strSumGbRsltYm = strRsltYm.substring(0, 4) + "01";
			}

			strLoc = "SEL_TAB4_CHART";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();

			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strRsltYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSumGb);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			
			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strSumGbRsltYm);
				sql.setString(i++, strRsltYm);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPcCd);
			}
			
			connect("pot");

			ret = this.select(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}	
	
	/**
	 * 등급별 고객현황 차트 로딩
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String searchCustPie(ActionForm form, String strUserId) throws Exception {

		List list        = null;
		Map  map         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strStrCd  = null;
		String strRsltYm = null;
		String strRtn    = null;
		String tabFlag   = null;
		String strFromYm = null;
		String strSumGb  = null;
		
		try {
			strRtn = "";
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strRsltYm  = String2.trimToEmpty(form.getParam("strRsltYm")); //일자
			strFromYm  = strRsltYm;
			strSumGb   = String2.trimToEmpty(form.getParam("strSumGb"));
			tabFlag    = String2.trimToEmpty(form.getParam("tabFlag"));

			if("2".equals(strSumGb)) strFromYm = strRsltYm.substring(0, 4) + "01";
			strLoc = "SEL_CUST_PIE";
			if(!"1".equals(tabFlag)) strLoc = "SEL_CUST_PIE2";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strFromYm+"01");
			sql.setString(i++, strRsltYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strFromYm+"01");
			sql.setString(i++, strRsltYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strFromYm+"01");
			sql.setString(i++, strRsltYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strFromYm+"01");
			sql.setString(i++, strRsltYm+"31");			
			
			connect("pot");
			list = select(sql);
			
			strRtn += "<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n";
			strRtn += "  <CHARTFX>\n";
			
			for(int x=0; x < list.size() ; x++){
				map = (Map) list.get(x);
				if(x==0){
					strRtn += "    <COLUMNS>\n";
					strRtn += "      <COLUMN NAME=\"GRADE\"  TYPE=\"String\"/>\n";
					strRtn += "      <COLUMN NAME=\"VALUE\"  TYPE=\"Integer\" />\n";
					strRtn += "    </COLUMNS>\n";
				}
				strRtn += "    <ROW GRADE=\"블랙\" VALUE=\"" + map.get("BLACK").toString() +"\"/>\n";
				strRtn += "    <ROW GRADE=\"골드\" VALUE=\"" + map.get("GOLD").toString()  +"\"/>\n";
				strRtn += "    <ROW GRADE=\"블루\" VALUE=\"" + map.get("BLUE").toString()  +"\"/>\n";
				strRtn += "    <ROW GRADE=\"그린\" VALUE=\"" + map.get("GREEN").toString() +"\"/>\n";
			}
			strRtn += "  </CHARTFX>";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return strRtn;
	}
}
