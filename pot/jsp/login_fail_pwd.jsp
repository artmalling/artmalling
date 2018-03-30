<%
/*******************************************************************************
  * 시스템명 : 형지 아트몰링 통합정보시스템 공통 
  * 작 성 일 : 2010.12.12 
  * 작 성 자 : 정지인
  * 수 정 자 :
  * 파 일 명 : login_fail_pwd.jsp
  * 버    전 : 1.0
  * 개    요 : 로그인패스워드가 틀린 경우 에러 페이지
  * 이    력 : 
  *****************************************************************************/
  %>
  <%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
     common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
  <% request.setCharacterEncoding("utf-8"); %>
  <%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
  <HTML>
  <HEAD>
  <TITLE>형지 아트몰링 통합정보시스템  </TITLE>
  <meta http-equiv="pragma" content="no-cache">
  <!-- 
  self.moveTo(0,0); 
  self.resizeTo(screen.availWidth,screen.availHeight); 
  self.opener = "";
  //-->  
  <link rel="stylesheet" href="/pot/css/mds.css" type="text/css">
  </HEAD>
  <BODY >
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="600"><table width="550" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/pot/imgs/login/login_logo.gif" width="541" height="114" /></td>
        </tr>
         <tr>
          <td class="PT20 "><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="BD2T BD2B PB30 PT30"><table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="54" class="gray PB05"><img src="/pot/imgs/comm/warning.gif" width="54" height="56" /></td>
                  <td class="gray PB05 PL20">비밀번호 오류입니다.<br />
					현재 입력하신 비밀번호가    통합정보시스템에 등록되어 있는
					비밀번호와 일치하지 않습니다.<BR>
					비밀번호는 대소문자를 구분 합니다.</td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td class="PT20 center"><a href="#" onclick="window.open('/pot/jsp/login.jsp','win','width=1024-55,height=769-10,resizable=1,scrollbars=1, statusbar=1, toolbar=1, directories=1, menubar=1, location=1'); self.close();"><IMG SRC="/pot/imgs/btn/confirm.gif" BORDER=0 ALT=""onmouseover="this.src='/pot/imgs/btn/confirm.gif'" onmouseout="this.src='/pot/imgs/btn/confirm.gif'" style="cursor:hand"></a></td>
            </tr>
          </table></td>
        </tr>
    </table></td>
  </tr>
</table>
  </BODY>
  </HTML>
