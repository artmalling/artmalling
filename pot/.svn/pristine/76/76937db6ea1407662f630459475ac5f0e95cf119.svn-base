<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 권한관리
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom1041.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 그룹별 프로그램 사용권한(TAB2) 그룹그리드 더블클릭시 -> 팝업
 * 이    력 :
  ********************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>권한-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script> 

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************--> 
<script LANGUAGE="JavaScript">
/**
 * doInit()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-15
 * 개    요 : initialize
 * return값 : void
 */
function doInit() 
{   

	 // 헤더초기화
    DS_O_USRMST_POP.setDataHeader ('<gauce:dataset name="H_USRMST"/>'); 
    
	 // Grid초기화
    var hdrProperies  = '<FC>id={currow}    width=30     align=center    name="NO"       </FC>'
                      + '<FC>id=USER_ID     width=70     align=left      name="사원번호"  </FC>'
                      + '<FC>id=USER_NAME   width=85     align=left      name="성명"      </FC>'
                      + '<FC>id=ORG_NAME    width=99     align=left      name="조직구분"  </FC>' 
                      + '<FC>id=STR_NAME    width=100    align=left      name="점"        </FC>' 
                      + '<FC>id=DEPT_NAME   width=110    align=left      name="팀"      </FC>' 
                      + '<FC>id=TEAM_NAME   width=110    align=left      name="파트"        </FC>' 
                      + '<FC>id=PC_NAME     width=120    align=left      name="PC"        </FC>' ;   
        
    initGridStyle(GD_USRMST, "common", hdrProperies, false); 
    showUsrmst( dialogArguments );
    
}  

/**
* showUsrmst()
* 작 성 자 : ckj
* 작 성 일 : 2006-08-08
* 개    요 : GRID 표현하기 
* return값 : void
*/
function showUsrmst( groupCd ) 
{ 
    var goTo       = "selUsrmst" ;    
    var action     = "O";     
    var parameters = "&strGroupCd="  +encodeURIComponent(groupCd)  ;
     
    TR_MAIN.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_USRMST_POP=DS_O_USRMST_POP)"; //조회는 O
    TR_MAIN.Post();
    
    
}

function btn_Close()
{
	this.close();
}
</script>
</head>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************--> 
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
 
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_USRMST event=OnClick(row,colid)> 
    if( row < 1)  sortColId( eval(this.DataID), row , colid );  
</script>
<!--------------------- 1. 가우스DataSet  -------------------------------------> 
<comment id="_NSID_"><object id="DS_O_USRMST_POP"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  ---------------------------------------> 
<comment id="_NSID_"><object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>> <param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->

<body  onLoad="doInit();"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">그룹별 사용자정보</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/close.gif"  width="50" height="22"   onClick="btn_Close();"/></td>
                
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      
      <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">      
        <tr>
        <td>
            <comment id="_NSID_">
                <object id=GD_USRMST classid=<%=Util.CLSID_GRID%> height=393 width=100% >
                    <param name=DataID      value="DS_O_USRMST_POP">
                </object>
            </comment><script>_ws_(_NSID_);</script>
            </td>
            </tr>
        </table></td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table> 
</body>

</html>
