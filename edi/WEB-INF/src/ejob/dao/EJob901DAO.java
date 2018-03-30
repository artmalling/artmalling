/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ejob.dao;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class EJob901DAO extends AbstractDAO2{
	
	/**
	 * <p>리스트 조회 </p>
	 * 
	 */
	public Map getSearchCount(ActionForm form)throws Exception{
		
		SqlWrapper sql = null;
		Service svc = null;
		Map resultInt = new HashMap();
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strnm = String2.nvl(form.getParam("strnm"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String vennm = String2.nvl(form.getParam("vennm"));
			String sDate = String2.nvl(form.getParam("sDate"));
			sDate = sDate.replace("/","");
			System.out.println("시작일===>" + sDate);
			String eDate = String2.nvl(form.getParam("eDate"));
			eDate = eDate.replace("/","");
			System.out.println("종료일===>" + eDate);
			String title = URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");

			// Like 조회가 가능토록 전환

			strnm = "%" + strnm + "%";
			vencd = "%" + vencd + "%";
			vennm = "%" + vennm + "%";
			title = "%" + title + "%";
			
			connect("pot");
			
			query = svc.getQuery("SEL_JOB_OFFER_COUNT") + "\n";
			sql.setString(++i, strnm );
			
			if (!sDate.equals("")) {
			query += svc.getQuery("SEL_JOB_OFFER_SDATE") + "\n";
			sql.setString(++i, sDate);
			}
			if (!eDate.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_EDATE") + "\n";
				sql.setString(++i, eDate);
			}
			
			if (!strnm.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_STRNM") + "\n";
				sql.setString(++i, strnm );
			}
			if (!vencd.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_VENCD") + "\n";
				sql.setString(++i, vencd);
			}
			if (!vennm.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_VENNM") + "\n";
				sql.setString(++i, vennm);
			}
			if (!title.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_TITLE") + "\n";
				sql.setString(++i, title);
			}
			
			sql.put(query);
			
			resultInt = executeQueryByMap(sql);
			
		}catch(Exception e){
			throw e;
		}
		return resultInt;
	}
	
	/**
	 * <p>리스트 조회 </p>
	 * 
	 */
	
	public StringBuffer getSearch(ActionForm form, String totalcount, int pageRecord)throws Exception{
		
		SqlWrapper sql = null;
		Service svc = null;
		StringBuffer sb = new StringBuffer();
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strnm = String2.nvl(form.getParam("strnm"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String vennm = String2.nvl(form.getParam("vennm"));
			String sDate = String2.nvl(form.getParam("sDate"));
			sDate = sDate.replace("/","");
			System.out.println("시작일===>" + sDate);
			String eDate = String2.nvl(form.getParam("eDate"));
			eDate = eDate.replace("/","");
			System.out.println("종료일===>" + eDate);
			String title = URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");
			String pageNum  = String2.nvl(form.getParam("pageNum"));
			
			// Like 조회가 가능토록 전환
			strnm = "%" + strnm + "%";
			vencd = "%" + vencd + "%";
			vennm = "%" + vennm + "%";
			title = "%" + title + "%";
			
			connect("pot");
			
			query  = svc.getQuery("SEL_JOB_OFFER_TOP") + "\n";
			query += svc.getQuery("SEL_JOB_OFFER") + "\n";
			sql.setString(++i, totalcount );
			sql.setString(++i, pageNum );
			sql.setString(++i, strnm );
			
			if (!sDate.equals("")) {
			query += svc.getQuery("SEL_JOB_OFFER_SDATE") + "\n";
			sql.setString(++i, sDate);
			}
			if (!eDate.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_EDATE") + "\n";
				sql.setString(++i, eDate);
			}
			
			if (!strnm.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_STRNM") + "\n";
				sql.setString(++i, strnm );
			}
			if (!vencd.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_VENCD") + "\n";
				sql.setString(++i, vencd);
			}
			if (!vennm.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_VENNM") + "\n";
				sql.setString(++i, vennm);
			}
			if (!title.equals("")) {
				query += svc.getQuery("SEL_JOB_OFFER_TITLE") + "\n";
				sql.setString(++i, title);
			}
			
			// 쿼리 하단 (페이징에 필요)
			// 시작지점
			
			String startRow = String.valueOf(Integer.parseInt(pageNum) * pageRecord - (pageRecord-1));
			String endRow	 = String.valueOf(Integer.parseInt(pageNum) * pageRecord);
			
			System.out.println("------------");
			System.out.println(pageNum);
			System.out.println(pageRecord);
			
			query += svc.getQuery("SEL_JOB_OFFER_END") + "\n";
			sql.setString(++i, startRow );
			sql.setString(++i, endRow );
			query += svc.getQuery("SEL_JOB_OFFER_ORDERBY") + "\n";
			
			sql.put(query);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	
	/**
	 * <p>리스트 삭제 </p>
	 * 
	 */
	
	public StringBuffer delList(ActionForm form)throws Exception{
		
		StringBuffer sb = new StringBuffer();
		String query = "";
		int i = 0;
		int ret = 0;
		
		String paramSeq 	= String2.nvl(form.getParam("paramSeq"));
		String paramStrcd 	= String2.nvl(form.getParam("paramStrcd"));
		String paramVencd 	= String2.nvl(form.getParam("paramVencd"));
		String paramYm 		= String2.nvl(form.getParam("paramYm"));
		
		try{
			
			String paramSize 	= String2.nvl(form.getParam("paramSize"));
			
			System.out.println("paramSize==>" + paramSize);
			
			connect("pot");
			begin();
			
			if (Integer.parseInt(paramSize) == 1) {
				SqlWrapper sql = new SqlWrapper();
				Service svc = (Service) form.getService();
				
					query = svc.getQuery("DEL_JOB_OFFER_LIST") + "\n";
					sql.setString(++i, paramSeq );
					sql.setString(++i, paramStrcd );
					sql.setString(++i, paramVencd );
					sql.setString(++i, paramYm );
					sql.put(query);
					ret = executeUpdate(sql);
					
					if( ret > 0 ){				
						sb.append("<?xml version='1.0' encoding='utf-8'?>");
						sb.append("<t>");
						sb.append("<r id='1'>");
						sb.append("<c id='RET'>").append(ret);
						sb.append("</c>");
						sb.append("</r>");
						sb.append("</t>");
					}else {
						sb.append("<?xml version='1.0' encoding='utf-8'?>");
						sb.append("<t>");
						sb.append("<r id='1'>");
						sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
						sb.append("</c>");
						sb.append("</r>");
						sb.append("</t>");
					}

			} else {
				
					String sParamSeq[] = paramSeq.split("/");
					String sParamStrcd[] = paramStrcd.split("/");
					String sParamVencd[] = paramVencd.split("/");
					String sParamYm[] = paramYm.split("/");
					
						for(int j = 0; j < Integer.parseInt(paramSize); j++) {// for 문을 사용하여 삭제한다.
						 i = 0;
						 SqlWrapper sql = new SqlWrapper();
						Service svc = (Service) form.getService();
							
							query = svc.getQuery("DEL_JOB_OFFER_LIST") + "\n";
							sql.setString(++i, sParamSeq[j] );
							sql.setString(++i, sParamStrcd[j] );
							sql.setString(++i, sParamVencd[j] );
							sql.setString(++i, sParamYm[j] );
							sql.put(query);
							ret += executeUpdate(sql);
							sql.close();
							sql = null;
							svc = null;
						}
						
						if( ret > 0 ){				
							sb.append("<?xml version='1.0' encoding='utf-8'?>");
							sb.append("<t>");
							sb.append("<r id='1'>");
							sb.append("<c id='RET'>").append(ret);
							sb.append("</c>");
							sb.append("</r>");
							sb.append("</t>");
						}else {
							rollback();
							sb.append("<?xml version='1.0' encoding='utf-8'?>");
							sb.append("<t>");
							sb.append("<r id='1'>");
							sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
							sb.append("</c>");
							sb.append("</r>");
							sb.append("</t>");
						}
			}
		}catch(Exception e){
			rollback();
			e.printStackTrace();
			throw e;
		} finally {
			end();
		}
		return sb;
	}
	
	
	
	public List getList(ActionForm form)throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			String strnm = String2.nvl(form.getParam("strnm"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String vennm = String2.nvl(form.getParam("vennm"));
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			String title = URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");
			
			strnm = "%" + strnm + "%";
			
			connect("pot");
			
			query = svc.getQuery("SEL_JOB_OFFER");
			sql.setString(++i, strnm );
			
			sql.put(query);
			list = executeQuery(sql);
			if(list != null) {
			}
			
		}catch(Exception e){
			throw e;
		}
		
		
		return list;
	}
	
	/**
	 * 구인수정 
	 * @tyle  StringBuffer
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public StringBuffer saveDetail(ActionForm form)throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		int ret = 0;
		
		try {
			sb = new StringBuffer();
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String mode				= String2.nvl(form.getParam("mode"));
			String sDate 			= String2.nvl(form.getParam("sDate"));
			String eDate 			= String2.nvl(form.getParam("eDate"));
			String dotcd 			= String2.nvl(form.getParam("dotcd"));
			String vencd 			= String2.nvl(form.getParam("vencd"));
			String vennm 			= String2.nvl(form.getParam("vennm"));
			String strcd 			= String2.nvl(form.getParam("strcd"));
			String ym 				= String2.nvl(form.getParam("ym"));
			String seq 				= String2.nvl(form.getParam("seq"));
			String brand 			= String2.nvl(form.getParam("brand"));
			String wanted_job 		= String2.nvl(form.getParam("wanted_job"));
			String end_dt 			= String2.nvl(form.getParam("end_dt").replaceAll("/",""));
			String person_charge 	= String2.nvl(form.getParam("person_charge"));
			String tel_1 			= String2.nvl(form.getParam("tel_1"));
			String tel_2 			= String2.nvl(form.getParam("tel_2"));
			String tel_3 			= String2.nvl(form.getParam("tel_3"));
			String submit_doc 		= String2.nvl(form.getParam("submit_doc"));
			String content 			= String2.nvl(form.getParam("content"));
			String title 			= URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");
			String userid 			= String2.nvl(form.getParam("userid"));
			
			connect("pot");
			
			begin();
			
			if (mode.equals("I")){
				query = svc.getQuery("IN_JOB_OFFER");
				
				sql.setString(++i, strcd);
				sql.setString(++i, vencd);
				sql.setString(++i, ym);
				sql.setString(++i, strcd);
				sql.setString(++i, vencd);
				sql.setString(++i, ym);
				sql.setString(++i, title);
				sql.setString(++i, brand);
				sql.setString(++i, wanted_job);
				sql.setString(++i, end_dt);
				sql.setString(++i, person_charge);
	    		sql.setString(++i, tel_1);
	    		sql.setString(++i, tel_2);
	    		sql.setString(++i, tel_3);
	    		sql.setString(++i, submit_doc);
	    		sql.setString(++i, content);
	    		sql.setString(++i, userid);
	    		sql.setString(++i, userid);
	    		
			} else if (mode.equals("U")) {
				query = svc.getQuery("UP_JOB_OFFER");
				
				sql.setString(++i, title);
				sql.setString(++i, brand);
				sql.setString(++i, wanted_job);
				sql.setString(++i, end_dt);
				sql.setString(++i, person_charge);
	    		sql.setString(++i, tel_1);
	    		sql.setString(++i, tel_2);
	    		sql.setString(++i, tel_3);
	    		sql.setString(++i, submit_doc);
	    		sql.setString(++i, content);
	    		sql.setString(++i, userid);
	    		sql.setString(++i, seq);
	    		sql.setString(++i, strcd);
				sql.setString(++i, vencd);
				sql.setString(++i, ym);
				
	    		
			}
    		
    		sql.put(query);
    		
    		ret = executeUpdate(sql);
			
    		System.out.println("ret===> "+ ret);
			if( ret > 0 ){				
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append(ret);
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}
			
			System.out.println(sb);
		}catch(Exception e){
			rollback();
            throw e;
		}finally {
			end();
		}
		return sb;
			
	}
	
	
	
	/**
	 * <p>리스트 삭제 </p>
	 * 
	 */
	
	public StringBuffer delDetail(ActionForm form)throws Exception{
		
		StringBuffer sb = new StringBuffer();
		String query = "";
		int i = 0;
		int ret = 0;
		
		String paramSeq 	= String2.nvl(form.getParam("seq"));
		String paramStrcd 	= String2.nvl(form.getParam("strcd"));
		String paramVencd 	= String2.nvl(form.getParam("vencd"));
		String paramYm 		= String2.nvl(form.getParam("ym"));
		
		try{
			
			
			connect("pot");
			begin();
			
			SqlWrapper sql = new SqlWrapper();
			Service svc = (Service) form.getService();
				
			query = svc.getQuery("DEL_JOB_OFFER_LIST") + "\n";
			sql.setString(++i, paramSeq );
			sql.setString(++i, paramStrcd );
			sql.setString(++i, paramVencd );
			sql.setString(++i, paramYm );
			sql.put(query);
			ret = executeUpdate(sql);
					
				if( ret > 0 ){				
					sb.append("<?xml version='1.0' encoding='utf-8'?>");
					sb.append("<t>");
					sb.append("<r id='1'>");
					sb.append("<c id='RET'>").append(ret);
					sb.append("</c>");
					sb.append("</r>");
					sb.append("</t>");
				}else {
					sb.append("<?xml version='1.0' encoding='utf-8'?>");
					sb.append("<t>");
					sb.append("<r id='1'>");
					sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 삭제를 하지 못했습니다.");
					sb.append("</c>");
					sb.append("</r>");
					sb.append("</t>");
				}

		}catch(Exception e){
			rollback();
			e.printStackTrace();
			throw e;
		} finally {
			end();
		}
		return sb;
	}
	
	public void upHit(ActionForm form)throws Exception{
			
			SqlWrapper sql = null;
			Service svc = null;
			int i = 0;
			begin();
			try{
				sql = new SqlWrapper();
				svc = (Service)form.getService();
				
				String seqno 	= String2.nvl(form.getParam("seq"));
				String strcd 	= String2.nvl(form.getParam("strcd"));
				String vencd	= String2.nvl(form.getParam("vencd"));
				String ym	 	= String2.nvl(form.getParam("ym"));
				connect("pot"); 
				sql.put(svc.getQuery("UP_JOB_OFFER_HIT"));
				sql.setString(++i, strcd);
				sql.setString(++i, vencd);
				sql.setString(++i, ym);
				sql.setString(++i, seqno);
				
				executeUpdate(sql);
				
			}catch(Exception e){
				rollback();
				 throw e;
			} finally {
				end();
			}
		}
	
	public Map getDetail(ActionForm form)throws Exception{
		
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		Map returnMap = new HashMap();
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String seqno 	= String2.nvl(form.getParam("seq"));
			String strcd 	= String2.nvl(form.getParam("strcd"));
			String vencd	= String2.nvl(form.getParam("vencd"));
			String ym	 	= String2.nvl(form.getParam("ym"));
			connect("pot"); 
			
			sql.put(svc.getQuery("SEL_JOB_OFFER_DETAIL"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, ym);
			sql.setString(++i, seqno);
			
			returnMap = executeQueryByMap(sql);
			
		}catch(Exception e){
			 throw e;
		}
		return returnMap;
	}
	
	
public StringBuffer getSearchOpenVendor(ActionForm form)throws Exception{
		
		SqlWrapper sql  = null;
		Service svc     = null;
		StringBuffer sb = new StringBuffer();
		String query    = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			String strnm = String2.nvl(form.getParam("strnm"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String vennm = String2.nvl(form.getParam("vennm"));

			strnm = "%" + strnm + "%";
			vennm = "%" + vennm + "%";
			vencd = "%" + vencd + "%";

			connect("pot");

			query = svc.getQuery("SEL_VENDOR") + "\n";
			sql.setString(++i, strnm );
			sql.setString(++i, vencd );
			sql.setString(++i, vennm );
			sql.setString(++i, vennm );
			
			sql.put(query);
			
			sb = executeQueryByAjax(sql);
			
			System.out.println("sb : " + sb);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
}
