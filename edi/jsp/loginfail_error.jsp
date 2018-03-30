<%
/*******************************************************************************
 * 시스템명 : 아트몰링 협력사 EDI
 * 작 성 일 : 2011.04.01
 * 작 성 자 : 정지인
 * 수 정 자 :
 * 파 일 명 : loginfail_error.jsp
 * 버    전 : 1.0
 * 개    요 : 로그인 에러 화면
 * 이    력 : 
 *****************************************************************************/
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="ecom.util.Util" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<%@ page import="java.util.*" %>



<HTML>
<ajax:library />
<HEAD>
<TITLE>아트몰링 EDI시스템 </TITLE>
<link rel="stylesheet" href="/edi/css/ds.css" type="text/css"> 
<meta http-equiv="pragma" content="no-cache">
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>
<script language="javascript">


</script>
</HEAD>

<BODY  class="PT50" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>

<table border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td class="PT50" >
</td>
</tr>
  <tr>
    <td><img src="/edi/imgs/login/login_01.gif" width="25" height="378" /></td>
    <td><img src="/edi/imgs/login/login_02.gif" width="301" height="378" /></td>
    <td width="350"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  class="center"><img src="/edi/imgs/login/login_04.gif" width="190" height="75" /></td>
      </tr>
      <tr>
        <td><p>&nbsp;</p></td>
      </tr>
      <tr>
        <td>
        <table width="260" border="0" align="center" cellpadding="0" cellspacing="0" >
           <tr><td align="center"><font color="#FD7D00" class="smallfont" size="3">아이디 오류입니다.</font></td></tr>
           <td><p>&nbsp;</p></td>
           <tr>
              <td><font size="2">현재 입력하신 아이디, 비밀번호가 
                <b>EDI협력사</b>에 등록되어 있지 않거나 아이디 또는 비밀번호를 잘못 입력 하셨습니다.</font></td>
            </tr>
        </table>
        </td>
      </tr>
    </table></td>
    <td><img src="/edi/imgs/login/login_03.gif" width="8" height="378" /></td>
  </tr>
  <tr>
    <td align="center" colspan="3">
            <a href="#"  onclick="window.open('/edi/jsp/login.jsp','win','width=1024-55,height=769-10,resizable=1,scrollbars=1, statusbar=1, toolbar=1, directories=1, menubar=1, location=1'); self.close();"><img src="/edi/imgs/btn/confirm.gif" /></a>
                  <!--  <a href="#"  onclick="javascript:backlogin();;">확인</a> -->
    </td>
  </tr>
</table>
</form>

</BODY>
</HTML>
