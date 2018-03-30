/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

/**
 * <p>
 * 청구대상데이터 가져오기 DAO
 * </p>
 * 
 * @created on 1.0, 2010/05/23
 * @created by 조형욱
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal921DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal921DAO.class);

	/**
	 * <p>
	 * 청구대상데이터 목록 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;
		String query = "";

		int i = 1;
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		begin();
		/**
		 * 
		 */
		psql = new ProcedureWrapper();
        int io = 1;
        psql.close();
        psql.put("DPS.PR_PSAL921_0", 4);    
        psql.setString(io++, paramStrCd);               	//점포
        psql.setString(io++, paramReqDt);                   //청구일자
        psql.registerOutParameter(io++, DataTypes.INTEGER); //RETURN
        psql.registerOutParameter(io++, DataTypes.VARCHAR); //MESSAGE
        /**/
        ProcedureResultSet prs = updateProcedure(psql);
        /**/
        int pcount = prs.getInt(3);

        /**
         * 
         */

		query = svc.getQuery("SEL_MASTER"); // + "\n";
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.setString(io++, paramStrCd);
		sql.put(query);
		ret = select2List(sql);

		end();
		return ret;
	}
	
	
	public List searchdetail(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;
		String query = "";

		int i = 1;
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		       
		System.out.println("111111111111111");
		query = svc.getQuery("SEL_DETAIL"); // + "\n";
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.put(query);
		ret = select2List(sql);


		return ret;
	}
	
	/**
	 * <p>
	 * 청구대상데이터 저장
	 * </p>
	 * 
	 */
	public List save(ActionForm form) throws Exception {
		int result = 0;
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));

		ProcedureWrapper psql = null;
		SqlWrapper sql = new SqlWrapper();
		Service svc = (Service) form.getService();
		//
		List list = null;
		int io = 1;
		try {
			connect("pot");
			begin();
			//
			String query = svc.getQuery("SEL_MASTER"); // + "\n";
			sql.setString(io++, paramStrCd);
			sql.setString(io++, paramReqDt);
			sql.setString(io++, paramStrCd);
			sql.setString(io++, paramReqDt);
			sql.setString(io++, paramStrCd);
			sql.put(query);
			list = select2List(sql);
			
			System.out.println("in1>>>>>>>"+ paramStrCd);
			System.out.println("in2>>>>>>>"+ paramReqDt);
			System.out.println("List>>>>>>>"+ list.size());
	        
			ProcedureResultSet prs = null;
			String code 	= "";
			String jobCnt 	= "";
			int iJobCnt		= 0;
			for (int i = 0 ; i < list.size(); i++) {
                List tmplist = (List) list.get(i);
                code 	= (String) tmplist.get(0);
                jobCnt 	= (String) tmplist.get(2);
                iJobCnt	= jobCnt != null && jobCnt.length() > 0? Integer.parseInt(jobCnt):0;
                System.out.println("code/jobcnt:"+code +"/"+ iJobCnt);
                if (iJobCnt <1) { 
                	list.set(i, tmplist);
                	continue;
                }
                
                /**
                 * Code:1 ,작업: POS신용카드매출데이터, Procedure: DPS.PR_PSAL921_1
                 * Code:2 ,작업: 문화센터홈페이지수강결재데이터, Procedure: DPS.PR_PSAL921_2
                 * Code:3 ,작업: 재청구데이터, Procedure: DPS.PR_PSAL921_3
                 */
                psql = new ProcedureWrapper();
		        io = 1;
	            psql.close();
	            psql.put("DPS.PR_PSAL921_"+ code, 5);    
	            psql.setString(io++, paramStrCd);               	//점포
	            psql.setString(io++, paramReqDt);                   //청구일자
	            psql.registerOutParameter(io++, DataTypes.INTEGER); //PROC_CNT
	            psql.registerOutParameter(io++, DataTypes.INTEGER); //RETURN
	            psql.registerOutParameter(io++, DataTypes.VARCHAR); //MESSAGE
	            /**/
	            prs = updateProcedure(psql);
	            /**/
	            int pcount = prs.getInt(3);        
	            logger.info("PROC_CNT:" + pcount);
	            System.out.println("PROC_CNT:" + pcount);
	            System.out.println("RETURN:" + prs.getInt(4));
	            System.out.println("MESSAGE:" + prs.getString(5));
	            
	            System.out.println("size:" + tmplist.size());
	            tmplist.set(3, String.valueOf(pcount));	//PROC_CNT
	            tmplist.set(4, prs.getString(5));	//MESSAGE
	            list.set(i, tmplist);
	            
	            if (pcount < 1) {
	            	result = -1;
	            	break;
	            }
	            else {
	            	result = 1;
	            }
	            
			}
			
			if (result > 0) {
            	end();
            	System.out.println("commit");
            }
            else {
            	rollback();
            	System.out.println("rollback");
            }
		} catch (Exception e) {
            rollback();
            System.out.println("rollback");
            throw e;
        } finally {
            end();
            System.out.println("commit");
        }
        
        return list;
	}
	
}
