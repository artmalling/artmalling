package eord.dao;

import java.util.List;

import ecom.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class EOrd105DAO extends AbstractDAO2{
	/**
	 * <p> 택발행 마스터 조회</p>
	 * 
	 */
	public String getMaster(ActionForm form) throws Exception{
		String returnJson = null;
		List list = null;
		SqlWrapper sql = null; 
		Service svc = null;
		int i = 0;
		Util util = new Util();
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String Strcd = String2.nvl(form.getParam("strcd"));					//점코드
			String Vencd = String2.nvl(form.getParam("vencd"));					//협력사코드
			String Pumbuncd = String2.nvl(form.getParam("pubumCd"));			//품번코드
			String SlipProcFlag = String2.nvl(form.getParam("SlipProcFlag"));	//전표진행상태
			String Slip_flag = String2.nvl(form.getParam("Slip_flag"));			//전표구분
			String Shgb = String2.nvl(form.getParam("Shgb"));					//조회구분
			String TagFlag = String2.nvl(form.getParam("TagFlag"));				//택구분
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			
			connect("pot");
			
			
			sql.put(svc.getQuery("SEL_MASTER"));
			if( "1".equals(Shgb) ){												//발주일자
				sql.put(svc.getQuery("SEL_ORDDT"));
			}else {																//납품예정일
				sql.put(svc.getQuery("SEL_DELIDT"));
			}

			sql.setString(++i, TagFlag);
			sql.setString(++i, SlipProcFlag);
			sql.setString(++i, Slip_flag);
			sql.setString(++i, Strcd);
			sql.setString(++i, Vencd);
			sql.setString(++i, Pumbuncd);
			sql.setString(++i, TagFlag);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			
			list = executeQueryByList(sql);
			
			String cols = "STR_CD,STR_NM,SLIP_NO,ORD_DT,DELI_DT,PUMBUN_CD,PUMBUN_NM,VEN_CD,VEN_NM,BIZ_TYPE,BIZ_TYPE_NM,TAG_PRT_YN,TAG_PRT_DT";
			cols += ",TAG_PRT_CNT,SLIP_FLAG,SLIP_FLAG_NM,SLIP_PROC_STAT,SLIP_PROC_STAT_NM,ORD_TOT_QTY,NEW_COST_TAMT,NEW_SALE_TAMT,SKU_FLAG,SKU_TYPE,TAG_FLAG";
			
			returnJson = util.listToJsonOBJ(list, cols);
			
			
		}catch(Exception e){
			throw e;
		}
		
		return returnJson;
	}
	
	/**
	 * <p> 택발행 디테일 조회</p>
	 * 
	 */
	public String getDetail(ActionForm form) throws Exception{
		String returnJson = null;
		List list = null;
		SqlWrapper sql = null; 
		Service svc = null;
		int i = 0;
		Util util = new Util();
		String cols = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strCd = String2.nvl(form.getParam("strcd"));					//점코드
			String slipNo = String2.nvl(form.getParam("slipno"));				//전표번호
			String skuFlag = String2.nvl(form.getParam("SkuFlag"));			    //단품구분
			
			connect("pot");
			
			if( "1".equals(skuFlag) ){		//단품 
				sql.put(svc.getQuery("SEL_SKU"));
			} else if( "2".equals(skuFlag) ){	//품목
				sql.put(svc.getQuery("SEL_PUMMOK"));
			}
			
			sql.setString(++i, strCd);
			sql.setString(++i, slipNo);
			
			list = executeQueryByList(sql);
            
			if( "1".equals(skuFlag) ){		//단품 
				cols = "STR_CD,SLIP_NO,PUMBUN_CD,PUMBUN_NM,PUMMOK_CD,PUMMOK_NM,SKU_CD,SKU_NM,SKU_RECP_NAME,RECP_NAME,STYLE_CD,COLOR_CD,COLOR_NM";
				cols += ",SIZE_CD,SIZE_NM,ORD_UNIT_CD,ORD_QTY,NEW_SALE_PRC,NEW_SALE_AMT,SEASON_CD,SEASON_NM,PLAN_YEAR,BIZ_TYPE,BIZ_TYPE_NM,TAX_FLAG,TAX_FLAG_NM";
			} else if( "2".equals(skuFlag) ){	//품목
				cols = "STR_CD,SLIP_NO,PUMBUN_CD,PUMBUN_NM,PUMMOK_CD,PUMMOK_NM,PMK_RECP_NAME,RECP_NAME,ORD_UNIT_CD,ORD_QTY,NEW_SALE_PRC";
				cols += ",NEW_SALE_AMT,EVENT_FLAG,EVENT_RATE,PUMMOK_SRT_CD,BIZ_TYPE,BIZ_TYPE_NM,TAX_FLAG,TAX_FLAG_NM";
			}
			
			returnJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			throw e;
		}
		
		return returnJson;
	}
	
	/**
	 * <p> 택발행 디테일 조회</p>
	 * 
	 */
	public List getExcel(ActionForm form) throws Exception{
		List list = null;
		SqlWrapper sql = null; 
		Service svc = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strCd = String2.nvl(form.getParam("strcd"));					//점코드
			String slipNo = String2.nvl(form.getParam("slipno"));				//전표번호
			String skuFlag = String2.nvl(form.getParam("SkuFlag"));			    //단품구분
			
			connect("pot");
			
			if( "1".equals(skuFlag) ){		//단품 
				sql.put(svc.getQuery("SEL_SKU_EXCEL"));
			} else if( "2".equals(skuFlag) ){	//품목
				sql.put(svc.getQuery("SEL_PUMMOK_EXCEL"));
			}
			
			sql.setString(1, strCd);
			sql.put("AND DTL.SLIP_NO IN (" + slipNo + ")");
			
			list = executeQueryByList(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return list;
	}
	
	/**
	 * <p> 택발행 디테일 조회</p>
	 * 
	 */
	public String getPrint(ActionForm form) throws Exception{
		String returnJson = null;
		List list = null;
		SqlWrapper sql = null; 
		Service svc = null;
		int i = 0;
		Util util = new Util();
		String cols = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
 
			String strCd 		 = String2.nvl(form.getParam("strcd"));					//점코드
			String arrSlipNo  	 = String2.nvl(form.getParam("slipno"));   				//전표번호
			String skuFlag 		 = String2.nvl(form.getParam("SkuFlag"));			    //단품구분
			
			connect("pot");
			if( "1".equals(skuFlag) ){		//단품 
				sql.put(svc.getQuery("SEL_SKU_IN"));
				sql.setString(1, strCd);
				sql.put("AND DTL.SLIP_NO IN (" + arrSlipNo + ")");
				sql.put("UNION ALL");
				sql.put(svc.getQuery("SEL_SKU_IN_GB"));
				sql.setString(1, strCd);
				sql.put("AND DTL.SLIP_NO IN (" + arrSlipNo + ")");
				sql.put("ORDER BY SLIP_NO, STR_CD DESC");
			} else if( "2".equals(skuFlag) ){	//품목
				sql.put(svc.getQuery("SEL_PUMMOK_IN"));
				sql.setString(1, strCd);
				sql.put("AND DTL.SLIP_NO IN (" + arrSlipNo + ")");
				sql.put("UNION ALL");
				sql.put(svc.getQuery("SEL_PUMMOK_IN_GB"));
				sql.setString(1, strCd);
				sql.put("AND DTL.SLIP_NO IN (" + arrSlipNo + ")");
				sql.put("ORDER BY SLIP_NO, STR_CD DESC");
			}
			
			//sql.setString(++i, strCd);
			//sql.setString(++i, arrSlipNo); 
			
			list = executeQueryByList(sql);

			if( "1".equals(skuFlag) ){		//단품 
				cols = "STR_CD,SLIP_NO,PUMBUN_CD,PUMBUN_NM,PUMMOK_CD,PUMMOK_NM,SKU_CD,SKU_NM,SKU_RECP_NAME,RECP_NAME,STYLE_CD,COLOR_CD,COLOR_NM";
				cols += ",SIZE_CD,SIZE_NM,ORD_UNIT_CD,ORD_QTY,NEW_SALE_PRC,NEW_SALE_AMT,SEASON_CD,SEASON_NM,PLAN_YEAR,BIZ_TYPE,BIZ_TYPE_NM,TAX_FLAG,TAX_FLAG_NM";
			} else if( "2".equals(skuFlag) ){	//품목
				cols = "STR_CD,SLIP_NO,PUMBUN_CD,PUMBUN_NM,PUMMOK_CD,PUMMOK_NM,PMK_RECP_NAME,RECP_NAME,ORD_UNIT_CD,ORD_QTY,NEW_SALE_PRC";
				cols += ",NEW_SALE_AMT,EVENT_FLAG,EVENT_RATE,PUMMOK_SRT_CD,BIZ_TYPE,BIZ_TYPE_NM,TAX_FLAG,TAX_FLAG_NM";
			}

			returnJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			throw e;
		}
		
		return returnJson;
	}
	
	/**
	 * <p> 택발행 이후 마스터 정보 수정한다. </p>
	 * 
	 */
	public StringBuffer updTagFlagData(ActionForm form, String userId) throws Exception{
		
		StringBuffer sb = null;
		SqlWrapper sql =  null;
		Service svc = null;
		int i = 0;
		int ret = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strCd = String2.nvl(form.getParam("strcd"));					//점코드
			String slipN0 = String2.nvl(form.getParam("slipNo"));				//전표번호
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("UPD_MASTER")); 
			sql.setString(++i, userId);
			sql.setString(++i, strCd);
			sql.setString(++i, slipN0); 
			
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
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return sb;
	}
	
	/**
	 * <p>해당달의 주를 구한다. </p>
	 * 
	 */
	public String getMonthWeek(ActionForm form) throws Exception{
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!");
		String returnJson = null;
		List list = null;
		SqlWrapper sql = null; 
		Service svc = null;
		int i = 0;
		Util util = new Util();
		String cols = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");
			
			sql.put(svc.getQuery("SEL_MONTH_WEEK")); 
			list = executeQueryByList(sql); 
             
			cols = "MONTH_WEEK"; 
  
			returnJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> e" +e);
			throw e;
		}
		
		return returnJson;
	}
}
