<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 >  협력사EDI >  협력사EDI 커뮤니티 > 협력사Q&A 상세팝업
 * 작 성 일 : 2011.03.24
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : medi1031.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사의 질문에 대한 내역을 조회 , 답변을 등록
 * 이    력 :
 *        
          2011.03.24 (오형규) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var seq_no = dialogArguments[0];
var reg_dt = dialogArguments[1];
var Buyercd = dialogArguments[2];
var strcd = dialogArguments[3];
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_POPUPDETAIL"/>');//조직    
    // Output Data Set Header 초기화
    
    
    initEmEdit(EM_TITLE,  "GEN", NORMAL);              // 제목
    initEmEdit(EM_I0_REGISTER,  "GEN", NORMAL);        //등록자    
    initTxtAreaEdit(TXT_CONTENT, NORMAL);              //내용
    initTxtAreaEdit(TXT_CONTENT_REPEL, NORMAL);        //답변
    
    EM_TITLE.Enable = "false";
    EM_I0_REGISTER.Enable = "false";
    TXT_CONTENT.Enable = "false";
    getPopUpDatile();
}

/*************************************************************************
  * 2. 버튼    
     (1) 저장       - btn_Save()
     (2) 삭제       - btn_Delete()
     (3) 닫기       - btn_Close()     
 *************************************************************************/



/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * getSearch()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-24
  * 개    요 : 조회처리
  * return값 : void
  */

 
function getPopUpDatile(){
	  
	  
	TR_MAIN.Action = "/mss/medi103.md?goTo=getPopupDetail&seq_no="+ encodeURIComponent(seq_no) + "&reg_dt=" + encodeURIComponent(reg_dt) +"&strcd=" + encodeURIComponent(strcd);
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    EM_TITLE.Text = DS_IO_MASTER.NameValue(1, "TITLE");
    EM_I0_REGISTER.Text = DS_IO_MASTER.NameValue(1, "PUMBUN_NM");
    TXT_CONTENT.Text = DS_IO_MASTER.NameValue(1, "CONTEN");
    TXT_CONTENT_REPEL.Text = DS_IO_MASTER.NameValue(1, "ANS_CONTENT");
}

/**
 * btn_Save()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 저장 / 수정
 * return값 : void
 */
 
function btn_Save(){
	 
	 
	
	 if( DS_IO_MASTER.IsUpdated ){
		    
		 if (showMessage(STOPSIGN, YESNO, "USER-1010") != 1) return;
		 
	     var goTo = "save";
         var contentReple = TXT_CONTENT_REPEL.Text;
        
         TR_MAIN.Action = "/mss/medi103.md?goTo="+ goTo +"&seq_no="+ encodeURIComponent(seq_no) + "&reg_dt=" + encodeURIComponent(reg_dt) 
                        + "&Buyercd=" + encodeURIComponent(Buyercd) + "&strcd=" + encodeURIComponent(strcd);
         TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
         TR_MAIN.Post();
    
         window.returnValue = true;
         window.close();
 
	 }else {
		 showMessage(StopSign, OK, "USER-1028");	        
		 return;
	 }
		    
}

function btn_Close(){
	window.close();
}
 
 



 
 -->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->


<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->

<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== ONLOAD용 -->


<!-- =============== 공통함수용 -->

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝  
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="pop01"></td>
        <td class="pop02" ></td>
        <td class="pop03" ></td>
    </tr>    
    <tr>
        <td class="pop04"></td>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
					        <td class="title">
					            <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>
					            Q&A상세조회/답변등록
					        </td>
					        <td>
					            <table border="0" align="right" cellpadding="0" cellspacing="0">
					              <tr>
					                <td>
					                   <img src="/<%=dir%>/imgs/btn/save.gif" width="50" height="22" onClick="btn_Save();" />                  
					                   <img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22" onClick="btn_Close();" />
					                </td>
					              </tr>
					          </table>
					      </td>
					    </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="5"></td>
            </tr>     
            <tr>
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table">
                    <tr>
                        <th width="80">제목</th>
                        <td width="500">
                            <comment id="_NSID_">
                                <object id=EM_TITLE classid=<%=Util.CLSID_EMEDIT%> width=490 tabindex=1 align="absmiddle">
                                </object> 
                            </comment>
                            <script>_ws_(_NSID_);</script>
                        </td>
                        <th width="80">등록자</th>
                        <td>
                            <comment id="_NSID_">
                                <object id=EM_I0_REGISTER classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1  align="absmiddle"> </object>
                            </comment>
                            <script>_ws_(_NSID_);</script>
                         </td>                        
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td colspan="5"  >
                            <comment id="_NSID_">
                                <object id=TXT_CONTENT classid=<%=Util.CLSID_TEXTAREA%> height=250  onkeyup="checkByteStr(this, 4000, 'Y')" width=760 tabindex=1 > 
                                </object>
                            </comment>
                            <script>_ws_(_NSID_);</script></td>
                    </tr>
                    <tr>
                        <th>답변</th>
                        <td colspan="5" class="P02">
                            <comment id="_NSID_">
                                <object id=TXT_CONTENT_REPEL classid=<%=Util.CLSID_TEXTAREA%> height=130 
                                        onkeyup="javascript:checkByteStr(this, 2000, 'Y');" width=760  tabindex=1 > 
                                </object>
                            </comment>
                            <script>_ws_(_NSID_);</script>
                        </td>
                    </tr>                      
                </table>
                </td>
            </tr>
        </table>
        </td>
        <td class="pop06" ></td>
    </tr>   
     <tr>
        <td class="pop07" ></td>
        <td class="pop08" ></td>
        <td class="pop09" ></td>
    </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_"> <object id=BO_IO_DETAIL
    classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_IO_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=ANS_CONTENT        Ctrl=TXT_CONTENT_REPEL         param=Text</c>                
        '>        
</object> </comment><script>_ws_(_NSID_);</script></div><body>

</body>
</html>

