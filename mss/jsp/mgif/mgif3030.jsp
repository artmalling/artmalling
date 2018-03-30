<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 상품권 판매반품등록
 * 작 성 일 : 2011.01.19
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 : 2011.01.19 (김성미) 신규작성
           2011.04.08 (김정민) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var strKey = true;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
 var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_SALE_DT, "YYYYMMDD", PK);            // 판매반품일자(조회)
    initEmEdit(EM_I_SALE_DT, "YYYYMMDD", READ);          // 매출일자
  
    EM_S_SALE_DT.Text    = getTodayFormat("YYYYMMDD");   // 판매반품일자(조회)
 //   EM_I_SALE_DT.Text    = getTodayFormat("YYYYMMDD");   // 매출일자

    initEmEdit(EM_S_REG_ID,         "GEN^40", READ);     // 등록자(조회)
    initEmEdit(EM_I_POS_SALE,       "NUMBER3^24^0", NORMAL);   // POS영수증번호
    initEmEdit(EM_I_SALE_SLIP_NO,   "NUMBER3^16^0", NORMAL);   // 원거래상품권매출번호
    initEmEdit(EM_I_SALE_SLIP_NO2,  "GEN^22", READ);     // 상품권 매출번호 
    initEmEdit(EM_S_GIFT_NO,        "GEN^18", NORMAL);   // 시작번호
 //   initEmEdit(EM_E_GIFT_NO,        "GEN^18", NORMAL);   // 종료번호
  
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
  
    // 공통에서 가져오기
    getStore("DS_S_STR_CD", "Y", "1", "N");   //점(조회)
    
  //점(조회) 
    LC_S_STR_CD.Index = 0;
    
    EM_S_REG_ID.Text = strUserNM;
    
    LC_S_STR_CD.Focus();
    

    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif303", "DS_O_MASTER,DS_O_DETAIL");
    
} 
function gridCreate1(){ 
    var hdrProperies = '<FC>id={currow}         name="NO"           width=25   align=center</FC>'
                     + '<FC>id=SALE_SEQ_NO       name="순번"             width=84   align=left Show=false </FC>'
                     + '<FC>id=GIFT_TYPE_CD     name="상품권"        width=84   align=left Show=false </FC>'
                     + '<FC>id=GIFT_TYPE_NAME   name="상품권종류"     width=84   align=left</FC>'
                     + '<FC>id=GIFT_AMT_TYPE    name="금종코드"       width=80   align=left Show=false </FC>'
                     + '<FC>id=GIFT_AMT_NAME    name="금종"          width=60   align=left SubSumText=""  SumText="합계" </FC>'
                     + '<FC>id=GIFTCARD_NO      name="상품권코드"     width=130   align=center   SubSumText="금종소계"   </FC>' 
                     + '<FC>id=SALE_QTY         name="수량"          width=50   align=right sumtext=@sum  </FC>' 
                     + '<FC>id=SALE_AMT         name="판매금액"       width=80   align=right sumtext=@sum </FC>'
                     + '<FC>id=SALE_GBN         name="구분"          width=84    align=left show=false</FC>'
                     + '<FC>id=SALE_PART_CD     name="부서"          width=84    align=left show=false</FC>'
                     + '<FC>id=ISSUE_TYPE       name="발행형태"       width=90   align=right  Edit=none Show=false  </FC>'
                     + '<FC>id=SALE_STR       name="판매점"          width=90   align=right  Edit=none  Show=false  </FC>'
                     + '<FC>id=SALE_DT       name="판매일자"         width=90   align=right  Edit=none  Show=false  </FC>'
                     + '<FC>id=STAT_FALG_NM       name="상태정보"         width=70   align=left  Edit=none  </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";      
    DS_O_MASTER.SubSumExpr  = "GIFT_AMT_TYPE"; 
    DS_O_MASTER.UseChangeInfo = false; 

    
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=25   align=center Edit=none</FC>'
    	+ '<FC>id=CHK_ID            name="삭제"          width=50   align=center HeadCheckShow="true" EditStyle="CheckBox"</FC>' 
    	 + '<FC>id=GIFT_TYPE_CD     name="상품권"        width=84   align=left Show=false </FC>'
         + '<FC>id=GIFT_TYPE_NAME   name="상품권종류"     width=84   align=left Show=false </FC>'
         + '<FC>id=GIFT_AMT_TYPE    name="금종코드"       width=80   align=left Show=false </FC>'
         + '<FC>id=GIFT_AMT_NAME    name="상품권 명"      width=110   align=left  Edit=none </FC>'
         + '<FC>id=GIFTCARD_NO      name="상품권코드"     width=130   align=center  Edit=none  SumText="합계"    </FC>' 
         + '<FC>id=SALE_QTY         name="수량"          width=70   align=right  Edit=none sumtext=@sum </FC>'
         + '<FC>id=SALE_AMT         name="판매금액"       width=90   align=right  Edit=none sumtext=@sum </FC>';
          
        
    initGridStyle(GD_DETAIL, "common", hdrProperies1, true);
    GD_DETAIL.ViewSummary = "1";
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
     // DS_O_RESULT.ClearData();
     
    // var strStrCd      = LC_S_STR_CD.BindColVal;    // 점코드
     var strStrCd = EM_I_SALE_SLIP_NO2.Text.substring(0,2);;
     var strPosSale    = EM_I_POS_SALE.Text;        //POS영수증번호
     var strSaleSlip   = EM_I_SALE_SLIP_NO.Text;    //원거래 상품권 매출번호
//alert(strSaleSlip);
     var goTo       = "getMaster";
     var action     = "O"; 
     var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
                    + "&strPosSale="   + encodeURIComponent(strPosSale)
                    + "&strSaleSlip="  + encodeURIComponent(strSaleSlip); 
     
     TR_MAIN.Action   = "/mss/mgif303.mg?goTo=" + goTo + parameters;
     TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_MASTER=DS_O_MASTER)";
     TR_MAIN.Post();
  
     // 조회결과 Return
     setPorcCount("SELECT", GD_MASTER);  
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 if (DS_O_DETAIL.IsUpdated || DS_O_MASTER.IsUpdated) {
	        if (showMessage(Question, YesNo, "USER-1050") != "1") {
	      //      DS_MASTER.RowPosition = gv_preRownoMaster;
	       //     DS_DETAIL.RowPosition = gv_preRownoDetail;
	        	return;
	        } 
	    }  
	DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    
    LC_S_STR_CD.Enable = true;
    EM_I_SALE_SLIP_NO2.Text = "";
    EM_I_SALE_DT.Text =""; 
    
    LC_S_STR_CD.Focus();
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
	 if (!DS_O_DETAIL.IsUpdated){
        showMessage(StopSign, OK, "USER-1028");
        return;
    }
         
    var strToday = getTodayFormat("YYYYMMDD");
    
    if(EM_S_SALE_DT.Text < strToday) {
        showMessage(StopSign, OK, "USER-1000", "판매반품일자는 오늘보다 이전일 수 없습니다.");
        EM_S_SALE_DT.Text = getTodayFormat("YYYYMMDD");
        return;
    }
    
  //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
        GD_DETAIL.Focus();
        return;
    }
   
    var strSaleDt = EM_S_SALE_DT.Text;
    var strStrCd  = LC_S_STR_CD.BindColVal;     // 점   
    var strWonStrCd = EM_I_SALE_SLIP_NO2.Text.substring(0,2);
    var strWonSaleDt = EM_I_SALE_SLIP_NO2.Text.substring(3,11);
    var strWonSlipCd = EM_I_SALE_SLIP_NO2.Text.substring(12,18);  
    var strSaleFlag = "";
    
    // 영수증이 정상 판매일경우 반품 영수증의 구분값은  10으로 저장
	if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_FLAG") == "01") {
		strSaleFlag = "10";
	}
    // 영수증이 특판일 경우 반품 영수증의 구분값은 11로 저장
	else if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_FLAG") == "02") {
		strSaleFlag = "11"; 
	}
	// 영수증이 교환일 경우 반품 영수증의 구분값은 13로 저장
	else if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_FLAG") == "03") {
		strSaleFlag = "13"; 
	}
    
    var strCnt = 0;
    for(var i=1; i <= DS_O_MASTER.CountRow; i++) { 
    	DS_O_MASTER.UserStatus(i) = 1;
    	if(DS_O_MASTER.NameValue(i,"SALE_GBN") == "F"){
    		strCnt += 1;
    	}
    }
    alert(strCnt);
    
    var goTo = "save";
    var parameters = "&strSaleDt="    + encodeURIComponent(strSaleDt) 
                   + "&strStrCd="     + encodeURIComponent(strStrCd)
                   + "&strWonStrCd="  + encodeURIComponent(strWonStrCd)
                   + "&strWonSaleDt=" + encodeURIComponent(strWonSaleDt)
                   + "&strWonSlipCd=" + encodeURIComponent(strWonSlipCd)
                   + "&strCnt="       + encodeURIComponent(strCnt)
                   + "&strSaleFlag="  + encodeURIComponent(strSaleFlag); 
    
    TR_MAIN.Action = "/mss/mgif303.mg?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_O_MASTER=DS_O_MASTER)";
    TR_MAIN.Post();
   
    if(TR_MAIN.ErrorCode == 0){
    	 DS_O_MASTER.ClearData();
   	    DS_O_DETAIL.ClearData();
   	    LC_S_STR_CD.Enable = true;
   	    EM_I_SALE_SLIP_NO2.Text = "";
   	    EM_I_SALE_DT.Text =""; 
   	    
   	    LC_S_STR_CD.Focus();
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

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행삭제
 * return값 : void
 */

function delRow() {
    if(DS_O_DETAIL.CountRow == 0){
        showMessage(StopSign, OK, "USER-1019");
           return;
       }
    var chkCnt = 0;
    
    for(var k=1; k <= DS_O_DETAIL.CountRow; k++) {
    	if(DS_O_DETAIL.NameValue(k,"CHK_ID") == "T") {
    		chkCnt++;
    	}
    }
    if(chkCnt <1) { 
        showMessage(StopSign, OK, "USER-1019");
        return;
    }
    
    for(var j=1; j <= DS_O_DETAIL.CountRow; j++) {
    	if(DS_O_DETAIL.NameValue(j,"CHK_ID") == "T") {
    		 for(var i=1; i <= DS_O_MASTER.CountRow; i++) {
    		        if(DS_O_MASTER.NameValue(i,"GIFTCARD_NO") == DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFTCARD_NO")) {
    		            DS_O_MASTER.NameValue(i,"SALE_GBN") = "F";
    		            DS_O_MASTER.ResetStatus();
    		        }
    		    }
    		    DS_O_DETAIL.DeleteRow(DS_O_DETAIL.RowPosition);
    	}

    }
   
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getSaleSlip()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-11
  * 개    요 : 원거래내역 조회
  * return값 : void
  */
 function getSaleSlip() {
	 if(DS_O_MASTER.CountRow > 1){  
           var ret = showMessage(Question, YesNo, "USER-1000", "조회된 내역이 있습니다. 조회하시겠습니까?");
           if (ret != "1") {
           //	DS_O_MASTER.RowPosition = gv_preRowno;
               return;
           }
	    } 
	 
	 if(EM_I_POS_SALE.Text == "" && EM_I_SALE_SLIP_NO.Text == "") {
		 showMessage(INFORMATION, OK, "USER-1000", "POS영수증번호 또는 원거래 상품권 매출번호를 입력하셔야 합니다.");
         return;
	 }
	 
	 // 원거래 상품권 매출번호 조회시  판매점 코드 체크 
	 if(EM_I_SALE_SLIP_NO.Text != "" && LC_S_STR_CD.BindColVal != EM_I_SALE_SLIP_NO.Text.substring(0,2)) {
         showMessage(INFORMATION, OK, "USER-1000", "원거래 상품권 매출번호를 확인해주세요.");
         return;
     }
	 // 
	 DS_O_RESULT.ClearData();
	 
	 var strStrCd      = LC_S_STR_CD.BindColVal;    // 점코드
	 var strPosSale    = EM_I_POS_SALE.Text;        //POS영수증번호
	 var strSaleSlip   = EM_I_SALE_SLIP_NO.Text;    //원거래 상품권 매출번호
	 var goTo       = "getSaleSlip";
	 var action     = "O";
	 var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
	                + "&strPosSale="   + encodeURIComponent(strPosSale)
	                + "&strSaleSlip="  + encodeURIComponent(strSaleSlip);

	 TR_MAIN.Action   = "/mss/mgif303.mg?goTo=" + goTo + parameters;
	 TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_RESULT=DS_O_RESULT)";
	 TR_MAIN.Post();

     EM_I_SALE_SLIP_NO2.Text = DS_O_RESULT.NameValue(1,"SALE_SLIP");
     EM_I_SALE_DT.Text = DS_O_RESULT.NameValue(1,"SALE_DT");
	 
	 if(DS_O_RESULT.CountRow == "0") {
		 showMessage(INFORMATION, OK, "USER-1000", "정상적인 원거래가 아닙니다.");
		 return;
	 } else {
		 if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"CANCEL_GB") == "1") {
			 showMessage(INFORMATION, OK, "USER-1000", "이미 반품된 영수증 입니다.");
			 EM_I_POS_SALE.Text = "";
			 EM_I_SALE_SLIP_NO.Text = "";
             EM_I_SALE_SLIP_NO2.Text = "";
             EM_I_SALE_DT.Text = ""; 
			 setTimeout("EM_I_POS_SALE.Focus()",50); 
	         return;
		 }
		 else {
			 // 원거래 조회시 점코드 수정불가 
			 LC_S_STR_CD.Enable = false;
			 btn_Search();
			 EM_I_POS_SALE.Text = "";
			 EM_I_SALE_SLIP_NO.Text = "";
		 } 
	 }
}

 /**
  * getGiftCardNo()
  * 작 성 자 : 김정민 
  * 작 성 일 : 2011-04-11
  * 개    요 : 상품권판매M 조회
  * return값 : void
  */
function getGiftCardNo() { 
	  var strGiftCardNo = EM_S_GIFT_NO.Text;
	  var strSlipNo = EM_I_SALE_SLIP_NO2.Text.replace(/-/g,''); 
	  var goTo       = "getGiftCardNo";
	  var action     = "O";
	  var parameters = "&strGiftCardNo="    + encodeURIComponent(strGiftCardNo)
	                 + "&strSlipNo="        + encodeURIComponent(strSlipNo);

	  TR_MAIN.Action   = "/mss/mgif303.mg?goTo=" + goTo + parameters;
	  TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_SELECT=DS_SELECT)";
	  TR_MAIN.Post();
	//rt(DS_SELECT.CountRow);

	  if(DS_SELECT.CountRow == "0") {
		  showMessage(INFORMATION, OK, "USER-1000", "상품권 판매 내역이 없는 상품권 번호입니다.");
		  EM_S_GIFT_NO.Text = "";
		  setTimeout("EM_S_GIFT_NO.Focus();", 50); 
	      return;
	  }
	  else { 
		  if(DS_SELECT.NameValue(DS_SELECT.RowPosition,"STAT_FLAG")!= "06" || DS_SELECT.NameValue(DS_SELECT.RowPosition,"ACDT_FLAG")!="N") {
			  showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "상품권 번호의 상태가 반품할 수 없는 상태 입니다.");
			  EM_S_GIFT_NO.Text = "";
	          setTimeout("EM_S_GIFT_NO.Focus();", 50); 
	          return;
		  } 
		  else { 
			  //DS_O_DETAIL.ClearData(); 
			     for(var j=0; j <= DS_O_DETAIL.CountRow; j++) {
			    	 if(DS_O_DETAIL.NameValue(j,"GIFTCARD_NO") == DS_SELECT.NameValue(DS_SELECT.RowPosition,"GIFTCARD_NO")) {
			    		  showMessage(INFORMATION, OK, "USER-1000", "상품권 번호가 중복 됩니다.");
			              EM_S_GIFT_NO.Text = "";
			              setTimeout("EM_S_GIFT_NO.Focus();", 50); 
			              return;
			    	 }
			     }
			              DS_O_DETAIL.AddRow();
			              
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"SALE_SEQ_NO") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"SALE_SEQ_NO");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_CD") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"GIFT_TYPE_CD");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_TYPE_NAME") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"GIFT_TYPE_NAME");          
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_TYPE") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"GIFT_AMT_TYPE");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFT_AMT_NAME") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"GIFT_AMT_NAME");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"GIFTCARD_NO") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"GIFTCARD_NO");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"SALE_QTY") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"SALE_QTY");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"SALE_AMT") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"SALE_AMT");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"ISSUE_TYPE") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"ISSUE_TYPE");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"SALE_STR") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"SALE_STR");
			              DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"SALE_DT") = DS_SELECT.NameValue(DS_SELECT.RowPosition,"SALE_DT");
 
			              for(var i=1; i <= DS_O_MASTER.CountRow; i++) {
			                  
			                 if (DS_O_MASTER.NameValue(i,"GIFTCARD_NO") == DS_SELECT.NameValue(DS_SELECT.RowPosition,"GIFTCARD_NO")) {
			                 //    alert(DS_O_MASTER.NameValue(i,"GIFTCARD_NO"));
			                     DS_O_MASTER.NameValue(i,"SALE_GBN") = "T";
			                     DS_O_MASTER.ResetStatus();
			                 }
			              }

			              EM_S_GIFT_NO.Text = "";
			              setTimeout("EM_S_GIFT_NO.Focus();", 50); 
			
		  }

	  }
}

/**
 * oz_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-05-09
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function oz_Print(pVal) {
	 var params   = "&strSaleNo="+ pVal;
	 window.open("/mss/mgif305.mg?goTo=print"+params, "OZREPORT", 1000, 700);     
}


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
        
        //if(TR_MAIN.SrvErrMsg('UserMsg',i).indexOf(":") > -1){
        	//oz_Print(TR_MAIN.SrvErrMsg('UserMsg',i).substring(8,26));
        	//alert(TR_MAIN.SrvErrMsg('UserMsg',i).substring(8,26));
        //}	
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=javascript  for=GD_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>
//헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_O_DETAIL.CountRow; i++){ 
          DS_O_DETAIL.NameValue(i, "CHK_ID") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_O_DETAIL.CountRow; i++){
        	DS_O_DETAIL.NameValue(i, "CHK_ID") = 'F';
        }
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- MASTER 정렬 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>
<!-- DETAIL 정렬 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>

<script language=JavaScript for=EM_S_GIFT_NO event=onKillFocus()>
    if(EM_S_GIFT_NO.Text.length > "0") {
     	if(DS_O_MASTER.CountRow == "0") {
            showMessage(INFORMATION, OK, "USER-1000", "원거래내역을 검색한 후 입력하세요");
            EM_S_GIFT_NO.Text = "";
            setTimeout("EM_S_GIFT_NO.Focus()",50); 
            return;
        }
    	
    	if(EM_S_GIFT_NO.Text.length != 12 && EM_S_GIFT_NO.Text.length != 13 && EM_S_GIFT_NO.Text.length != 16 && EM_S_GIFT_NO.Text.length != 18) {
    		showMessage(INFORMATION, OK, "USER-1000", "12,13,16,18자리로 입력 하셔야 합니다.");
            EM_S_GIFT_NO.Text = "";
            setTimeout("EM_S_GIFT_NO.Focus()",50); 
            return;
    	} 
    }
    
</script> 

<!-- <script language=JavaScript for=EM_S_GIFT_NO event=onKeyUp(kcode,scode)> -->
<script	language=JavaScript	for=EM_S_GIFT_NO event=OnKillFocus()>
	//사품권번호입력후
	
	if(this.Text ==	undefined) return;
	if(this.Text ==	"") return;

	if (!strKey) return;

    if (EM_S_GIFT_NO.Text.length == 12 || EM_S_GIFT_NO.Text.length == 12 || EM_S_GIFT_NO.Text.length == 18){
    	strKey = false;
    // alert();
//        if(kcode == "13" || kcode == "9") {
//     	   strKey = true;
//     	   return;
//        }  
    	getGiftCardNo(); 
    	strKey = true;
    	return;
    }  
</script>

<script language=JavaScript for=EM_I_POS_SALE event=onKillFocus()>
    if(EM_I_POS_SALE.Text == "") {
    	return;
    } 
    if(EM_I_POS_SALE.Text.length < 24) { 
    	showMessage(INFORMATION, OK, "USER-1000", "24자리 입력 하셔야 합니다.");
    	EM_I_POS_SALE.Text = "";
    	setTimeout("EM_I_POS_SALE.Focus()",50); 
    	return;
    }
    else {
    	if(EM_I_SALE_SLIP_NO.Text != "") {
    		if(EM_I_SALE_SLIP_NO.Text.length < 16 ) {
    			showMessage(INFORMATION, OK, "USER-1000", "16자리 입력 하셔야 합니다.");
    			EM_I_SALE_SLIP_NO.Text = "";
    			setTimeout("EM_I_SALE_SLIP_NO.Focus()", 50);
    	        return;
    		}
    	} 
    }
</script>

<script language=JavaScript for=EM_I_SALE_SLIP_NO event=onKillFocus()>
    if(EM_I_SALE_SLIP_NO.Text == "") {
    	return;
    }
    
    if(EM_I_SALE_SLIP_NO.Text.length <16) {
    	showMessage(INFORMATION, OK, "USER-1000", "16자리 입력 하셔야 합니다.");
    	EM_I_SALE_SLIP_NO.Text = "";
    	setTimeout("EM_I_SALE_SLIP_NO.Focus()", 50);
        return;
    }
    else {
    	if(EM_I_POS_SALE.Text != "") {
    		if(EM_I_POS_SALE.Text.length < 24) {
    	        showMessage(INFORMATION, OK, "USER-1000", "24자리 입력 하셔야 합니다.");
    	        EM_I_POS_SALE.Text = "";
    	        setTimeout("EM_I_POS_SALE.Focus()", 50);
    	        return;
    	    }
    	}
    }
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
<comment id="_NSID_">
<object id="DS_S_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>



<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SELECT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STR_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_AREA_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_MNG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_USE_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--  =============== 공통 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STORE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script> 
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script> 
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							tabindex=1 width=140 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
						</td>
						<th width="80" class="point">판매반품일자</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_S_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=120
							align="absmiddle" tabindex=1
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" id="btndate1"
							align="absmiddle" onclick="javascript:openCal('G',EM_S_SALE_DT)" />
						</td>
						<th width="80" class="point">등록자</th>
						<td><comment id="_NSID_"> <object id=EM_S_REG_ID
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><!--  원거래 조회 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="120">POS 영수증번호</th>
						<td width="230"><comment id="_NSID_"> <object
							id=EM_I_POS_SALE classid=<%=Util.CLSID_EMEDIT%> width=230
							tabindex=1 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script></td>
						<th width="150">원거래 상품권 매출번호</th>
						<td><comment id="_NSID_"> <object
							id=EM_I_SALE_SLIP_NO classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img id=IMG_SLIP_NO src="/pot/imgs/btn/transaction_search.gif"
							onclick="javascript:getSaleSlip();" class="PR03"
							align="absmiddle" /></td>
					</tr>
				</table>
				</td>
			</tr>
			<!--  그리드의 구분dot & 여백  -->
			<tr height=5>
				<td></td>
			</tr>
			<tr>
				<td class="dot"></td>
			</tr>
			<!--  그리드의 구분dot & 여백  -->
			<tr>
				<!-- 원거래/ 반품 내역 -->
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="300"><!--  원거래 내역 -->
						<table width="300" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title" width="100"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" />원거래 내역</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="100">상품권 매출번호</th>
										<td colspan=3><comment id="_NSID_"><object
											id=EM_I_SALE_SLIP_NO2 classid=<%=Util.CLSID_EMEDIT%>
											width=140 tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="80">매출일자</th>
										<td colspan=3><comment id="_NSID_"><object
											id=EM_I_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=140
											tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td class="PT01 PB03">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"><OBJECT id=GD_MASTER
											width=100% height=405 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_O_MASTER">
										</OBJECT></comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
						<td width=5></td>
						<td valign="top"><!-- 반품내역 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" />반품내역</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0"
											class="s_table">
											<tr>
												<th width="80">상품권번호</th>
												<td colspan=3><comment id="_NSID_"><object
													id=EM_S_GIFT_NO classid=<%=Util.CLSID_EMEDIT%> width=200
													tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>
												</td>
											</tr>
										</table>
										</td>
										<td class="right"><img
											src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"  onclick="delRow();"/>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td class="PT01 PB03">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
											width=100% height=430 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_O_DETAIL">
										</OBJECT></comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

