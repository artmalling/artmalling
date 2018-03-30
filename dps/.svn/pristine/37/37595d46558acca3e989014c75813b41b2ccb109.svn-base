<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> 임대협력사명판관리 - 미리보기
 * 작 성 일 : 2010.04.25
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8041.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 임대 협력사의 POS 명판정보 미리보기
 * 이    력 :
 *        2010.04.25 (정진영) 신규작성
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
<title>POS공지사항관리 (상세)</title>
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
 var mode        = dialogArguments[0];
 var posNotiNo   = dialogArguments[1];

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

    // EMedit에 초기화
    initEmEdit(EM_NOTI_NO     , "CODE^4%^0" ,  PK);      //공지번호
    initEmEdit(EM_NOTI_S_DT   , "YYYYMMDD"  ,  PK);      //공지시작일
    initEmEdit(EM_NOTI_E_DT   , "YYYYMMDD"  ,  PK);      //공지종료일
    initEmEdit(EM_NOTI_TITLE  , "GEN^30"    ,  PK);      //제목
    initEmEdit(EM_BYTE        , "NUMBER^4^0",  NORMAL);      //제목
    
    initTxtAreaEdit(TXT_NOTI_CONTENT, PK);
    
    //콤보 초기화 
    initComboStyle(LC_STR_CD       , DS_STR_CD       , "CODE^0^30,NAME^0^190" , 1, PK);  //점

    // 점코드 조회
    getStore("DS_STR_CD"  , "N", "1", "N");
    
    // 전점 추가(gauce.js )
    insComboData(LC_STR_CD,"**","전점");

    if( mode=='I'){
        DS_MASTER.ClearData();
        DS_MASTER.AddRow();
        DS_MASTER.NameValue(1,"NOTI_S_DT") = addDate('D',1,getTodayFormat("YYYYMMDD"),"");
        DS_MASTER.NameValue(1,"NOTI_E_DT") = addDate('D',1,getTodayFormat("YYYYMMDD"),"");
    }
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    if( mode!='I' && posNotiNo !=null){
    	searchMaster();
    }
    EM_BYTE.ReadOnly = true;
    enableCnt();
    onCheckLength();
    LC_STR_CD.Focus();
}


/*************************************************************************
  * 2. 공통버튼
     (1) 저장       - btn_save()
     (2) 닫기       - btn_Close()
 *************************************************************************/

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_save() {

   if( !DS_MASTER.IsUpdated){
       // 저장할 내용이 없습니다.
       showMessage(INFORMATION, OK, "USER-1028");
       LC_STR_CD.Focus();
	   return;
    }

   //필수 입력체크 
   if(!checkValidation())
       return;

   // 마감체크 (common.js)
   if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','04','0','T') == 'TRUE'){
       showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
       LC_STR_CD.Focus();
       return;
   }

   //변경또는 신규 내용을 저장하시겠습니까?
   if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
	   LC_STR_CD.Focus();
       return;
   }

   TR_MAIN.Action="/dps/pcod807.pc?goTo=save";  
   TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; 
   TR_MAIN.Post();

   // 정상 처리일 경우 조회
   if( TR_MAIN.ErrorCode == 0){
	    window.returnValue = true;
	    window.close();      
   }else{
	   LC_STR_CD.Focus();	   
   }
}

/**
 * btn_Close()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 화면 종료
 * return값 : void
 */
function btn_Close() {
    if( DS_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1000","변경된 내용이 존재합니다. 팝업을 종료하시겠습니까?") != 1 ){
            LC_STR_CD.Focus();
            return false;
        }
    }

    window.returnValue = false;
    window.close();      
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
//

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  공지사항 리스트 조회
 * return값 : void
 */
function searchMaster(){    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strNotiNo="+encodeURIComponent(posNotiNo)
    TR_MAIN.Action="/dps/pcod807.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
} 
/**
 * checkValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 입력값을 검증한다.
 * return값 : void
 */
function checkValidation(){
    var errCompObj;
    var errYn = false;
    var row;
    var toDay = getTodayFormat("YYYYMMDD");
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus=="1"||rowStatus=="3"))
            continue;
        row = i;
        if(DS_MASTER.NameValue(i,"STR_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
            errComp = "LC_STR_CD";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"NOTI_S_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "공지시작일");
            errComp = "EM_NOTI_S_DT";
            errYn = true;
            break;
        }
        if( rowStatus=="1"||DS_MASTER.NameValue(i,"NOTI_S_DT") != DS_MASTER.OrgNameValue(i,"NOTI_S_DT")){
        	if(!checkYYYYMMDD(DS_MASTER.NameValue(i,"NOTI_S_DT"))){
                showMessage(EXCLAMATION, OK, "USER-1006","공지시작일");
                errComp = "EM_NOTI_S_DT";
                errYn = true;
                break;              
        		
        	}
        	if( DS_MASTER.NameValue(i,"NOTI_S_DT") < toDay){
                showMessage(EXCLAMATION, OK, "USER-1030","공지시작일");
                errComp = "EM_NOTI_S_DT";
                errYn = true;
                break;        		
        	}
        }
        if(DS_MASTER.NameValue(i,"NOTI_E_DT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "공지종료일");
            errComp = "EM_NOTI_E_DT";
            errYn = true;
            break;
        }
        if( rowStatus=="1"||DS_MASTER.NameValue(i,"NOTI_E_DT") != DS_MASTER.OrgNameValue(i,"NOTI_E_DT")){
            if(!checkYYYYMMDD(DS_MASTER.NameValue(i,"NOTI_E_DT"))){
                showMessage(EXCLAMATION, OK, "USER-1006","공지종료일");
                errComp = "EM_NOTI_E_DT";
                errYn = true;
                break;              
                
            }
            if( DS_MASTER.NameValue(i,"NOTI_E_DT") < toDay){
                showMessage(EXCLAMATION, OK, "USER-1030","공지종료일");
                errComp = "EM_NOTI_E_DT";
                errYn = true;
                break;              
            }
        }
        
        if(DS_MASTER.NameValue(i,"NOTI_S_DT")> DS_MASTER.NameValue(i,"NOTI_E_DT")){
            showMessage(EXCLAMATION, OK, "USER-1020","공지종료일","공지시작일");
            errComp = "EM_NOTI_E_DT";
            errYn = true;
            break;              
        }
        if(DS_MASTER.NameValue(i,"NOTI_TITLE")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "제목");
            errComp = "EM_NOTI_TITLE";
            errYn = true;
            break;
        }
        if( !checkInputByte( null, DS_MASTER, i, 'NOTI_TITLE', '제목',  "EM_NOTI_TITLE")){
            errComp = "EM_NOTI_TITLE";
            errYn = true;
            break;          
        }
        if(DS_MASTER.NameValue(i,"NOTI_CONTENT")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "공지내용");
            errComp = "TXT_NOTI_CONTENT";
            errYn = true;
            break;          
        }
        var contentByteLength = getByteValLength(TXT_NOTI_CONTENT.Text);
        if( contentByteLength > 500){
            showMessage(EXCLAMATION, OK, "USER-1000", "공지내용은 500Byte 이상 초과 입력할수 없습니다.");
            errComp = "TXT_NOTI_CONTENT";
            errYn = true;
            break;          
        }
    }
    
    if( errYn){
        DS_MASTER.RowPosition = row;
        setTimeout(errComp +".Focus();",50);
        return false;
    }
    return true;
}
/**
 * checkDelYn()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 삭제 선택 여부
 * return값 : void
**/
function enableCnt( ){
	var insFlag = mode == 'I'?true:false;
	var updFlag = mode != 'R'?true:false;
	
    enableControl(EM_NOTI_NO     , false);
    enableControl(LC_STR_CD      , insFlag);
    
    /*
    if(mode != 'I'&& EM_NOTI_S_DT.Text <= getTodayFormat("YYYYMMDD")){  
        enableControl(IMG_NOTI_S_DT  , false);
        enableControl(EM_NOTI_S_DT   , false);
    }else{  
        enableControl(IMG_NOTI_S_DT  , updFlag);
        enableControl(EM_NOTI_S_DT   , updFlag);   
    }
    
    if(mode != 'I'&& EM_NOTI_E_DT.Text < getTodayFormat("YYYYMMDD")){  
        enableControl(EM_NOTI_E_DT    , false);
        enableControl(IMG_NOTI_E_DT   , false);
        
        EM_NOTI_TITLE.ReadOnly        = true;
        TXT_NOTI_CONTENT.ReadOnly     = true;
    }else{  
        enableControl(EM_NOTI_E_DT    , updFlag);
        enableControl(IMG_NOTI_E_DT   , updFlag);   
        EM_NOTI_TITLE.ReadOnly        = !updFlag;
        TXT_NOTI_CONTENT.ReadOnly     = !updFlag;
    }
    
    if(TXT_NOTI_CONTENT.ReadOnly ){
        TXT_NOTI_CONTENT.className    = "textarea_read";    	
    }else{
        TXT_NOTI_CONTENT.className    = "textarea_pk";        	
    }
    */
    //기간지나도 수정되도록
    enableControl(IMG_NOTI_S_DT  , false);
    enableControl(EM_NOTI_S_DT   , false);
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
    if(obj.Text == "")
        return;
    var dfDt = ""
    var toDay = getTodayFormat("YYYYMMDD");
    
    if(!checkDateTypeYMD( obj , ""))
        return;
    switch(gubnFlag){
        case 'NS':
            if(obj.Text < toDay){
                obj.Text = "";
                showMessage(INFORMATION, OK, "USER-1030","공지시작일");
                obj.Focus();
                return;
            }
        	break;
        case 'NE':
            if(obj.Text < toDay){
                obj.Text = "";
                showMessage(INFORMATION, OK, "USER-1030","공지종료일");
                obj.Focus();
                return;
            }
            break;
    }
}

/**
 * winClose()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  창 종료시 실행
 * return값 : void
 */
function winClose( ){
}

/**
 * onCheckLength()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  공지내용 입력 길이 저장
 * return값 : void
 */
function onCheckLength(){
    //
    var byteLength;
    var strBoolean;
    var value = TXT_NOTI_CONTENT.Text;
    byteLength = getByteValLength(value);
    EM_BYTE.Text = byteLength;
    
    var e = window.event;
    if (byteLength < 500 ) { 
         strBoolean = true;
    } else {
        strBoolean = false;
    }
    if(e != null)
        e.returnValue = strBoolean;
    return strBoolean;
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
 
 
 

<script language=JavaScript for=DS_MASTER event=OnColumnChanged(row,colid)>
    if(colid=="NOTI_CONTENT")
    	onCheckLength();
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>


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
<body onLoad="doInit();" onUnload="winClose()" >

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
        <td class="PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">POS공지사항관리 (상세)</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/save.gif" width="50" height="22"  onClick="btn_save();"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="68" class="point" >공지번호</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_NOTI_NO classid=<%=Util.CLSID_EMEDIT%>  width=224  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr>
              <tr>
                <th class="point" >점</th>
                <td >
                   <comment id="_NSID_">
                     <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=224 tabindex=1 align="absmiddle"></object>
                   </comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
              <tr>
                <th class="point" >공지기간</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_NOTI_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script><img 
                  src="/<%=dir%>/imgs/btn/date.gif" id=IMG_NOTI_S_DT onclick="javascript:setCalData('POP', 'NS', EM_NOTI_S_DT);"  align="absmiddle" />&nbsp;&nbsp;~&nbsp;
                  <comment id="_NSID_">
                    <object id=EM_NOTI_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script><img 
                  src="/<%=dir%>/imgs/btn/date.gif" id=IMG_NOTI_E_DT onclick="javascript:setCalData('POP', 'NE', EM_NOTI_E_DT);"  align="absmiddle" />
                </td>
              </tr>          
              <tr>
                <th class="point" >제목</th>
                <td >
                  <comment id="_NSID_">
                    <object id=EM_NOTI_TITLE classid=<%=Util.CLSID_EMEDIT%>  width=224  tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr> 
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th class="point" width="45">공지<br><br>내용</th>
                <td >
                  <comment id="_NSID_">
                    <object id=TXT_NOTI_CONTENT classid=<%=Util.CLSID_TEXTAREA%> 
                      width=247 height=216 tabindex=1 align="absmiddle"
                      onkeyup="javascript:onCheckLength();"
                      onkeydown="javascript:onCheckLength();" 
                      onkeypress="javascript:onCheckLength();"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
              </tr> 
            </table></td>
          </tr>
          <tr>
            <td style="Border-right:solid 0px #dddddd; Border-left:solid 0px #dddddd; padding-left:0px;" class="left FS11 red PT05 PB03">※PDA&nbsp;경우 한 화면에 12줄까지 조회 가능합니다.&nbsp;
              <span style="color:#484848; font-size: 12px; " >
                <comment id="_NSID_">
                  <object id=EM_BYTE classid=<%=Util.CLSID_EMEDIT%> width=25 height=18 align="absmiddle"></object>
                </comment><script> _ws_(_NSID_);</script>/500
              </span>
            </td>
          </tr>
        </table></td>
      </tr>
      <!-- 
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="60" class="sub_title PB03 PT10" >공지내용</td>
            <td  valign="bottom" class="right">
              <comment id="_NSID_">
                <object id=EM_BYTE classid=<%=Util.CLSID_EMEDIT%>  width=40 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>/500
            </td>
          </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td ><table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=TXT_NOTI_CONTENT classid=<%=Util.CLSID_TEXTAREA%> 
                width=300 height=200 tabindex=1 align="absmiddle"
                onkeyup="javascript:onCheckLength();"
                onkeydown="javascript:onCheckLength();" 
                onkeypress="javascript:onCheckLength();"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr> -->
    </table></td>
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

<comment id="_NSID_">
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_MASTER>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
        <c>col=STR_CD                 ctrl=LC_STR_CD                param=BindColVal </c>  
        <c>col=NOTI_NO                ctrl=EM_NOTI_NO               param=Text </c>
        <c>col=NOTI_S_DT              ctrl=EM_NOTI_S_DT             param=Text </c>
        <c>col=NOTI_E_DT              ctrl=EM_NOTI_E_DT             param=Text </c>
        <c>col=NOTI_TITLE             ctrl=EM_NOTI_TITLE            param=Text </c>
        <c>col=NOTI_CONTENT           ctrl=TXT_NOTI_CONTENT         param=Text </c>
    '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
