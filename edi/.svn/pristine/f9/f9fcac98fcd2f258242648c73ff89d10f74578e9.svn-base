package eord.action;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import ecom.vo.SessionInfo2;
import eord.dao.EOrd105DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

public class EOrd105Action extends DispatchAction{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(EOrd105Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		
		try {
			
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2"); 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
        
		return mapping.findForward(strGoto);
	}
	/**
	 * <p> 택발행 마스터 조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd105DAO dao = null;
		
		try{
			dao = new EOrd105DAO();
			
			Json = dao.getMaster(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 택발행 디테일  조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd105DAO dao = null;
		
		try{
			dao = new EOrd105DAO();
			
			Json = dao.getDetail(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 택발행 디테일  조회</p>
	 * 
	 */
	public ActionForward getPrint(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
 
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd105DAO dao = null;

		try{ 
			dao = new EOrd105DAO();
 
			Json = dao.getPrint(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p> 택발행 이후 마스터 정보 수정한다. </p>
	 * 
	 */
	public ActionForward updTagFlagData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		StringBuffer sb = null;
		EOrd105DAO dao = null;
		String userId = "";
		
		String strGoto = form.getParam("goTo");
		
		try{
			HttpSession session = request.getSession();			
			SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
			userId   = sessionInfo.getUSER_ID();
			
			sb = new StringBuffer();
			
			dao = new EOrd105DAO();
			
			sb = dao.updTagFlagData(form, userId);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * 엑셀다운로드화면 호출
	 */
	public ActionForward excelDowns(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List rt = null;
		EOrd105DAO dao = null;
		//Excel 저장시간
		Date today = new Date();
		SimpleDateFormat dateTime = new SimpleDateFormat("yyyyMMdd_HHmmss");
		String nowTime = dateTime.format(today);
		
		StringBuffer sb =  new StringBuffer();
		//request.setCharacterEncoding("utf-8");  //클라이언트가 서버에보내는 문자 인코딩
		response.setCharacterEncoding("ISO-8859-1");  //클라이언트가 서버에보내는 문자 인코딩
		response.setHeader("Content-Disposition", "attachment;filename=DCUBECITY_"+nowTime+".TJ");
		response.setHeader("Content-Description", "JSP Generated Data");
		//response.setHeader("Content-Type", "text/html;charset=euc-kr");//텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
		//response.setHeader("Content-Type", "text/html;charset=utf-8");//텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
		response.setContentType("text/html;charset=ISO-8859-1");  //텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
		try{ 
			String strCd = String2.nvl(form.getParam("strcd"));					//점코드
			String slipNo = String2.nvl(form.getParam("slipno"));				//전표번호
			String skuFlag = String2.nvl(form.getParam("SkuFlag"));			    //단품구분
			String strTagFlag = URLDecoder.decode(String2.nvl(form.getParam("strTagFlag")), "UTF-8");	//택발행  택 구분
			
			dao = new EOrd105DAO();
			rt = dao.getExcel(form);
			
			if (rt.size() < 1) {
			} else {
				List colRt = null;
				for (int i=0; i<rt.size(); i++) {
					colRt = (List) rt.get(i);
					sb.append(""+colRt.get(0)+"\r\n");
				}
			}
			response.getWriter().println(new String(sb.toString().getBytes(), "iso-8859-1"));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return mapping.findForward("excelDowns");
	}
	
	/**
	 * 엑셀다운로드화면 호출
	 */
	public ActionForward excelDowns2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		List rt = null;
		EOrd105DAO dao = null;
		
		StringBuffer sb =  new StringBuffer();
		request.setCharacterEncoding("utf-8");  //클라이언트가 서버에보내는 문자 인코딩
		response.setHeader("Content-Disposition", "attachment;filename=택발행대행업체.xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setContentType("application/vnd.ms-excel");
		response.setContentType("text/html;charset=utf-8");  //텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
		try{ 
			String strCd = String2.nvl(form.getParam("strcd"));					//점코드
			String slipNo = String2.nvl(form.getParam("slipno"));				//전표번호
			String skuFlag = String2.nvl(form.getParam("SkuFlag"));			    //단품구분
			String strTagFlag = URLDecoder.decode(String2.nvl(form.getParam("strTagFlag")), "UTF-8");	//택발행  택 구분
			//Excel 저장시간
			Date today = new Date();
			SimpleDateFormat dateTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			String nowTime = dateTime.format(today);
			
			dao = new EOrd105DAO();
			rt = dao.getExcel(form);
			
			if (rt.size() < 1) {
				/*
				sb.append("<script> ");
				sb.append("alert('조회된 내역이 없습니다.');");
				sb.append("</script>");
				 */
			} else {
				if( "1".equals(skuFlag) ){		//단품 
					sb.append("<%@ page language=\"java\" contentType=\"text/html;charset=utf-8\"%>");
					sb.append("<html>");
					sb.append("<head>");
					sb.append("<title></title>");
					sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
					sb.append("<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms-excel; charset=utf-8\">");
					sb.append("<body>");
					sb.append("    <table border=1 width='1200'>");
					sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
					sb.append("            <td colspan=9 align='center'><H3>택발행</H3></td> ");
					sb.append("        </tr> ");
					sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
					sb.append("            <td colspan=9 align='left'>*점코드 : "+strCd+" |  *택구분 : "+strTagFlag+"  |  *저장일자 : "+nowTime+" </td> ");
					sb.append("        </tr> ");
					sb.append("        <tr style='color:black; font-weight:bold;'>");
					sb.append("            <td width='40'>NO</td>");
					sb.append("            <td width='80'>단품구분</td>");
					sb.append("            <td width='80'>년월</td>");
					sb.append("            <td width='170'>품번명</td>");
					sb.append("            <td width='230'>상품명</td>");
					sb.append("            <td width='240'>단품코드</td>");
					sb.append("            <td width='210'>단품명</td>");
					sb.append("            <td width='150'>매가단가</td>");
					sb.append("            <td width='80'>수량</td>");
					sb.append("        </tr> ");
					List colRt = null;
					
					int SalePrc = 0;
					int ordQty = 0;
					for (int i=0; i<rt.size(); i++) {
						sb.append("        <tr>");
						colRt = (List) rt.get(i);
						for (int r=0; r<colRt.size(); r++) {
							if (r==7||r==8) {
								sb.append("            <td>"+colRt.get(r)+"</td>");
							} else {
								sb.append("            <td style='mso-number-format:\\@'>"+colRt.get(r)+"</td>");
							}
						}
						//합계계산
						SalePrc += Integer.parseInt((String) colRt.get(colRt.size()-2));	//매가[단가]
						ordQty += Integer.parseInt((String) colRt.get(colRt.size()-1)) ;	//매가[수량]
						sb.append("        </tr> ");
					}
					sb.append("        <tr bgcolor=#b9d9ea> ");
					sb.append("            <td colspan='7' align='center' >합계</td>");
					sb.append("            <td>"+SalePrc+"</td>");
					sb.append("            <td>"+ordQty+"</td>");
					sb.append("        </tr> ");
					sb.append("    </table> ");
					sb.append("</body> ");
					sb.append("</html>");
				} else {
					sb.append("<%@ page language=\"java\" contentType=\"text/html;charset=utf-8\"%>");
					sb.append("<html>");
					sb.append("<head>");
					sb.append("<title></title>");
					sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
					sb.append("<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms-excel; charset=utf-8\">");
					sb.append("<body>");
					sb.append("    <table border=1 width='1160'>");
					sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
					sb.append("            <td colspan=10 align='center'><H3>택발행</H3></td> ");
					sb.append("        </tr> ");
					sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
					sb.append("            <td colspan=10 align='left'>*점코드 : "+strCd+" |  *택구분 : "+strTagFlag+"  |  *저장일자 : "+nowTime+" </td> ");
					sb.append("        </tr> ");
					sb.append("        <tr style='color:black; font-weight:bold;'>");
					sb.append("            <td width='40'>NO</td>");
					sb.append("            <td width='60'>택구분</td>");
					sb.append("            <td width='80'>년월</td>");
					sb.append("            <td width='70'>거래형태</td>");
					sb.append("            <td width='210'>브랜드명</td>");
					sb.append("            <td width='130'>코드1</td>");
					sb.append("            <td width='130'>코드2</td>");
					sb.append("            <td width='210'>품목명</td>");
					sb.append("            <td width='150'>매가단가</td>");
					sb.append("            <td width='80'>수량</td>");
					sb.append("        </tr> ");
					List colRt = null;
					
					int SalePrc = 0;
					int ordQty = 0;
					for (int i=0; i<rt.size(); i++) {
						sb.append("        <tr>");
						colRt = (List) rt.get(i);
						for (int r=0; r<colRt.size(); r++) {
							if (r==8||r==9) {
								sb.append("            <td>"+colRt.get(r)+"</td>");
							} else {
								sb.append("            <td style='mso-number-format:\\@'>"+colRt.get(r)+"</td>");
							}
						}
						//합계계산
						SalePrc += Integer.parseInt((String) colRt.get(colRt.size()-2));	//매가[단가]
						ordQty += Integer.parseInt((String) colRt.get(colRt.size()-1)) ;	//매가[수량]
						sb.append("        </tr> ");
					}
					sb.append("        <tr bgcolor=#b9d9ea> ");
					sb.append("            <td colspan='8' align='center' >합계</td>");
					sb.append("            <td>"+SalePrc+"</td>");
					sb.append("            <td>"+ordQty+"</td>");
					sb.append("        </tr> ");
					sb.append("    </table> ");
					sb.append("</body> ");
					sb.append("</html>");
				}
				
			}
			response.getWriter().println(sb.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return mapping.findForward("excelDowns");
	}
	
	/**
	 * <p> 현재달의 주 </p>
	 * 
	 */
	public ActionForward getMonthWeek(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Json = "";
		String strGoto = form.getParam("goTo");
		EOrd105DAO dao = null;
		
		try{
			dao = new EOrd105DAO();
			
			Json = dao.getMonthWeek(form);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionUtil.sendAjaxResponse(response, Json);
		return mapping.findForward(strGoto);
	} 
}
