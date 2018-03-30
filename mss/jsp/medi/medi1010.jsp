<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 협력사 EDI > 협력사EDI 커뮤니티  
 * 작 성 일 : 2011.03.16
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : medi1010.jsp
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
<%String dir = BaseProperty.get("context.common.dir");%>
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

    // Input Data Set Header 초기화
   
    // Output Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    initEmEdit(EM_O_GUBUN_CD, "NUMBER3^6^0", NORMAL);       
    initEmEdit(EM_O_GUBUN_NM, "GEN", READ);          
    
    initEmEdit(LC_IO_NOTICE_FLAG, "GEN", NORMAL);   //통보방식
    initEmEdit(EM_IO_PWD_NO, "0000", NORMAL);        // 비밀번호변경
    initEmEdit(EM_IO_REMARK, "GEN^100", NORMAL);    //비고
    // 조회내용 초기화
    initComboStyle(LC_O_STR_CD, DS_O_STRCD, "CODE^0^30,NAME^0^80", 1, PK);
    initComboStyle(LC_O_GUBUN, "", "CODE^0^30,NAME^0^80", 1, NORMAL);
    
    getStore("DS_O_STRCD", "Y", "1", "N");             //점코드
    
    LC_O_STR_CD.Index = 0;
    LC_O_GUBUN.Index = 0;
    LC_O_STR_CD.Focus();
    
    
    enabelCheck(false);
    
    registerUsingDataset("medi101","DS_IO_MASTER");
    
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"             width=50   align=center</FC>'
                     + '<FC>id=STR_CD       name="점"             width=70   align=center SHOW=FALSE </FC>'
                     + '<FC>id=STRNM        name="점"             width=90   align=left  </FC>'
                     + '<FC>id=USER_GUBN    name="ID구분"       width=97   align=left </FC>'
                     + '<FC>id=USER_ID      name="ID"            width=100   align=center </FC>'
                     + '<FC>id=VEN_NAME     name="협력사/브랜드명"         width=120   align=left </FC>'
                     + '<FC>id=CHAR_NAME    name="담당자"         width=100   align=left </FC>'
                     + '<FC>id=HPONE        name="담당자연락처"         width=120   align=center Mask="XXX-XXXX-XXXX"</FC>'                     
                     + '<FC>id=UPD_DATE     name="최종변경일자"         width=100   align=center Mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=PWD_NO       name="비밀번호"         width=80   align=center </FC>'                     
                     + '<FC>id=NOTICE_FLAG  name="통보방식"         width=60   align=center show=false</FC>';
                     
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
 * 작 성 자 : FKL
 * 작 성 일 : 2011-02-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
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
		
		var strCd = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");
		var strUserId = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "USER_ID");
		var strUserGn = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GUBUN");
		var strRemark = EM_IO_REMARK.Text;
		
		var goTo = "save";    
	    var parameters = "&strCd="    + encodeURIComponent(strCd)
	                   + "&strUserId="+ encodeURIComponent(strUserId)
	                   + "&strUserGn="+ encodeURIComponent(strUserGn);
	            
	    TR_MAIN.Action = "/mss/medi101.md?goTo="+goTo+parameters + "&Remark=" + encodeURIComponent(strRemark);
	    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	    TR_MAIN.Post();
	    
	    getSearch();
	    EM_IO_REMARK.Text = "";
	    
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
	var strGubun =  LC_O_GUBUN.BindColVal;	
	
	if( LC_O_GUBUN.Text.length == 0 ){
		showMessage(INFORMATION, OK, "USER-1001", "구분");
		LC_O_GUBUN.Focus();
		return;
	}else {
		if( strGubun == "1" ){
	        venPop(EM_O_GUBUN_CD, EM_O_GUBUN_NM, LC_O_STR_CD.BindColVal, '', '', '', '', '');
	    }else if( strGubun == "2" ){
	    	openPop("S");
	    }else {
	    	showMessage(Information, OK, "USER-1000", "구분의 협력사 또는 브랜드을 선택하셔야 합니다.");
	    	LC_O_GUBUN.Focus();
            return;
	    }
	}
	
}  

  /**
   * getSearch()
   * 작 성 자 : 
   * 작 성 일 : 2011-03-16
   * 개    요 :  마스터 그리드 조회
   * return값 : void
 */  
 
function getSearch(){
	
	var strcd     = LC_O_STR_CD.BindColVal;
	var strGubun  = LC_O_GUBUN.BindColVal;
	var gubunCode = EM_O_GUBUN_CD.Text;
	
	var goTo = "getMaster";    
    var parameters = "&gubunCode="+encodeURIComponent(gubunCode);
            
    TR_MAIN.Action = "/mss/medi101.md?goTo="+goTo+parameters + "&strcd=" + encodeURIComponent(strcd) +"&strGubun="+encodeURIComponent(strGubun);
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
    if( DS_IO_MASTER.CountRow > 0 ){
    	enabelCheck(true);
    	GD_MASTER.Focus();    	
    }else {
    	enabelCheck(false);
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
			
			if( DS_IO_MASTER.NameValue(i, "PWD_NO") == "" ){
                showMessage(STOPSIGN, OK, "USER-1003", "변경비밀번호");
                DS_IO_MASTER.RowPosition = i;
                EM_IO_PWD_NO.Focus();
                return false;
            }
			/* 아트몰링 2017-01-03	 비밀번호 4자리 and 숫자만 */
			if(DS_IO_MASTER.NameValue(i, "PWD_NO").length != 4){
				showMessage(EXCLAMATION, OK, "USER-1000",  "비밀번호는 4자리입니다.");
                DS_IO_MASTER.RowPosition = i;
                EM_IO_PWD_NO.Focus();
                return false;
			}
			if(!isNumberStr(DS_IO_MASTER.NameValue(i, "PWD_NO"))){
				showMessage(EXCLAMATION, OK, "USER-1005",  "비밀번호");
                DS_IO_MASTER.RowPosition = i;
                EM_IO_PWD_NO.Focus();
                return false;
			}
		}
	}
	
	//한글이 입력 되었는지 체크
	var pwd = EM_IO_PWD_NO.Text;
		
	for( i = 0; i < pwd.length; i++ ){
		
		if(escape(pwd.charAt(i)).length > 4) {
			showMessage(Information, OK, "USER-1000", "한글은 입력 할수 없습니다.");
			EM_IO_PWD_NO.Text = "";
			EM_IO_PWD_NO.Focus();
			return false;
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
		EM_IO_PWD_NO.Enable = "false";
		LC_IO_NOTICE_FLAG.Enable = "false";
		EM_IO_REMARK.Enable = "false";
	}else if( Flag  == true ) {
		EM_IO_PWD_NO.Enable = "true";
        LC_IO_NOTICE_FLAG.Enable = "true";
        EM_IO_REMARK.Enable = "true";
	}
	
}
function pwdCehck(){
	showMessage(Information, OK, "USER-1000", "비밀번호는 8자 이상 영문 대/소문자, 숫자 <br> 특수문자를 모두 혼용해서 사용해야 합니다.");
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
    
	var strGubun =  LC_O_GUBUN.BindColVal;                
            
	if(!this.Modified)
        return;
    
    if(this.text==''){
       EM_O_GUBUN_NM.Text = "";
       return;
    }   
    	
            if( strGubun == "1" ){
            	setVenNmWithoutPop("DS_O_RESULT", EM_O_GUBUN_CD, EM_O_GUBUN_NM, 1, LC_O_STR_CD.BindColVal, '', '', '', '', '');
            	
            }else if( strGubun == "2" ) {
            	
            	if(EM_O_GUBUN_CD.text!=null){
                    if(EM_O_GUBUN_CD.text.length > 0){
                    	openPop("S", "N");	
                    }
                }
            }else {
            	showMessage(Information, OK, "USER-1000", "구분의 협력사 또는 브랜드을 선택하셔야 합니다."); 
            	LC_O_GUBUN.Focus();
            	return;
            }
      
        GD_MASTER.Focus();
  
    
</script>

<script language=JavaScript for=LC_O_GUBUN event=OnSelChange()>
    EM_O_GUBUN_CD.Text = "";
    EM_O_GUBUN_NM.Text = "";
    
    if( LC_O_GUBUN.BindColVal == "@" ){
    	EM_O_GUBUN_CD.Enable = "false";
    	enableControl(ven_pum, false);
    }else {
    	EM_O_GUBUN_CD.Enable = "true";
        enableControl(ven_pum, true);
    }
    
    
</script>

<!-- 변경된 비밀번호 유효성 체크 (영문, 숫자, 특수문자 ) -->
<script language=JavaScript for=EM_IO_PWD_NO event=onKillFocus()>

    var strPwdNo =  EM_IO_PWD_NO.Text;
	if( strPwdNo.length < 1 ){
		return;
	}

    /* 아트몰링 2017-01-03	 비밀번호 4자리 and 숫자만 */
    if(strPwdNo.length != 4){
    	showMessage(EXCLAMATION, OK, "USER-1000",  "비밀번호는 4자리입니다.");
    	EM_IO_PWD_NO.Text = "";
     	setTimeout("EM_IO_PWD_NO.Focus()", 120);    	
//     	EM_IO_PWD_NO.Focus();
    	return;
    	
    }
    
    if(!isNumberStr(strPwdNo)){
    	showMessage(EXCLAMATION, OK, "USER-1005",  "비밀번호");
    	EM_IO_PWD_NO.Text = "";
     	setTimeout("EM_IO_PWD_NO.Focus()", 120);  
//     	EM_IO_PWD_NO.Focus();
    	return;
    	
    }
    
//     if( strPwdNo.Text != "" && strPwdNo.length < 8 ){
//         showMessage(Information, OK, "USER-1000", "비밀번호는 8자 이상 영문 대/소문자, 숫자 <br> 특수문자를 모두 혼용해서 사용해야 합니다.");
   
//         EM_IO_PWD_NO.Text = "";
//         setTimeout("EM_IO_PWD_NO.Focus()", 120);
//         return;
//     }else {
    	
//     	 var alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
//     	 var number = "1234567890";
//     	 var sChar = "-_=+\|()*&^%$#@!~`?></;,.:'";

//     	 var sChar_Count = 0;
//     	 var alphaCheck = false;
//     	 var numberCheck = false;    
    	  
//         var retVal = checkSpace(strPwdNo);      
        
//         if( retVal ) {
        
//             showMessage(Information, OK, "USER-1000", "비밀번호는 공백 없이 입력해 주세요");           
//             setTimeout("EM_IO_PWD_NO.Focus()", 120);
//             return;
//         }
        
        
//         for(var i=0; i< strPwdNo.length; i++){
            
//         	if(sChar.indexOf(strPwdNo.charAt(i)) != -1){
// 	           sChar_Count++;
// 	        }
//             if(alpha.indexOf(strPwdNo.charAt(i)) != -1){
//                alphaCheck = true;
//             }
//             if(number.indexOf(strPwdNo.charAt(i)) != -1){
//                numberCheck = true;
//             }
//         }//for
            
//         if(sChar_Count < 1 || alphaCheck != true || numberCheck != true){
//         	showMessage(Information, OK, "USER-1000", "비밀번호는 8자 이상 영문 대/소문자, 숫자 <br> 특수문자를 모두 혼용해서 사용해야 합니다.");
//         	//pwdCehck();
//         	//EM_IO_PWD_NO.Focus();
        	  	
//         	EM_IO_PWD_NO.Text = "";
//         	setTimeout("EM_IO_PWD_NO.Focus()", 120);
//         	return;
//         }
//     }    
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

if(clickSORT) return;

</script>


<!--  ===================GD_MASTER============================ -->
<!-- Grid Master CanRowPosChange event 처리 -->

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

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STRCD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>    


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
	            <td >
	                  <comment id="_NSID_">
	                      <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width="100" align="absmiddle" tabindex=1 >
	                      </object>
	                  </comment><script>_ws_(_NSID_);</script>	                  
	            </td>
            <th width="80">ID구분</th>
            <td >
                  <comment id="_NSID_">
                      <object id=LC_O_GUBUN classid=<%= Util.CLSID_LUXECOMBO %> width="100" align="absmiddle" tabindex=1>
                          <param name=CBData            value="%^전체,1^협력사,2^브랜드,@^택발행업체">
                          <param name=CBDataColumns   value="CODE,NAME">
                          <param name=SearchColumn    value=NAME>
                          <param name=Sort            value=False>
                          <param name=ListExprFormat  value="CODE^0^20,NAME^0^50">                                               
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="100">협력사</th>
            <td >
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
        <tr><td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 사용자리스트</td></tr>
        <tr><td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                    <tr>
                        <td width="100%">
                            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=420 classid=<%=Util.CLSID_GRID%>>
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
    <tr>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
            <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>기본사항</td>
            </tr>
            <tr>
                <td height="2"></td>
            </tr>
            <tr>
                <td >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
                        <tr>
                            <th width="90" class="POINT">변경비밀번호</th>
                            <td >
                                   <comment id="_NSID_">
                                       <object id=EM_IO_PWD_NO  classid=<%= Util.CLSID_EMEDIT %> width=400 align="absmiddle" tabindex=1   >
                                       </object>
                                   </comment><script>_ws_(_NSID_);</script>
                             </td> 
                            <th width="90" class="POINT">통보방식</th>
                            <td>
                                  <comment id="_NSID_">
                                      <object id=LC_IO_NOTICE_FLAG  classid=<%= Util.CLSID_LUXECOMBO %> width=190 align="absmiddle" tabindex=1>
                                          <param name=CBData          value="01^SMS,02^유선통보,03^기타방식">
                                          <param name=CBDataColumns   value="CODE,NAME">
                                          <param name=SearchColumn    value=NAME>
                                          <param name=Sort            value=False>
                                          <param name=BindColumn      value="CODE">                                           
                                          <param name=ListExprFormat  value="CODE^0^50,NAME^0^150">
                                      </object>
                                  </comment><script>_ws_(_NSID_);</script>
                           </td>
                        </tr>
                        <tr>
                            <th width="90" >비고</th>
                            <td colspan="3">
                                   <comment id="_NSID_">
                                       <object id=EM_IO_REMARK  classid=<%= Util.CLSID_EMEDIT %> width=690 align="absmiddle" tabindex=1 onKeyup="javascript:checkByteStr(this, 100, 'Y');" >
                                       </object>
                                   </comment><script>_ws_(_NSID_);</script>
                             </td> 
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </tr>
    </table>
    </td>
    </tr>
</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>col=PWD_NO             ctrl=EM_IO_PWD_NO       param=Text</c>
        <c>col=NOTICE_FLAG        ctrl=LC_IO_NOTICE_FLAG  param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

