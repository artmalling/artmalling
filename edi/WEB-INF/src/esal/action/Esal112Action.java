package esal.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import esal.dao.Esal106DAO;
import esal.dao.Esal112DAO;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

public class Esal112Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Esal112Action.class);

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
	 * <p>마스터조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
	    Esal112DAO dao = null;
		//StringBuffer sb = new StringBuffer();
		String strGoto = form.getParam("goTo");
		String json = null;
		try{
			dao = new Esal112DAO();
			json = (String)dao.getMaster(form);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
	
	
	/**
	 * <p>디테일조회</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
	    Esal112DAO dao = null;
		//StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		String json = null;
		try{

			dao = new Esal112DAO();
			
			json = (String)dao.getDetail(form);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("getDetail : ", e);
		}
		
		
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
	
	public ActionForward getExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		List rt = null;
		Esal112DAO dao = null;
		
		
		//Excel 저장시간
		Date today = new Date();
		SimpleDateFormat dateTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SimpleDateFormat dateTime2 = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowTime = dateTime.format(today);
		String nowTimeFileNm = dateTime2.format(today);
		
		
		StringBuffer sb =  new StringBuffer();
		response.setCharacterEncoding("ISO-8859-1");  //클라이언트가 서버에보내는 문자 인코딩
		response.setHeader("Content-Disposition", "attachment;filename=보너스카드회원매출조회_"+nowTimeFileNm+".xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setContentType("application/vnd.ms-excel");
		//response.setContentType("text/html;charset=utf-8");  //텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
		response.setContentType("text/html;charset=ISO-8859-1");  //텍스트나 HTML문서이면서 문자인코딩은 ISO-8859-1 전송
		try{ 
			
/*			String strcd 		= String2.nvl(form.getParam("strcd"));			//점코드
			String strVencd 	= String2.nvl(form.getParam("vencd"));			//협력사코드
			String strPumbuncd 	= String2.nvl(form.getParam("strPumbuncd"));	//품번코드
			String sDate 		= String2.nvl(form.getParam("sDate"));			//기간FROM 
			String eDate 		= String2.nvl(form.getParam("eDate"));			//기간TO */
			
			
			String strStrcd = String2.nvl(form.getParam("strcd"));
			String strVencd = String2.nvl(form.getParam("vencd"));
			String strPumbuncd = String2.nvl(form.getParam("pumbunCd"));
			String strCustName = String2.nvl(form.getParam("custname"));
			String strCardNo = String2.nvl(form.getParam("cardno"));
			String sDate = String2.nvl(form.getParam("em_S_Date"));
			String eDate = String2.nvl(form.getParam("em_E_Date"));
			String strSale_S = String2.nvl(form.getParam("strSale_S"));
			String strSale_E = String2.nvl(form.getParam("strSale_E"));
//			String strBirth_S = String2.nvl(form.getParam("strBirth_S"));
//			String strBirth_E = String2.nvl(form.getParam("strBirth_E"));
			String strHomeAddr1 = String2.nvl(form.getParam("strHomeAddr1"));
			String strAge = String2.nvl(form.getParam("strAge"));
			String sexcd = String2.nvl(form.getParam("sexcd"));
			String strPummokcd = String2.nvl(form.getParam("pummokcd"));
			
			dao = new Esal112DAO();
			rt = dao.getExcel(form);
			
			
			if (rt.size() < 1) {
				/*
				sb.append("<script> ");
				sb.append("alert('조회된 내역이 없습니다.');");
				sb.append("</script>");
				 */
			} else {
				sb.append("<%@ page language=\"java\" contentType=\"text/html;charset=utf-8\"%>");
				sb.append("<html>");
				sb.append("<head>");
				sb.append("<title></title>");
				sb.append("<body>");
				sb.append("    <table border=1 width='1150'>");
				sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
				sb.append("            <td colspan=12 align='center'><H3>보너스카드회원매출조회</H3></td> ");
				sb.append("        </tr> ");
				sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
				sb.append("            <td colspan=12 align='left'>*점코드 : "+strStrcd+" |  *협력사코드 : "+strVencd+" |  *품번코드 : "+strPumbuncd+" |  *기간FROM : "+sDate+" |  *기간TO : "+eDate+" |  *저장일자 : "+nowTime+" </td> ");
				sb.append("        </tr> ");
				sb.append("        <tr style='color:black; font-weight:bold;'>");
				sb.append("            <td width='40'>NO</td>");
				sb.append("            <td width='100'>매출일자</td>");
				sb.append("            <td width='80'>회원명</td>");
				sb.append("            <td width='80'>회원ID</td>");
				sb.append("            <td width='80'>나이</td>");
				sb.append("            <td width='120'>카드번호</td>");
				sb.append("            <td width='70'>회원매출</td>");
				sb.append("            <td width='160'>회원지역</td>");
				sb.append("            <td width='70'>회원성별</td>");
				sb.append("            <td width='80'>품목코드</td>");
				sb.append("            <td width='160'>품목명</td>");
				sb.append("            <td width='80'>품목수량</td>");
				sb.append("        </tr> ");
				List colRt = null;
				
				int SaleQty = 0;
				int SaleAmt = 0;
				int DCAmt 	= 0;
				int SaleSAmt= 0;
				for (int i=0; i<rt.size(); i++) {
					sb.append("        <tr>");
					colRt = (List) rt.get(i);
					sb.append("            <td>"+(i+1)+"</td>");
					for (int r=0; r<colRt.size(); r++) {
						if (r != 4) {
							sb.append("            <td>"+colRt.get(r)+"</td>");
						} else {
							sb.append("            <td style='mso-number-format:\\@'>"+colRt.get(r)+"</td>");
						}
					}
					//합계계산
					SaleQty += Integer.parseInt((String) colRt.get(10));	//매출수량
					SaleAmt += Integer.parseInt((String) colRt.get(5));	//총매출
		//			DCAmt 	+= Integer.parseInt((String) colRt.get(7));	//할인
		//			SaleSAmt+= Integer.parseInt((String) colRt.get(8));	//매출
					sb.append("        </tr> ");
				}
				sb.append("        <tr bgcolor=#b9d9ea> ");
				sb.append("            <td colspan='8' align='center' >합계</td>");
				sb.append("            <td>"+SaleQty+"</td>");
				sb.append("            <td>"+SaleAmt+"</td>");
		//		sb.append("            <td>"+DCAmt+"</td>");
		//		sb.append("            <td>"+SaleSAmt+"</td>");
				sb.append("            <td>"+"</td>");
				sb.append("            <td>"+"</td>");
				sb.append("        </tr> ");
				sb.append("    </table> ");
				sb.append("</body> ");
				sb.append("</html>");
			}
			//response.getWriter().println(sb.toString());
			response.getWriter().println(new String(sb.toString().getBytes(), "iso-8859-1"));
		}catch(Exception e){
			e.printStackTrace();
		}
		return mapping.findForward("excelDowns");
	}
	
	
}
