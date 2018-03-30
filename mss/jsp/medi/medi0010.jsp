<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 협력사 EDI > 협력사EDI 커뮤니티  
 * 작 성 일 : 2011.03.16
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : medi0010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사 비밀번호관리
 * 이    력 :
 *        2011.03.16 (오형규) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %>

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
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
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
	 var now = new Date();
	 var mon = now.getMonth()+1;
	 if(mon < 10)mon = "0" + mon;
	 var day = now.getDate();
	 if(day < 10)day = "0" + day;
	 var varToday = now.getYear().toString()+ mon + day;
	 var varToMon = now.getYear().toString()+ mon;
	 
    // Input Data Set Header 초기화
   
    // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    initEmEdit(EM_O_GUBUN_CD, "NUMBER3^6^0", NORMAL);       
    initEmEdit(EM_O_GUBUN_NM, "GEN", READ);
    initEmEdit(EM_O_EMPNAME, "GEN", NORMAL);
    initEmEdit(EM_O_HPNO, "NUMBER3^11^0", NORMAL);
    initEmEdit(EM_O_ENTRDT,      "YYYYMMDD", PK);   // 실적 시작일
    initEmEdit(EM_O_RETRDT,      "YYYYMMDD", PK);   // 실적 종료일
    
    
    
    
    
    // 조회내용 초기화
    initComboStyle(LC_O_STR_CD,		DS_O_STRCD, 	"CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_O_EMP_FLAG,	DS_O_EMPFLAG,	"CODE^0^30,NAME^0^130", 1, NORMAL);
    initComboStyle(LC_O_ISU,		DS_O_ISU, 		"CODE^0^30,NAME^0^80" , 1, NORMAL);
    
    
    getStore("DS_O_STRCD", "Y", "1", "N");             //점코드
    getEtcCode("DS_O_EMPFLAG"    , "D", "D222", "Y");  //
    getEtcCode("DS_O_ISU"    , "D", "D022", "Y" );
    getEtcCode("DS_IO_ISU"    , "D", "D022", "N" );
    getEtcCode("DS_IO_EMPFLAG"    , "D", "D222", "N" );
    
    LC_O_STR_CD.Index = 0;
    LC_O_EMP_FLAG.Index = 0;
    LC_O_ISU.Index = 0;
    RD_SEARCHGB.CodeValue = "1";
    EM_O_ENTRDT.text    = varToMon+"01";
    EM_O_RETRDT.text    = varToday;
    
    
    LC_O_STR_CD.Focus();
    
    
    //enabelCheck(false);
    
    registerUsingDataset("medi001","DS_IO_MASTER");
    
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"       width=50   align=center </FC>'
                     + '<FC>id=STR_CD       name="점"       width=70   align=center EditStyle=Lookup Data="DS_O_STRCD:CODE:NAME" edit="none" </FC>'
                     + '<FG>				name="브랜드" '
                     + '<FC>id=PUMBUN_CD    name="코드"     width=80   align=center  edit=none </FC>'
                     + '<FC>id=PUMBUN_NAME	name="명"       width=150  align=left edit="none" </FC>'
                     + '</FG>'
                     + '<FC>id=EMP_SEQ      name="SEQ"      width=120   align=left show=false </FC>'
                     + '<FC>id=EMP_FLAG    	name="사원구분"	width=120   align=center EditStyle=Lookup Data="DS_IO_EMPFLAG:CODE:NAME" </FC>'
                     + '<FC>id=EMP_NAME     name="사원명"   width=120   align=center </FC>'                     
                     + '<FC>id=HP_NO     	name="연락처"   width=130   align=center Mask={"XXX-XXXX-XXXX"} </FC>'
                     + '<FC>id=ENTR_DT      name="입사일자" width=100   align=center Mask="XXXX/XX/XX" edit= none </FC>'                     
                     + '<FC>id=RETR_DT  	name="퇴사일자" width=100   align=center Mask="XXXX/XX/XX" edit= none </FC>'
                     + '<FC>id=ISU_YN  		name="교육이수" width=80   align=center EditStyle=Lookup Data="DS_IO_ISU:CODE:NAME" < /FC>'
                     + '<FC>id=ISU_DATE  	name="이수일자" width=80   align=center Mask="XXXX/XX/XX" edit=none</FC>'
                     + '<FC>id=DEL_YN  		name="삭제구분" width=80   align=center show=false</FC>'
                     ;
                     
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
 * 작 성 일 : 2011-02-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
	if (DS_IO_MASTER.IsUpdated)	{
		//["USER-1095", "변경내역이 있습니다. <br> 창을 닫으시겠습니까?"], //  StopSign    , YESNO
		var rtnVal = showMessage(StopSign, YESNO, "USER-1084");
		
		if (rtnVal!=1)
			return;
	} 
	
	if( LC_O_STR_CD.Text.length == 0 ){
        showMessage(INFORMATION, OK, "USER-1001", "점");
        LC_O_STR_CD.Focus();
        return;
    } 
	 
	 getSearch();
     
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-02-16
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
	if( DS_IO_MASTER.CountRow < 1 ){
		 showMessage(StopSign, OK, "USER-1019");
	     return;
	 }
	
	//  ["USER-1023", "선택한 항목을 삭제하겠습니까?"], // Question    , YesNo
	
	if (showMessage(Question, YESNO, "USER-1023") != 1) return;
	
	var nRow		= DS_IO_MASTER.RowPosition;
	
	var strStrCd 	= DS_IO_MASTER.NameValue(nRow, "STR_CD");
	var strPumbunCd = DS_IO_MASTER.NameValue(nRow, "PUMBUN_CD");
	var strEmpSeq 	= DS_IO_MASTER.NameValue(nRow, "EMP_SEQ");
	
	var goTo = "delete";    
    var parameters = "&strStrCd="		+encodeURIComponent(strStrCd)
    			   + "&strPumbunCd="	+encodeURIComponent(strPumbunCd)
    			   + "&strEmpSeq="		+encodeURIComponent(strEmpSeq)
    				;
            
    TR_MAIN.Action = "/mss/medi001.md?goTo="+goTo+parameters;
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    getSearch();
}

/**
 * btn_Save()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-02-16
 * 개    요 : DB에 저장 / 수정
 * return값 : void
 */
function btn_Save() {
    
	 if( DS_IO_MASTER.CountRow < 1 ){
		 showMessage(StopSign, OK, "USER-1028");
	     return;
	 }
	 
	 if( DS_IO_MASTER.IsUpdated ){
    	
		if( !VailCheckSave() ) return;
		
		if (showMessage(STOPSIGN, YESNO, "USER-1010") != 1) return;
		
		
		var goTo = "save";    
	    var parameters = ""
	    				;
	            
	    TR_MAIN.Action = "/mss/medi001.md?goTo="+goTo+parameters;
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	    TR_MAIN.Post();
	    
	    getSearch();
	    
	    
    }else {
    	showMessage(StopSign, OK, "USER-1028");
        return;
    }
    	
    
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
 
 /**
  * gubunPopup()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-16
  * 개    요 :  구분에 따라 협력사, 브랜드 팝업 생성
  * return값 : void
*/  
function gubunPopup(){

  	openPop("S");
	
}  

  /**
   * getSearch()
   * 작 성 자 : 
   * 작 성 일 : 2011-03-16
   * 개    요 :  마스터 그리드 조회
   * return값 : void
 */  
 
function getSearch(){
	
	var strStrCd     	= LC_O_STR_CD.BindColVal;
	var strPumbunCd		= EM_O_GUBUN_CD.TEXT;
	var strEmpName 		= EM_O_EMPNAME.TEXT;
	var strEmpFlag 		= LC_O_EMP_FLAG.BindColVal;
	var strHpNo 		= EM_O_HPNO.TEXT;
	var strIsuYn 		= LC_O_ISU.BindColVal;
	var strDelYn 		= "N";
	var strSearchGb 	= RD_SEARCHGB.CodeValue;
	
	var strEntrDt 		= EM_O_ENTRDT.TEXT;
	var strRetrDt 		= EM_O_RETRDT.TEXT;
	
	
	var goTo = "getMaster";    
    var parameters = "&strStrCd="		+encodeURIComponent(strStrCd)
    				+"&strPumbunCd="	+encodeURIComponent(strPumbunCd)
    				+"&strEmpName="		+encodeURIComponent(strEmpName)
    				+"&strEmpFlag="		+encodeURIComponent(strEmpFlag)
    				+"&strHpNo="		+encodeURIComponent(strHpNo)
    				+"&strIsuYn="		+encodeURIComponent(strIsuYn)
    				+"&strDelYn="		+encodeURIComponent(strDelYn)
    				+"&strSearchGb="	+encodeURIComponent(strSearchGb)
    				+"&strEntrDt="		+encodeURIComponent(strEntrDt)
    				+"&strRetrDt="		+encodeURIComponent(strRetrDt)
 			    	;
            
    TR_MAIN.Action = "/mss/medi001.md?goTo="+goTo+parameters;
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
    if( DS_IO_MASTER.CountRow > 0 ){
    	//enabelCheck(true);
    	GD_MASTER.Focus();    	
    }else {
    	//enabelCheck(false);
    }
   
}  

//space 가 있으면 true, 없으면 false
function checkSpace( str )
{
     if(str.search(/\s/) != -1){
        return true;
     } else {
        return false;
     }
}

/**
 * VailCheckSave()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-16
 * 개    요 :  저장시 유효성 체크
 * return값 : void
*/  

function VailCheckSave(){
    
	for( i=1; i <= DS_IO_MASTER.CountRow; i++  ){
		if( DS_IO_MASTER.RowStatus(i) == 1 || DS_IO_MASTER.RowStatus(i) == 3  ){
			/* 연락처 9자리이상 11자리 미만, 숫자만 */
			if( DS_IO_MASTER.NameValue(i, "HP_NO").length <9||DS_IO_MASTER.NameValue(i, "HP_NO").length > 11 ){
                showMessage(STOPSIGN, OK, "USER-1000", "연락처가 잘못되었습니다.");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("HP_NO");
                return false;
            }
			if(!isNumberStr(DS_IO_MASTER.NameValue(i, "HP_NO"))){
				showMessage(EXCLAMATION, OK, "USER-1005",  "연락처");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("HP_NO");
                return false;
			}
			
			/* 사원명 필수 */
			if(DS_IO_MASTER.NameValue(i, "EMP_NAME").length < 1){
				showMessage(EXCLAMATION, OK, "USER-1003",  "사원명");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("EMP_NAME");
                return false;
			}
			
			/* 사원구분 필수 */
			if(DS_IO_MASTER.NameValue(i, "EMP_FLAG") == ""){
				showMessage(EXCLAMATION, OK, "USER-1003",  "사원구분");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("EMP_FLAG");
                return false;
			}
			
			/* 입사일자 필수 */
			if(DS_IO_MASTER.NameValue(i, "ENTR_DT") == ""){
				showMessage(EXCLAMATION, OK, "USER-1003",  "입사일자");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("EMP_FLAG");
                return false;
			}
			
			/* 퇴사일자 필수 */
			/*
			if(DS_IO_MASTER.NameValue(i, "RETR_DT") == ""){
				showMessage(EXCLAMATION, OK, "USER-1003",  "퇴사일자");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("RETR_DT");
                return false;
			}
			*/
			
			/* 입퇴사 일자 비교 */
			/*
			if(DS_IO_MASTER.NameValue(i, "RETR_DT") < DS_IO_MASTER.NameValue(i, "ENTR_DT")){
				showMessage(EXCLAMATION, OK, "USER-1000",  "퇴사일자는 입사일자보다 과거 일 수 없습니다.");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("RETR_DT");
                return false;
			}
			*/
			/* 사원구분 필수 */
			if(DS_IO_MASTER.NameValue(i, "ISU_YN") == ""){
				showMessage(EXCLAMATION, OK, "USER-1003",  "교육이수");
                DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("ISU_YN");
                return false;
			}
			
			/* 교육이수처리시 이수일자 등록 체크 */
			if(DS_IO_MASTER.NameValue(i, "ISU_YN")=="Y"&&DS_IO_MASTER.NameValue(i, "ISU_DATE")=="") {
				showMessage(EXCLAMATION, OK, "USER-1003",  "교육이수일자");
				DS_IO_MASTER.RowPosition = i;
                GD_MASTER.SetColumn("ISU_DATE");
                return false;
			}
				
		}
	}

	return true;
}

/**
 * enabelCheck()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-16
 * 개    요 :  활성화 / 비활성화
 * return값 : void
*/ 

function enabelCheck(Flag){
	
	if( Flag == false ){
		LC_EMP_FLAG.Enable = "false";
		//LC_IO_NOTICE_FLAG.Enable = "false";
		
	}else if( Flag  == true ) {
		LC_EMP_FLAG.Enable = "true";
        //LC_IO_NOTICE_FLAG.Enable = "true";
        
	}
	
}


function btnAddRow() {
	obj = DS_IO_MASTER;
	
	obj.Addrow();
	
	obj.NameValue(obj.CountRow,"STR_CD") 	= "01";
	//obj.NameValue(obj.CountRow,"PUMBUN_CD") = "500274";
	
	
}

function btnDelRow(row) {
	
	if (DS_IO_MASTER.SysStatus(row)!=1) {
		//["USER-1039", "이미 등록된 행은 삭제하실수 없습니다."], // Information , Ok
		showMessage(Information,OK,"USER-1039");
		return false;
	}

	DS_IO_MASTER.DeleteRow(row);

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
         var objCd = EM_O_GUBUN_CD;
         var objNm = EM_O_GUBUN_NM;
         var objStr = LC_O_STR_CD;
     }else if(strFlag == "I"){
    	 var objCd = EM_O_GUBUN_CD;
         var objNm = EM_O_GUBUN_NM;
         var objStr = LC_O_STR_CD;
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

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 조회용 협력사/ 브랜드  키업이벤트 -->
<script language=JavaScript for=EM_O_GUBUN_CD event=onKillFocus()>
    
	               
            
	if(!this.Modified)
        return;
    
    if(this.text==''){
       EM_O_GUBUN_NM.Text = "";
       return;
    }   
    	

    if(EM_O_GUBUN_CD.text!=null){
       if(EM_O_GUBUN_CD.text.length > 0)
          openPop("S", "N");	
       else 
    	   return;
    }
      
	 GD_MASTER.Focus();
    
</script>
    
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if(clickSORT) return;

</script>

<script language=JavaScript for=RD_SEARCHGB event=OnClick()>
	var strSearchGb = RD_SEARCHGB.CodeValue;
	
	if (strSearchGb=="1") {
		EM_O_ENTRDT.enabled = true;
		EM_O_RETRDT.enabled = true;
	} else if (strSearchGb=="2") {
		EM_O_ENTRDT.enabled = true;
		EM_O_RETRDT.enabled = false;
	} else if (strSearchGb=="3") {
		EM_O_ENTRDT.enabled = false;
		EM_O_RETRDT.enabled = true;
	} else {
		return;
	}
</script>

<!--  ===================GD_MASTER============================ -->
<!-- Grid Master CanRowPosChange event 처리 -->

 
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
	
	switch(colid){
	    
	    case "ENTR_DT":		// 입사일자
	    case "RETR_DT":		// 퇴사일자
	    	var strRtnVal = openCal('G',EM_O_HIDDEN);
	    	
	    	if (strRtnVal == undefined) 
	    		EM_O_HIDDEN.text = "";

	    	if(EM_O_HIDDEN.text.length>0)
	    		DS_IO_MASTER.NameValue(row,colid) = EM_O_HIDDEN.text;
	        break;
		
	    case "ISU_DATE":	// 교육이수일자
	    	if (DS_IO_MASTER.NameValue(row,"ISU_YN") == "Y") {
	    		
	    		var strRtnVal = openCal('G',EM_O_HIDDEN);
		    	
		    	if (strRtnVal == undefined) 
		    		EM_O_HIDDEN.text = "";
		    	
		    	if(EM_O_HIDDEN.text.length>0)
		    		DS_IO_MASTER.NameValue(row,colid) = EM_O_HIDDEN.text;
	    	}
	        break; 
	        
	     // 브랜드 팝업
		case "PUMBUN_CD":
			if (DS_IO_MASTER.SysStatus(row) != 1 ) return;
			var rtn = strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y');
	 		if (rtn != null) {
	 			
	 			// 데이터 셋에 입력.
	 			DS_IO_MASTER.NameValue(row, colid) = EM_PUMBUN_CD.text;
	 			DS_IO_MASTER.NameValue(row, "PUMBUN_NAME") = EM_PUMBUN_NAME.text;
	 			
	 			// 전달 받은 텍스트 초기화.
	 			EM_PUMBUN_CD.text 	= "";
	 			EM_PUMBUN_NAME.text = "";
	 		}
			break;
	        
	    default :
	        break;
	}
</script>
 
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
	
	switch(colid){
	    
	    case "ISU_YN":		// 이수구분
	    	if (this.NameValue(row,colid)=="N")
	    		this.NameValue(row,"ISU_DATE") = "";
	       break;
	       
	    case "HP_NO":		// 이수구분
	    	var strTemp = this.NameValue(row,colid);
	    	 if (strTemp.indexOf("-")>= 0) {
	    		 strTemp = strTemp.replace(/-/gi, ""); 
	    	 }
	    	 this.NameValue(row,colid) = strTemp;
	       break;
	       
	    
	        
	    default :
	        break;
	}
	
	
</script>

<!--  ===================GD_MASTER============================ -->

 
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
<comment id="_NSID_"><object id=DS_I_COMMON  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STRCD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EMPFLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_EMPFLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_ISU"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISU"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POP"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>



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
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<DIV id="testdiv" class="testdiv">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
          <!-- search start -->
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
              	<th width="80" class="POINT">점</th>
	            <td width="100">
	                  <comment id="_NSID_">
	                      <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width="100" align="absmiddle" tabindex=1 >
	                      </object>
	                  </comment><script>_ws_(_NSID_);</script>	                  
	            </td>
            	<th width="80">브랜드</th>
            	<td width="270">
                  	<comment id="_NSID_">
                      <object id=EM_O_GUBUN_CD classid=<%= Util.CLSID_EMEDIT %> width="80" align="absmiddle" tabindex=1 >
                      </object>
                  	</comment><script>_ws_(_NSID_);</script>
                  	<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="ven_pum"  class="PR03" onclick="javascript:gubunPopup();" align="absmiddle"/>
                  	<comment id="_NSID_">
                      <object id=EM_O_GUBUN_NM classid=<%= Util.CLSID_EMEDIT %> width="160" align="absmiddle" tabindex=1>
                      </object>
                  	</comment><script>_ws_(_NSID_);</script>
            	</td>
            	<th width="80">사원명</th>
            	<td width="140">
                  <comment id="_NSID_">
                      <object id=EM_O_EMPNAME classid=<%= Util.CLSID_EMEDIT %> width="140" align="absmiddle" tabindex=1>
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
            	</td>
            	<th width="80">사원구분</th>
	            <td width="160">
	                  <comment id="_NSID_">
	                      <object id=LC_O_EMP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width="160" align="absmiddle" tabindex=1 >
	                      </object>
	                  </comment><script>_ws_(_NSID_);</script>	                  
	            </td>
            	<th width="80">연락처</th>
            	<td width="140">
                  <comment id="_NSID_">
                      <object id=EM_O_HPNO classid=<%= Util.CLSID_EMEDIT %> width="140" align="absmiddle" tabindex=1>
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
            	</td>
            	<th width="100">교육이수유무</th>
	            <td >
	                  <comment id="_NSID_">
	                      <object id=LC_O_ISU classid=<%= Util.CLSID_LUXECOMBO %> width="80" align="absmiddle" tabindex=1 >
	                      </object>
	                  </comment><script>_ws_(_NSID_);</script>	                  
	            </td>
          </tr>
          <tr>
          	<th colspan="3" class="point">
          		<comment id="_NSID_"> 
					<object id="RD_SEARCHGB" classid="<%=Util.CLSID_RADIO%>" width=270 height=18 align="absmiddle">
						<param name="Cols"   value="3">
						<param name="Format" value="1^근무기간,2^입사일자,3^퇴사일자">
					</object> 
				</comment><script>_ws_(_NSID_);</script>
          	</th>
          	<td colspan="9">
          		<comment id="_NSID_">
          			<object id=EM_O_ENTRDT classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"></object>
          		</comment> <script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:if(RD_SEARCHGB.CodeValue!='3')openCal('G',EM_O_ENTRDT);" align="absmiddle" />~
				<comment id="_NSID_">
					<object id=EM_O_RETRDT classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle"> </object>
			    </comment> <script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:if(RD_SEARCHGB.CodeValue!='2')openCal('G',EM_O_RETRDT);" align="absmiddle" />
                <comment id="_NSID_">
					<object id=EM_O_HIDDEN classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle" style="display:none"> </object>
			    </comment> <script> _ws_(_NSID_);</script>
			    
			    <comment id="_NSID_">
					<object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle" style="display:none"> </object>
			    </comment> <script> _ws_(_NSID_);</script>
			    
			    <comment id="_NSID_">
					<object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle" style="display:none"> </object>
			    </comment> <script> _ws_(_NSID_);</script>
          	</td>
          </tr>         
          </table>
        </td>
        </tr>
       </table>
    </td>
  </tr>
  <tr><td class="dot"></td></tr> 
  <tr>
    <td class="PB03">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr><td >
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        	<td class="sub_title" width="60%"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 사용자리스트</td>
        	<td>
        		<img src="/<%=dir%>/imgs/btn/add_row.gif"  class="PR03" onclick="btnAddRow();"  align="absmiddle"/>
        		<img src="/<%=dir%>/imgs/btn/del_row.gif"  class="PR03" onclick="btnDelRow(DS_IO_MASTER.RowPosition);" align="absmiddle"/>
        	</td>
        </tr>
        <tr><td colspan="2">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr>
                        <td width="100%">
                            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=700 classid=<%=Util.CLSID_GRID%>>
                                <param name="DataID" value="DS_IO_MASTER">
                            </OBJECT></comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
        </td></tr>
        </table>
    </td>
    <td>
     </td>
      </tr>        
     </table>
    </td>
    </tr>
    <tr><td height="2"></td></tr>
    
    </table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

