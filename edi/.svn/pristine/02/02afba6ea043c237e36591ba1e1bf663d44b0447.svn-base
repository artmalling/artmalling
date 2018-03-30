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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class EJob902DAO extends AbstractDAO2{
	
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
			String eDate = String2.nvl(form.getParam("eDate"));
			eDate = eDate.replace("/","");
			String sCareer = String2.nvl(form.getParam("sCareer"));
			String eCareer = String2.nvl(form.getParam("eCareer"));
			String sAge = String2.nvl(form.getParam("sAge"));
			String eAge = String2.nvl(form.getParam("eAge"));
			String cust_nm = String2.nvl(form.getParam("cust_nm"));
			// Like 조회가 가능토록 전환
			
			strnm = "%" + strnm + "%";
			vencd = "%" + vencd + "%";
			vennm = "%" + vennm + "%";
			cust_nm = "%" + cust_nm + "%";
			
			connect("pot");
			
			query = svc.getQuery("SEL_JOB_HUNT_COUNT") + "\n";
			sql.setString(++i, strnm );
			
			if (!sDate.equals("")) {
			query += svc.getQuery("SEL_JOB_HUNT_SDATE") + "\n";
			sql.setString(++i, sDate);
			}
			if (!eDate.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_EDATE") + "\n";
				sql.setString(++i, eDate);
			}
			
			if (!strnm.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_STRNM") + "\n";
				sql.setString(++i, strnm );
			}
			if (!vencd.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_VENCD") + "\n";
				sql.setString(++i, vencd);
			}
			if (!vennm.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_VENNM") + "\n";
				sql.setString(++i, vennm);
			}
			if (!sCareer.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_SCAREER") + "\n";
				sql.setString(++i, sCareer);
			}
			if (!eCareer.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_ECAREER") + "\n";
				sql.setString(++i, sCareer);
			}
			if (!sAge.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_SAGE") + "\n";
				sql.setString(++i, sAge);
			}
			if (!eAge.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_EAGE") + "\n";
				sql.setString(++i, eAge);
			}
			if (!cust_nm.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_CUSTNM") + "\n";
				sql.setString(++i, cust_nm);
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
			String eDate = String2.nvl(form.getParam("eDate"));
			eDate = eDate.replace("/","");
			String sCareer = String2.nvl(form.getParam("sCareer"));
			String eCareer = String2.nvl(form.getParam("eCareer"));
			String sAge = String2.nvl(form.getParam("sAge"));
			String eAge = String2.nvl(form.getParam("eAge"));
			String cust_nm = String2.nvl(form.getParam("cust_nm"));
			String pageNum  = String2.nvl(form.getParam("pageNum"));
			
			// Like 조회가 가능토록 전환
			strnm = "%" + strnm + "%";
			vencd = "%" + vencd + "%";
			vennm = "%" + vennm + "%";
			cust_nm = "%" + cust_nm + "%";
			
			connect("pot");
			
			query  = svc.getQuery("SEL_JOB_HUNT_TOP") + "\n";
			query += svc.getQuery("SEL_JOB_HUNT") + "\n";
			sql.setString(++i, totalcount );
			sql.setString(++i, pageNum );
			sql.setString(++i, strnm );
			
			if (!sDate.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_SDATE") + "\n";
				sql.setString(++i, sDate);
			}
			if (!eDate.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_EDATE") + "\n";
				sql.setString(++i, eDate);
			}
			
			if (!strnm.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_STRNM") + "\n";
				sql.setString(++i, strnm );
			}
			if (!vencd.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_VENCD") + "\n";
				sql.setString(++i, vencd);
			}
			if (!vennm.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_VENNM") + "\n";
				sql.setString(++i, vennm);
			}
			if (!sCareer.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_SCAREER") + "\n";
				sql.setString(++i, sCareer);
			}
			if (!eCareer.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_ECAREER") + "\n";
				sql.setString(++i, sCareer);
			}
			if (!sAge.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_SAGE") + "\n";
				sql.setString(++i, sAge);
			}
			if (!eAge.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_EAGE") + "\n";
				sql.setString(++i, eAge);
			}
			if (!cust_nm.equals("")) {
				query += svc.getQuery("SEL_JOB_HUNT_CUSTNM") + "\n";
				sql.setString(++i, cust_nm);
			}
			
			// 쿼리 하단 (페이징에 필요)
			// 시작지점
			
			String startRow = String.valueOf(Integer.parseInt(pageNum) * pageRecord - (pageRecord-1));
			String endRow	 = String.valueOf(Integer.parseInt(pageNum) * pageRecord);
			
			query += svc.getQuery("SEL_JOB_HUNT_END") + "\n";
			sql.setString(++i, startRow );
			sql.setString(++i, endRow );
			query += svc.getQuery("SEL_JOB_HUNT_ORDERBY") + "\n";
			
			sql.put(query);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	
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
			String end_dt 			= String2.nvl(form.getParam("end_dt"));
			String person_charge 	= String2.nvl(form.getParam("person_charge"));
			String tel 				= String2.nvl(form.getParam("tel"));
			String submit_doc 		= String2.nvl(form.getParam("submit_doc"));
			String content 			= String2.nvl(form.getParam("content"));
			String title 			= URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");
			
			connect("pot");
			
			begin();
			
			if (mode.equals("I")){
				query = svc.getQuery("IN_JOB_HUNT");
				
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
	    		sql.setString(++i, tel);
	    		sql.setString(++i, submit_doc);
	    		sql.setString(++i, content);
	    		
			} else if (mode.equals("U")) {
				query = svc.getQuery("UP_JOB_HUNT");
				
				sql.setString(++i, strcd);
				sql.setString(++i, vencd);
				sql.setString(++i, ym);
				sql.setString(++i, title);
				sql.setString(++i, brand);
				sql.setString(++i, wanted_job);
				sql.setString(++i, end_dt);
				sql.setString(++i, person_charge);
	    		sql.setString(++i, tel);
	    		sql.setString(++i, submit_doc);
	    		sql.setString(++i, content);
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
				sql.put(svc.getQuery("UP_JOB_HUNT_HIT"));
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
			String ymd	 	= String2.nvl(form.getParam("ymd"));
			connect("pot"); 
			
			sql.put(svc.getQuery("SEL_JOB_HUNT_DETAIL"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, ymd);
			sql.setString(++i, seqno);
			
			returnMap = executeQueryByMap(sql);
			
		}catch(Exception e){
			 throw e;
		}
		return returnMap;
	}
	
	
	public List getDetailFile(ActionForm form)throws Exception{
		
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		List returnList = null;
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String seqno 	= String2.nvl(form.getParam("seq"));
			String strcd 	= String2.nvl(form.getParam("strcd"));
			String vencd	= String2.nvl(form.getParam("vencd"));
			String ymd	 	= String2.nvl(form.getParam("ymd"));
			connect("pot"); 
			
			sql.put(svc.getQuery("SEL_JOB_HUNT_DETAIL_FILE"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, ymd);
			sql.setString(++i, seqno);
			
			returnList = executeQuery(sql);
			
		}catch(Exception e){
			 throw e;
		}
		return returnList;
	}
}
