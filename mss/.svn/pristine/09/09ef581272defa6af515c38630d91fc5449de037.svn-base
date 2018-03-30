<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 협력사EDI > EDI커뮤니티 
 * 작 성 일 : 2011.03.22
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : medi1030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사의 질문에 대한 내역을 조회 , 답변을 등록
 * 이    력 :
 *        
          2011.03.22 오형규(프로그램 작성) 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
    String userid = sessionInfo.getUSER_ID();
    String dir = BaseProperty.get("context.common.dir");

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var userid = '<%=userid%>';         //사용자아이디
var strBuyercd;                     //바이어코드
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');//조직
    DS_O_BYBER.setDataHeader('<gauce:dataset name="H_BUYERCD"/>');//조직
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_O_S_DATE, "SYYYYMMDD", PK);          //기간 시작일
    initEmEdit(EM_O_E_DATE, "TODAY", PK);          //기간 종료일
    initEmEdit(EM_O_TITLE,  "GEN", NORMAL);          //제목
    initEmEdit(EM_O_READ_CNT, "NUMBER3^3", NORMAL);          //조회건수
    
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);      //점(조회)
    
    getStore("DS_O_STR_CD", "Y", "1", "Y");             //점코드   
    
    getBuyer_id();                                     //바이어코드
    
    LC_O_STR_CD.Index = 0;
    LC_O_STR_CD.Focus();
    EM_O_READ_CNT.Text = "100";
    
    
    registerUsingDataset("medi103","DS_O_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}          name="NO"            width=50   align=center </FC>'
    	             + '<FC>id=STR_CD            name="점"            width=80     align=left SHOW=FALSE </FC>'
    	             + '<FC>id=STRNM            name="점"            width=80     align=left </FC>'
                     + '<FC>id=SEQ_NO            name="순번"          width=60     align=center </FC>'
                     + '<FC>id=TITLE            name="질문제목"           width=183  FontStyle="Under"  Pointer="hand" align=left </FC>'
                     + '<FC>id=ORG_NAME          name="브랜드조직정보"   width=165     align=left </FC>'
                     + '<FC>id=PUMBUN_NAME       name="등록자"         width=90     align=left </FC>'
                     + '<FC>id=REG_DT            name="일자"           width=80     align=center MASK="XXXX/XX/XX"  </FC>'
                     + '<FC>id=TIMES             name="시간"           width=70   align=center MASK="XX:XX:XX" </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-09
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
     var sDate = (trim(EM_O_S_DATE.Text)).replace(' ','');
     var eDate = (trim(EM_O_E_DATE.Text)).replace(' ','');
	 
     if( LC_O_STR_CD.Text == "" ){
         showMessage(INFORMATION, OK, "USER-1001", "점");
         LC_O_STR_CD.Focus();
         return;
     }
     
     if( sDate == "" ){
    	 showMessage(INFORMATION, OK, "USER-1001", "시작일");
    	 EM_O_S_DATE.Focus();
         return;
     }
     if( eDate == "" ){
    	 showMessage(INFORMATION, OK, "USER-1001", "종료일");
    	 EM_O_E_DATE.Focus();
         return;
     }
     
     if( sDate > eDate ){
         showMessage(STOPSIGN, OK, "USER-1015");
         EM_O_S_DATE.Focus();
         return;
     }     
     
     getSearch();
     
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-09
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
     
         
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * getSearch()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011-03-22
  * 개    요 : master 조회
  * return값 : void
  */
  
function getSearch(){
    
	var strcd = LC_O_STR_CD.BindColVal;
	var sDate = EM_O_S_DATE.Text;
	var eDate = EM_O_E_DATE.Text;
	var strTitle = EM_O_TITLE.Text;
	var strReadCnt = EM_O_READ_CNT.Text;
   
    
    var goTo = "getMaster"
    var paraments = "&sDate="      + encodeURIComponent(sDate)
                  + "&eDate="      + encodeURIComponent(eDate)
                  + "&strBuyercd=" + encodeURIComponent(strBuyercd)
                  + "&userid="     + encodeURIComponent(userid)
                  + "&strCd="      + encodeURIComponent(strcd);    
    
    TR_MAIN.Action = "/mss/medi103.md?goTo=" + goTo + paraments + "&strTitle="+encodeURIComponent(strTitle)+"&strReadCnt="+encodeURIComponent(strReadCnt);
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";//조회:O 입력:I
    TR_MAIN.Post();
    
    setPorcCount("SELECT", GD_MASTER);
    
}

/**
 * getSearch()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-22
 * 개    요 : 바이어코드 
 * return값 : void
 */
 
 
function getBuyer_id(){
    
    if( userid != null || userid != "" ){
        var goTo = "getBuyerCd";
                
        TR_MAIN.Action = "/mss/medi103.md?goTo="+goTo+"&userid="+encodeURIComponent(userid);
        TR_MAIN.KeyValue="SERVLET(O:DS_O_BYBER=DS_O_BYBER)"; //조회는 O
        TR_MAIN.Post();
                
        strBuyercd = DS_O_BYBER.NameValue(0, "BUYER_CD");
        
    }
}
 
function QnaDetailPopup(row){
	
	var strSeq_no = DS_O_MASTER.NameValue(row, "SEQ_NO");
	var strReg_dt = DS_O_MASTER.NameValue(row, "REG_DT");	
	var strcd     = DS_O_MASTER.NameValue(row, "STR_CD");
	
	var arrArg  = new Array();

	arrArg.push(strSeq_no);
	arrArg.push(strReg_dt);
	arrArg.push(strBuyercd);
	arrArg.push(strcd);

	var returnVal= window.showModalDialog("/mss/medi103.md?goTo=listDtl",
	        arrArg,
	        "dialogWidth:900px;dialogHeight:477px;scroll:no;" +
	        "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	
	if(returnVal) getSearch();
	
		
}
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
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

<!--  GD_MASTER 소팅 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    
    if( row < 1 ){      
        sortColId( eval(this.DataID), row, colid);   
    }
    
</script>


<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

if(clickSORT) return;

</script>


<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>

  
    if( row < 1 ){
    	return;
    }else {
    	QnaDetailPopup(row);
    }  

</script>



<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=EM_O_S_DATE event=onKillFocus()>
    //[조회용]시작일 체크
    checkDateTypeYMD( EM_O_S_DATE );
</script>

<script language=JavaScript for=EM_O_E_DATE event=onKillFocus()>
    //[조회용]시작일 체크
    checkDateTypeYMD( EM_O_E_DATE );
</script>


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_BYBER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
          <!-- search start -->
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">           
              <tr>
                 <th width="80">점</th>
                <td width="140">
                    <comment id="_NSID_">
                        <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=140 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80" class="POINT">기간</th>
                <td width="200">
                      <comment id="_NSID_">
                          <object id=EM_O_S_DATE classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_O_S_DATE)" align="absmiddle"/>
                      ~
                      <comment id="_NSID_">
                          <object id=EM_O_E_DATE classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_O_E_DATE)" align="absmiddle"/>
                </td>
                <th width="80">조회건수</th>
                <td>
                    <comment id="_NSID_">
                        <object id=EM_O_READ_CNT classid=<%= Util.CLSID_EMEDIT %> tabindex=1 width=135 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
              <tr>
                    <th width="80">제목</th>
	                <td colspan="6">
	                    <comment id="_NSID_">
	                        <object id=EM_O_TITLE classid=<%= Util.CLSID_EMEDIT %> onkeyup="checkByteStr(this, 50, 'Y')" tabindex=1 width=678 align="absmiddle">
	                        </object>
	                    </comment><script>_ws_(_NSID_);</script>
	                </td>                
              </tr>
          </table>
        </td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"  ></td>
  </tr> 
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
          <tr>
            <td width="100%">
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=480 classid=<%=Util.CLSID_GRID%> tabindex=1 >
                <param name="DataID" value="DS_O_MASTER">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

