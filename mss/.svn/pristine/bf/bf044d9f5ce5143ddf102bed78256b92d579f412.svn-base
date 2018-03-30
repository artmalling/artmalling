<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 약속관리 > 약속관리 > 약속변경이력조회
 * 작 성 일 : 2011.03.08
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : mpro1030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 고객약속에 관한 변경이력을 조회한다
 * 이    력 :
 *        2011.03.08 (오형규) 신규작성
          2011.03.08 (오형규) 프로그램작성
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--


/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');//마스터
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');//상세보기
        
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세

    // EMedit에 초기화
    initEmEdit(EM_SALE_S_DT, "SYYYYMMDD",  NORMAL);  //기간 시작일(조회)
    initEmEdit(EM_SALE_E_DT, "TODAY",  NORMAL);  //기간 종료일(조회)    
    initEmEdit(EM_CUST_NM, "GEN^40", NORMAL);       //고객명
    initEmEdit(EM_PUMBEN_CD, "NUMBER3^6^0", NORMAL);     //브랜드
    initEmEdit(EM_PUMBEN_NM, "GEN", READ);       //브랜드명
    //콤보 초기화 
    initComboStyle(LC_O_STRCD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)
    initComboStyle(LC_O_SCH_FLAG,DS_O_SCH_FLAG, "CODE^0^30,NAME^0^80", 1, PK);  //조회구분(조회)
    initComboStyle(LC_O_PROM_TYPE,DS_PROM_TYPE, "CODE^0^30,NAME^0^80", 1, NORMAL);  //약속유형(조회)
    
    getStore("DS_O_STR_CD", "Y", "1", "N");;             //점코드       
    getEtcCode("DS_O_SCH_FLAG", "D", "M061", "N");         //조회구분
    getEtcCode("DS_PROM_TYPE",  "D", "M021", "Y");//약속유형    
    
    LC_O_STRCD.Index = 0;
    LC_O_SCH_FLAG.Index = 0;
    LC_O_PROM_TYPE.Index = 0;
    
    LC_O_STRCD.Focus();

    
    registerUsingDataset("mpro103","DS_O_MASTER, DS_O_DETAIL");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FC>id=STRCD       name="점"         width=80   align=left</FC>'                     
                     + '<FC>id=TAKE_DT     name="접수일자"   width=100  align=center MASK="XXXX/XX/XX" </FC>'
                     + '<FC>id=TAKE_SEQ    name="SEQ "       width=70   align=center</FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}


function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     name="NO"              width=30   align=center</FC>'
                     + '<FC>id=MOD_LIST     name="변경항목"        width=80   align=left</FC>'
                     + '<FC>id=ORG_PROM     name="이전약속"         width=90  align=left  </FC>'
                     + '<FC>id=MOD_PROM     name="변경약속"         width=90  align=left  </FC>'
                     + '<FC>id=MOD_REASON   name="변경사유"        width=80   align=left</FC>'
                     + '<FC>id=MOD_TAKE_DT  name="변경접수일자"    width=90  align=center MASK="XXXX/XX/XX" </FC>'
                     + '<FC>id=SEQ_NO       name="변경순번"        width=100  align=center SHOW=FLASE  </FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
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
 * 작 성 일 : 2011-03-08
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
	if( !validationCheck() ) return; 
	
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
 
function validationCheck(){
	
	if( LC_O_STRCD.Text.length == 0 ){
		showMessage(STOPSIGN, OK, "USER-1001", "점");
		LC_O_STRCD.Focus();
		return false;
	}
	if( LC_O_SCH_FLAG.Text.length == 0 ){
		showMessage(STOPSIGN, OK, "USER-1001", "조회구분");
		LC_O_SCH_FLAG.Focus();
        return false;
	}
	if( EM_SALE_S_DT.Text.length == 0 ){
		showMessage(STOPSIGN, OK, "USER-1001", "기간 시작일");
		EM_SALE_S_DT.Focus();
        return false;
	}
	if( EM_SALE_E_DT.Text.length == 0 ){
        showMessage(STOPSIGN, OK, "USER-1001", "기간 종료일");
        EM_SALE_E_DT.Focus();
        return false;
    }
	
	var sdate = (trim(EM_SALE_S_DT.Text)).replace(' ','');
	var edate = (trim(EM_SALE_E_DT.Text)).replace(' ','');
	
	if( sdate > edate ){
		showMessage(STOPSIGN, OK, "USER-1015");
		EM_SALE_S_DT.Focus();
        return false;
	}
	
	return true;
}

function getSearch(){
	
	var strCd = LC_O_STRCD.BindColVal;
	var strSchFlag = LC_O_SCH_FLAG.BindColVal;
	var sDate = EM_SALE_S_DT.Text;
	var eDate = EM_SALE_E_DT.Text;
	var cust = EM_CUST_NM.Text;
	var bumben = EM_PUMBEN_CD.Text;
	var promType = LC_O_PROM_TYPE.BindColVal;
	
	var goTo = "getMaster";
	var parameters = "&strCd="    + encodeURIComponent(strCd)
                  + "&strSchFlag="+ encodeURIComponent(strSchFlag)
                  + "&sDate="     + encodeURIComponent(sDate)
                  + "&eDate="     + encodeURIComponent(eDate)                
                  + "&bumben="    + encodeURIComponent(bumben)
                  + "&promType="  + encodeURIComponent(promType);	
	
	TR_MAIN.Action = "/mss/mpro103.mp?goTo=" + goTo + parameters + "&cust="+encodeURIComponent(cust);
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";//조회:O 입력:I
    TR_MAIN.Post();
	
    if( DS_O_MASTER.CountRow < 1 ){
    	DS_O_MASTER.ClearData();
    	DS_O_DETAIL.ClearData();    	    	
    }
    setPorcCount("SELECT", GD_MASTER);
    
    row = DS_O_MASTER.RowPosition;
    
   // getDetail(row);
}

function getDetail(row){
		
	var strCd = DS_O_MASTER.NameValue(row, "STR_CD");
	var takeDt = DS_O_MASTER.NameValue(row, "TAKE_DT");
	var takeSeq = DS_O_MASTER.NameValue(row, "TAKE_SEQ");
		
	var goTo = "getDetail";
	TR_S_MAIN.Action = "/mss/mpro103.mp?goTo=" + goTo + "&strCd=" + encodeURIComponent(strCd) + "&takeDt=" + encodeURIComponent(takeDt) + "&takeSeq=" + encodeURIComponent(takeSeq); 
	TR_S_MAIN.KeyValue = "SERVLET(O:DS_O_DETAIL=DS_O_DETAIL)";//조회:O 입력:I
	TR_S_MAIN.Post();
	
	if( DS_O_DETAIL.CountRow < 1 ){
		DS_O_DETAIL.ClearData();
		
	}
    
    setPorcCount("SELECT", DS_O_DETAIL.CountRow);
}

/**
 * btn_Excel()
 * 작 성 자 : oh hyeong gyu
 * 작 성 일 : 2011-03-31
 * 개    요 : 숫자 체크 , 숫자 입력 불가
 * return값 : true / false
 */ 
function onlyChar(event){
    if((event.keyCode > 48 ) && (event.keyCode < 57)){
        event.returnValue=false;
    }
}

 /**
  * openPop()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011-04-12
  * 개    요 : 브랜드 팝업 오픈
  * return값 : void
  */
function openPop(strFlag, strGbn){
      
      if(strFlag == "S"){
          var objCd = EM_PUMBEN_CD;
          var objNm = EM_PUMBEN_NM;
          var objStr = LC_O_STRCD;
      }else if(strFlag == "I"){
         var objCd = EM_PUMBUN_CD;
         var objNm = EM_PUMBUN_NM;
         var objStr = LC_O_STRCD;  
      }
      
      if(strGbn == "N" && objCd.Text.length > 0){
    	  
          setStrPbnNmWithoutPop("DS_O_RESULT", objCd, objNm, "Y", "1", "",objStr.BindColVal);
          
      }else{
          strPbnPop( objCd, objNm, "N", "", objStr.BindColVal);       
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_S_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_S_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_S_MAIN.ErrorMsg);
    for(i=1;i<TR_S_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_S_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=EM_PUMBEN_CD event=onKillFocus()>
	//변경된 내역이 없으면 무시
	if(!this.Modified)
	    return;
	//코드가 존재 하지 않으면 명을 클리어 후 리턴
	if( EM_PUMBEN_CD.Text ==""){
		EM_PUMBEN_NM.Text = "";
	       return;
	   }
    if(EM_PUMBEN_CD.text!=null){
        if(EM_PUMBEN_CD.text.length > 0){
            openPop("S", "N");
        }
    }
</script>


<script language=JavaScript for=LC_O_STRCD event=OnSelChange()>
    EM_PUMBEN_CD.Text = "";
    EM_PUMBEN_NM.Text = "";
</script>


<script language=JavaScript for=EM_SALE_S_DT event=onKillFocus()>
    //[조회용]시작일 체크
   
    checkDateTypeYMD( EM_SALE_S_DT );

</script>

<script language=JavaScript for=EM_SALE_E_DT event=onKillFocus()>
    //[조회용]종료일 체크
    checkDateTypeYMD( EM_SALE_E_DT );
</script>

<!-- 변경이력 조회 -->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	
	if( DS_O_MASTER.CountRow > 0 ){
	    getDetail(row);
	}
	
</script>

<!-- GD_MASTER 소팅 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);   
</script>

<!-- GD_DETAIL 소팅 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);   
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
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- LOAD용 -->
<comment id="_NSID_"><object id="DS_O_SCH_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PROM_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
              <th width="80" class="POINT">점</th>
                  <td width="140">
                      <comment id="_NSID_" >
                          <object id=LC_O_STRCD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                          </object>
                      </comment><script>_ws_(_NSID_);</script>
                  </td>
	          <th width="80" class="POINT">조회구분</th>
	              <td width="140">
	                 <comment id="_NSID_">
	                     <object id=LC_O_SCH_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
	                     </object>
	                 </comment><script>_ws_(_NSID_);</script>
	             </td>
	          <th width="80" class="POINT">기간</th>
	             <td>
	                 <comment id="_NSID_">
	                     <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
	                     </object>
	                 </comment>
	                 <script> _ws_(_NSID_);</script>
	                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_S_DT);" align="absmiddle"/>
	                 ~
	                 <comment id="_NSID_">
	                     <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=70 tabindex=1 align="absmiddle">
	                     </object>
	                 </comment>
	                 <script> _ws_(_NSID_);</script>
	                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_E_DT);" align="absmiddle"/>
	             </td>
          </tr>
          <tr>
            <th width="100">고객명</th>
                <td width="140">
                          <comment id="_NSID_">
                              <object id=EM_CUST_NM classid=<%=Util.CLSID_EMEDIT%>  width=140 tabindex=1 
                              onkeydown="javascript:onlyChar(event);"
                              onkeypress="javascript:onlyChar(event);"
                              onkeyup="javascript:onlyChar(event);"
                              align="absmiddle">
                              </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                
                </td>
                <th width="70">약속유형</th>
               <td width="140">
                 <comment id="_NSID_">
                     <object id=LC_O_PROM_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                     </object>
                 </comment><script>_ws_(_NSID_);</script>
               </td>
            <th width="70">브랜드</th>
                <td>
                 <comment id="_NSID_">
                     <object id=EM_PUMBEN_CD classid=<%=Util.CLSID_EMEDIT%>  width="70" tabindex=1 align="absmiddle">
                     </object>
                     <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  onclick="javascript:openPop('S')" class="PR03" onclick="" align="absmiddle"/>
                     <object id=EM_PUMBEN_NM classid=<%=Util.CLSID_EMEDIT%>  width="100" tabindex=1 align="absmiddle">
                     </object>
                 </comment>
                 <script> _ws_(_NSID_);</script>                 
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
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="300"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <OBJECT id=GD_MASTER width=100% height=480 classid=<%=Util.CLSID_GRID%> tabindex=1 >
                  <param name="DataID" value="DS_O_MASTER">
                </OBJECT>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        <td class="PL10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">              
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                  <tr>
                    <td>
                      <comment id="_NSID_">
                        <OBJECT id=GD_DETAIL width=100% height=480 classid=<%=Util.CLSID_GRID%> tabindex=1 >
                          <param name="DataID" value="DS_O_DETAIL">
                        </OBJECT>
                      </comment>
                      <script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
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

