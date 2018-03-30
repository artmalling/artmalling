<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> POS공지사항관리
 * 작 성 일 : 2010.05.02
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS공지사항을 관리한다
 * 이    력 :
 *        2010.05.02 (정진영) 신규작성
 ******************************************************************************/
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
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_REG_DT_FROM   , "YYYYMMDD",  PK);      //등록기간 FROM
    initEmEdit(EM_REG_DT_TO     , "YYYYMMDD",  PK);      //등록기간 TO
    initEmEdit(EM_NOTI_S_DT     , "YYYYMMDD",  NORMAL);  //공지시작일
    initEmEdit(EM_NOTI_E_DT     , "YYYYMMDD",  NORMAL);  //공지종료일
    initEmEdit(EM_NOTI_TITLE    , "GEN^30"  ,  NORMAL);  //제목

    //콤보 초기화 
    initComboStyle(LC_STR_CD       , DS_STR_CD       , "CODE^0^30,NAME^0^140" , 1, NORMAL);  //점(조회)

    // 점코드 조회
    getStore("DS_STR_CD"  , "N", "1", "Y");
    
    
    // 전점 추가(gauce.js )
    insComboData(LC_STR_CD,"**","전점");    //콤보데이터 기본값 설정( gauce.js )
    /*
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    */
    setComboData(LC_STR_CD,'%');
    var toDay =  getTodayFormat("YYYYMMDD");

    EM_REG_DT_FROM.Text = getTodayFormat("YYYYMM") + '01';
    EM_REG_DT_TO.Text = toDay;
    // 삭제된 로우 표시여부
    //DS_MASTER.ViewDeletedRow = true;


    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod807","DS_MASTER" );
    
    EM_REG_DT_FROM.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       width=30   align=center edit=none     name="NO"            </FC>'
                     //+ '<FC>id=SEL            width=50   align=center               name="삭제"          EditStyle=CheckBox  HeadCheckShow=true edit={IF(NOTI_S_DT>"'+ getTodayFormat("YYYYMMDD")+'","true","false")}</FC>'
                     + '<FC>id=SEL            width=50   align=center               name="삭제"          EditStyle=CheckBox  HeadCheckShow=true edit=true</FC>'
                     + '<FC>id=STR_CD         width=90   align=left   edit=none     name="점"            EditStyle=Lookup data="DS_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=NOTI_NO        width=70   align=center edit=none     name="공지번호"       </FC>'
                     + '<FC>id=NOTI_TITLE     width=318  align=left   edit=none     name="제목 "          fontStyle=under Color=blue </FC>'
                     + '<FC>id=NOTI_S_DT      width=75   align=center edit=none     name="공지시작일"     mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=NOTI_E_DT      width=75   align=center edit=none     name="공지종료일"     mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=REG_DT         width=75   align=center edit=none     name="등록일"         mask="XXXX/XX/XX" </FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//
    if( EM_REG_DT_FROM.Text == ""){
        // (등록기간)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "등록기간(FORM)");
        EM_REG_DT_FROM.Focus();
        return;
    }
    if( !checkDateTypeYMD(EM_REG_DT_FROM,addDate('M',-1,getTodayFormat('YYYYMMDD'))))
        return;
    if( EM_REG_DT_TO.Text == ""){
        // (등록기간)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "등록기간(TO)");
        EM_REG_DT_TO.Focus();
        return;
    }
    if( !checkDateTypeYMD(EM_REG_DT_TO))
        return;
    if( EM_REG_DT_FROM.Text > EM_REG_DT_TO.Text){
        showMessage(EXCLAMATION, OK, "USER-1020", "등록기간(TO)","등록기간(FORM)");
        EM_REG_DT_TO.Focus();
        return;
    }

    if( EM_NOTI_S_DT.Text != ""|| EM_NOTI_E_DT.Text != ""){

        if( EM_NOTI_S_DT.Text == ""){
            // (공지기간)은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003", "공지기간(FORM)");
            EM_NOTI_S_DT.Focus();
            return;
        }
        if( !checkDateTypeYMD(EM_NOTI_S_DT,""))
            return;
        if( EM_NOTI_E_DT.Text == ""){
            // (공지기간)은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003", "공지기간(TO)");
            EM_NOTI_E_DT.Focus();
            return;
        }
        if( !checkDateTypeYMD(EM_NOTI_E_DT,""))
            return;
        if( EM_NOTI_S_DT.Text > EM_NOTI_E_DT.Text){
            showMessage(EXCLAMATION, OK, "USER-1020", "공지기간(TO)","공지기간(FORM)");
            EM_NOTI_E_DT.Focus();
            return;
        }
    }
    searchMaster();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	//
    if(checkDelYn()){
        showMessage(INFORMATION, OK, "USER-1000", "삭제 선택 해제 후 신규추가 하세요.");
        GD_MASTER.Focus();
        return;     
    }
    showDetail();
	
}
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-04-04
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
     
    if( !checkDelYn()){
        showMessage(INFORMATION, OK, "USER-1019");
        if(DS_MASTER.CountRow < 1)
            EM_REG_DT_FROM.Focus();
        else
            GD_MASTER.Focus();
        
        return;
    }
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','04','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
    
    //선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        GD_MASTER.Focus();
        return;
    }
    
    for( var i=1; i<=DS_MASTER.CountRow; i++){
        if(DS_MASTER.NameValue(i,"SEL")=="T"){
            DS_MASTER.RowMark(i) = 1;
        }else{
            DS_MASTER.RowMark(i) = 0;           
        }
    }    

    DS_MASTER.DeleteMarked();
    
    TR_MAIN.Action="/dps/pcod807.pc?goTo=delete";
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();       
    }
    GD_MASTER.Focus();
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
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
//
/**
 * checkDelYn()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 삭제 선택 여부
 * return값 : void
**/
function checkDelYn(){
    for( var i=1; i<=DS_MASTER.CountRow; i++){
        if(DS_MASTER.NameValue(i,"SEL")=="T"){
            return true;
        }
    }
    return false;    
}
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  공지사항 리스트 조회
 * return값 : void
 */
function searchMaster(){
    var strCd       = LC_STR_CD.BindColVal;
    var regDtFrom   = EM_REG_DT_FROM.Text;
    var regDtTo     = EM_REG_DT_TO.Text;
    var notiSDt     = EM_NOTI_S_DT.Text;
    var notiEDt     = EM_NOTI_E_DT.Text;
    var notiTitle   = EM_NOTI_TITLE.Text;

    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="	 +encodeURIComponent(strCd)
                   + "&strRegDtFrom="+encodeURIComponent(regDtFrom)
                   + "&strRegDtTo="	 +encodeURIComponent(regDtTo)
                   + "&strNotiSDt="	 +encodeURIComponent(notiSDt)
                   + "&strNotiEDt="	 +encodeURIComponent(notiEDt)
                   + "&strNotiTitle="+encodeURIComponent(notiTitle);
    TR_MAIN.Action="/dps/pcod807.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    

    GD_MASTER.ColumnProp("SEL","HeadCheck") = false; 
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
//
/**
 * showDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  상세 팝업 실행
 * return값 : void
 */
function showDetail(row){
	var mode = "I";
	var posNotiNo = "";
	if( row != null){
        mode = "S";	
        posNotiNo = DS_MASTER.NameValue(row,"NOTI_NO");
	}

    var arrArg  = new Array();
    
    arrArg.push(mode);
    arrArg.push(posNotiNo);
    
    var returnVal = window.showModalDialog("/dps/pcod807.pc?goTo=detail",
                                           arrArg,
                                           "dialogWidth:360px;dialogHeight:409px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

    
    if (returnVal){
    	searchMaster();
    }
    if(DS_MASTER.CountRow < 1){
    	EM_REG_DT_FROM.Focus();
    }else{
    	if(posNotiNo==""){
    		DS_MASTER.RowPosition = DS_MASTER.CountRow;
    	}else{
    		DS_MASTER.RowPosition = DS_MASTER.NameValueRow("NOTI_NO",posNotiNo);
    	}
    	GD_MASTER.Focus();
    }
}
/**
 * setCalData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  달력 팝업 실행
 * return값 : void
 */
function setCalData( evnFlag, gubnFlag, obj){

    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    var dfDt = "";
    var toDay = getTodayFormat("YYYYMMDD");
    switch(gubnFlag){
        case 'RF':
        	dfDt = getTodayFormat("YYYYMM") + '01';;
    	    break;
        case 'RT':
        	dfDt = toDay;
            break;
    }  
    
    if(!checkDateTypeYMD( obj , dfDt))
        return;
    
}

/**
 * clickGridHeadCheck()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 그리드 헤더 클릭시 모든 로우 반영
 * return값 :
 */
function clickGridHeadCheck( dataSet, value){
    for( var i=1; i<=dataSet.CountRow; i++){
    	if( dataSet.NameValue(i,"NOTI_S_DT") > getTodayFormat("YYYYMMDD"))
    		dataSet.NameValue(i,"SEL") = value==1?"T":"F";
    	else
            dataSet.NameValue(i,"SEL") = "F";
    }
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
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_MASTER,bCheck);
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    if( row < 1) return;
    if( colid == "NOTI_TITLE"){
    	showDetail(row);
    }
</script>
<!-- 등록기간(from)(조회) -->
<script language=JavaScript for=EM_REG_DT_FROM event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME','RF', EM_REG_DT_FROM);
</script>
<!-- 등록기간(to)(조회) -->
<script language=JavaScript for=EM_REG_DT_TO event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME','RT', EM_REG_DT_TO);
</script>
<!-- 공지기간(from)(조회) -->
<script language=JavaScript for=EM_NOTI_S_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME','NS', EM_NOTI_S_DT);
</script>
<!-- 공지기간(to)(조회) -->
<script language=JavaScript for=EM_NOTI_E_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME','NE', EM_NOTI_E_DT);
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60" class="point">등록기간</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_REG_DT_FROM classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:setCalData('POP', 'RF', EM_REG_DT_FROM);"  align="absmiddle" />~
              <comment id="_NSID_">
                <object id=EM_REG_DT_TO classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:setCalData('POP', 'RT', EM_REG_DT_TO);"  align="absmiddle" />
            </td>
            <th width="80">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">제목</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_NOTI_TITLE classid=<%=Util.CLSID_EMEDIT%>  width=160  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >공지기간</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_NOTI_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:setCalData('POP', 'NS', EM_NOTI_S_DT);"  align="absmiddle" />~
              <comment id="_NSID_">
                <object id=EM_NOTI_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif"   onclick="javascript:setCalData('POP', 'NE', EM_NOTI_E_DT);"  align="absmiddle" />
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
        <td>
          <comment id="_NSID_">
            <object id=GD_MASTER width=100% height=479 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_MASTER">
            </object>
          </comment><script>_ws_(_NSID_);</script>
        </td>
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

