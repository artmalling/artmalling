<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 자사 상품권 종류마스터 등록
 * 작 성 일 : 2011.01.14
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.14 (김성미) 신규작성
 *        2011.03.24 (김성미) 프로그램 작성
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
var strIssueType = "";
var btnSaveClick = false;
var strCurRow = 0;
var strGiftTypeIndex = 0;

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
 var top2 = 120;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_GIFT_FLAG, "GEN", READ);            //상품권종류구분 코드
    initEmEdit(EM_S_GIFT_FLAG_NM, "GEN", READ);         //상품권종류구분 명

    //콤보 초기화
    initComboStyle(LC_S_GIFT_TYPE,DS_O_GIFT_TYPE_CD, "CODE^0^50,NAME^0^100", 1, NORMAL);         //상품권 종류

    getGiftCommCode("issue");
    getGiftCommCode("flag");
    getGiftCommCode("type");
    getGiftCommCode("pummok");
    LC_S_GIFT_TYPE.Index = 0;
    strIssueType = DS_O_ISSUE_TYPE.NameValue(1,"CODE");
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif101", "DS_IO_MASTER,DS_IO_DETAIL");   
}

function gridCreate(){
    var hdrProperies = '<FC>id={currow}			name="NO"			width=30	align=center</FC>'
                     + '<FC>id=GIFT_TYPE_CD		name="*상품권종류"	width=80	align=center	Edit={IF(SysStatus="I","true","false")}  EditLimit=1	</FC>'
                     + '<FC>id=GIFT_TYPE_NAME	name="*상품권종류명"	width=100	align=center	EditLimit=40</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
    var hdrProperies1 =
    	  '<FC>id={currow}    		name="NO"			width=30   	align=center					</FC>'
        + '<FC>id=ISSUE_TYPE_NM     name="*발행형태"		width=70   	align=center	edit=none		</FC>'
        + '<FC>id=GIFT_AMT_TYPE    	name="*금종코드"		width=70	align=center	Edit={IF(CONF_FLAG="N","true","false")}	 EditLimit=1		</FC>'
        + '<FC>id=GIFT_AMT_NAME    	name="*금종명"		width=100	align=center															EditLimit=40	</FC>'
        + '<FC>id=GIFTCERT_AMT    	name="*상품권금액" 	width=80	align=center	Edit={IF(CONF_FLAG="N","true","false")}	edit=numeric	EditLimit=9		</FC>'
        + '<FC>id=RFD_PERMIT_RATE   name="*환불허용율"	width=80	align=center	Edit={IF(CONF_FLAG="N","true","false")}	edit=numeric	EditLimit=3		</FC>'
        + '<FC>id=PUMMOK_CD         name="*품목"  		width=80	align=center	Edit={IF(CONF_FLAG="N","true","false")}					EditStyle=lookup	Data="DS_O_PUMMOK:CODE:NAME"  </FC>'
        + '<FC>id=USE_YN    		name="사용여부"		width=80	align=center 															EditStyle=CheckBox</FC>'
        + '<FC>id=CONF_FLAG			name="확정구분"		width=50	align=center	show=false	</FC>';
        
        initGridStyle(GD_DETAIL, "common", hdrProperies1, true);
}


/*************************************************************************
 * edit={if(GIFT_AMT_TYPE = "", "true" , "false")

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
 * 작 성 일 : 2011-03-23
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	var goTo       = "getMaster";
    var parameters = "&strGiftTypeFlag="+encodeURIComponent(EM_S_GIFT_FLAG.Text)
                   + "&strGiftTypeCd="  +encodeURIComponent(LC_S_GIFT_TYPE.BindColVal);
    TR_MAIN.Action="/mss/mgif101.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
   
    if(strCurRow != 0) DS_IO_MASTER.RowPosition = strCurRow;
    
    strCurRow = 0;
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
    
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-24
 * 개    요 : 상품권 종류 정보 행추가
 * return값 : void
 */
function btn_New() {
	var row = DS_IO_MASTER.CountRow; 
	// 행추가가 되어 있는경우 메세지 처리
	if(DS_IO_MASTER.NameValue(row, "GIFT_TYPE_CD") == ""){
		if(showMessage(QUESTION , YESNO, "USER-1072") != 1 ){
			setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.CountRow, "GIFT_TYPE_NAME");
            return;
        }
		DS_IO_MASTER.DeleteRow(row); 
	}
	DS_IO_MASTER.AddRow();
	setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.CountRow, "GIFT_TYPE_NAME");
	
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
 * 작 성 일 : 2011-03-25
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated && !DS_IO_DETAIL.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
    if(DS_IO_MASTER.CountRow  == 0 && DS_IO_DETAIL.CountRow  == 0){
          //저장할 내용이 없습니다
            showMessage(EXCLAMATION , OK, "USER-1028");
            return;
     }
    
    if(DS_IO_DETAIL.CountRow  == 0){
        //저장할 내용이 없습니다
          showMessage(EXCLAMATION , OK, "USER-1000", "금종정보를 추가해주세요.");
          return;
   }
    
    if(getByteValLength(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_NAME")) > 40){
    	showMessage(EXCLAMATION , OK, "USER-1020" , "상품권종류명", "40Byte");
    	setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "GIFT_TYPE_NAME");
        return;
    }
    
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_NAME") == ""){
        showMessage(EXCLAMATION , OK, "USER-1003" , "상품권종류명");
        setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "GIFT_TYPE_NAME");
        return;
    }
    
    if(!checkDSBlank(GD_DETAIL, "1,3,4")) return;
    
    for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
    	if(DS_IO_DETAIL.NameValue(i,"RFD_PERMIT_RATE") == "" || DS_IO_DETAIL.NameValue(i,"RFD_PERMIT_RATE") == 0){
    		showMessage(EXCLAMATION , OK, "USER-1008" , "환불허용율", "0");
            setFocusGrid(GD_DETAIL, DS_IO_DETAIL, i, "RFD_PERMIT_RATE");
            return;
    	}
        if(getByteValLength(DS_IO_DETAIL.NameValue(i, "GIFT_AMT_NAME")) > 40){
   	        showMessage(EXCLAMATION , OK, "USER-1020" , "금종명", "40Byte");
   	        setFocusGrid(GD_DETAIL, DS_IO_DETAIL, i, "GIFT_AMT_NAME");
   	        return;
   	    }
    }
    
    if(!checkDSBlank(GD_DETAIL, "5,6")) return;
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    
    btnSaveClick = true;
    strCurRow = DS_IO_MASTER.RowPosition;
    TR_MAIN.Action="/mss/mgif101.mg?goTo=save"; 
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";  
    TR_MAIN.Post();
    btnSaveClick = false;
    if(TR_MAIN.ErrorCode == 0){
    	getGiftCommCode("type");
    	LC_S_GIFT_TYPE.Index = strGiftTypeIndex;
    	btn_Search();
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
 * getGiftCommCode()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-24
 * 개    요 : 상품권공통코드 조회  : flag => 상품권종류 구분, type => 상품권 종류, amt => 금종코드
 * return값 : void
 */

function getGiftCommCode(strFlag) {
    var strDataSet = "";
    var strCondi = "";
    switch(strFlag){
      case "flag" :
           strDataSet = "DS_O_GIFT_TYPE_FLAG";
           break;
      case "type" :
           strDataSet = "DS_O_GIFT_TYPE_CD";
           strCondi = DS_O_GIFT_TYPE_FLAG.NameValue(1,"CODE");
           break;
      case "issue" :
          strDataSet = "DS_O_ISSUE_TYPE";
          strCondi = LC_S_GIFT_TYPE.BindColVal;
          break
      case "pummok" :
          strDataSet = "DS_O_PUMMOK";
          break
    }
    
    var goTo       = "getGiftCommCode";
    var parameters = "&strFlag="    + encodeURIComponent(strFlag)
                   + "&strDataSet=" + encodeURIComponent(strDataSet)
                   + "&strCondi="   + encodeURIComponent(strCondi);
	TR_MAIN.Action="/mss/mgif101.mg?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue="SERVLET(O:"+strDataSet+"="+strDataSet+")"; 
	TR_MAIN.Post();
}
 
/**
 * getDetail()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-03-24
 * 개    요 : 금종정보 목록 조회
 * return값 : void
 */
function getDetail() {
	var goTo       = "getDetail";
    var parameters = "&strGiftTypeFlag="+DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFT_TYPE_CD")
                   + "&strIssueType="+ encodeURIComponent(strIssueType);
    TR_DTL.Action="/mss/mgif101.mg?goTo="+goTo+parameters;  
    TR_DTL.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_DTL.Post();
} 
 
 /**
  * addRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-24
  * 개    요 : 행추가
  * return값 : void
  */

function addRow() {
	  
	if(DS_IO_MASTER.CountRow == 0){
		return;
	}
    var row = DS_IO_DETAIL.CountRow; 
    // 필수입력 사항 체크 
   
    // 금종코드
	if(DS_IO_DETAIL.NameValue(row, "GIFT_AMT_TYPE") == ""){
		showMessage(EXCLAMATION , OK, "USER-1003" , "금종코드");
		setFocusGrid(GD_DETAIL, DS_IO_DETAIL, row, "GIFT_AMT_TYPE");
		return; 
	}
	// 금종명
	if(DS_IO_DETAIL.NameValue(row, "GIFT_AMT_NAME") == ""){
		showMessage(EXCLAMATION , OK, "USER-1003" , "금종명");
		setFocusGrid(GD_DETAIL, DS_IO_DETAIL, row, "GIFT_AMT_NAME");
	    return;
	}
	// 상품권금액
	if(DS_IO_DETAIL.NameValue(row, "GIFTCERT_AMT") == ""){
		showMessage(EXCLAMATION , OK, "USER-1003" , "상품권금액");
		setFocusGrid(GD_DETAIL, DS_IO_DETAIL, row, "GIFTCERT_AMT");
		return;
	    
	}
	// 환불 허용율
	if(DS_IO_DETAIL.NameValue(row, "RFD_PERMIT_RATE") == ""){
		showMessage(EXCLAMATION , OK, "USER-1008" , "환불허용율", "0");
		setFocusGrid(GD_DETAIL, DS_IO_DETAIL, row, "RFD_PERMIT_RATE");
	    return;
	}

    DS_IO_DETAIL.AddRow(); 

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "GIFT_TYPE_CD") = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"GIFT_TYPE_CD");
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "ISSUE_TYPE") = DS_O_ISSUE_TYPE.NameValue(1,"CODE");
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "ISSUE_TYPE_NM") = DS_O_ISSUE_TYPE.NameValue(1,"NAME");
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "USE_YN") = "T";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "CONF_FLAG") = "N";
        
    setFocusGrid(GD_DETAIL, DS_IO_DETAIL, DS_IO_DETAIL.CountRow, "GIFT_AMT_TYPE");
}
 
 /**
  * delRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-24
  * 개    요 : 행삭제
  * return값 : void
  */

	function delRow() {
		if(DS_IO_DETAIL.CountRow == 0){
			showMessage(EXCLAMATION , OK, "USER-1019");
			return;
		}
		if(DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "GIFT_AMT_TYPE") != ""){
			showMessage(EXCLAMATION , OK, "USER-1039");
			return;
		}
		DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
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
<script language=JavaScript for=TR_DTL event=onSuccess>
    for(i=0;i<TR_DTL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DTL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DTL event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
 if((DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated) && !btnSaveClick){
         if(showMessage(QUESTION , YESNO, "USER-1074") != 1 ){
             return false;
         }
         if(DS_IO_MASTER.NameValue(row,"GIFT_TYPE_CD") == ""){
             DS_IO_MASTER.DeleteRow(row);
             return true;
         }
         DS_IO_MASTER.NameValue(row,"GIFT_TYPE_NAME") = DS_IO_MASTER.OrgNameValue(row,"GIFT_TYPE_NAME");
         return true;
}
return true;
</script>
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(row == 0) return;
getDetail();
// 조회결과 Return
setPorcCount("SELECT", GD_DETAIL);
GD_MASTER.Focus();
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid, "DS_IO_DETAIL");
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
	if(row == 0) sortColId( eval(this.DataID), row, colid);
	/*
	if(DS_IO_DETAIL.SysStatus(DS_IO_DETAIL.RowPosition) == 1) {
		GD_DETAIL.ColumnProp('GIFT_AMT_TYPE', 'Edit') = "Any";
		GD_DETAIL.ColumnProp('GIFTCERT_AMT', 'Edit') = "Any";
		GD_DETAIL.ColumnProp('RFD_PERMIT_RATE', 'Edit') = "Any";
	} else {
		GD_DETAIL.ColumnProp('GIFT_AMT_TYPE', 'Edit') = "None";
		GD_DETAIL.ColumnProp('GIFTCERT_AMT', 'Edit') = "None";
		GD_DETAIL.ColumnProp('RFD_PERMIT_RATE', 'Edit') = "None";
	}
	
	GD_DETAIL.ColumnProp('GIFT_AMT_NAME', 'Edit') = "Any";
	*/

</script>

<script language=JavaScript for=GD_DETAIL event=CanColumnPosChange(row,colid)>
    switch(colid){
        case 'RFD_PERMIT_RATE': // 환불허용율 정합성검사
             if(DS_IO_DETAIL.NameValue(row, colid) > 100){
                 showMessage(EXCLAMATION , OK, "USER-1009", "환불 허용률1", "100");
                DS_IO_DETAIL.NameValue(row, colid) = 0;
                return false;
            }
        break;
    }
    return true;
</script>
<script language=JavaScript for=GD_DETAIL event=OnCloseUp(row,colid)>
// 현업 요청 사항 중복 데이터 체크하지 않음 2011.06.30
// switch(colid){
//	 case 'PUMMOK_CD':
//	     var strValue = DS_IO_DETAIL.NameValue(row,colid);
//	     for(var i=1;i<=DS_IO_DETAIL.CountRow;i++){
//	         if(row != i && strValue == DS_IO_DETAIL.NameValue(i, colid) && DS_IO_DETAIL.NameValue(i, colid) != ""){
//	              showMessage(EXCLAMATION , OK, "USER-1044");
//	              DS_IO_DETAIL.NameValue(row, colid) = "";
//	              return false; 
//	         }
//	     }            
//	     return true;;
//	 break;
//    }
//    return true; 
</script>

 <script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,olddata)>
 switch(colid){
        case 'RFD_PERMIT_RATE': // 환불허용율 정합성검사
        	if(!GD_DETAIL.FocusState){
        	     if(DS_IO_DETAIL.NameValue(row, colid) > 100){
        	         showMessage(EXCLAMATION , OK, "USER-1009", "환불 허용률2", "10022");
        	        DS_IO_DETAIL.NameValue(row, colid) = 0;
        	        return false;
        	    }
        	}
              break;
    }
    return true;
</script>

<script language=JavaScript for=LC_S_GIFT_TYPE event=OnCloseUp()>
strGiftTypeIndex = this.Index ;
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
<comment id="_NSID_"><object id="DS_O_GIFT_TYPE_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GIFT_TYPE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ISSUE_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PUMMOK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_DTL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>


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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" class="point">상품권종류구분</th>
            <td  width="190"> 
                   <comment id="_NSID_">
                        <object id=EM_S_GIFT_FLAG classid=<%=Util.CLSID_EMEDIT%>   width=60 tabindex=1>
                        </object>
                    </comment>
                    <script> _ws_(_NSID_);</script>
                    <comment id="_NSID_">
                         <object id=EM_S_GIFT_FLAG_NM classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1>
                         </object>
                      </comment>
                    <script> _ws_(_NSID_);</script>
            </td>
            <th width="80">상품권종류</th>
            <td> <commnet id="_NSID_">
                    <object id=LC_S_GIFT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 align="absmiddle">
                    </object>
                    </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
  <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td colspan=3>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>상품권종류 정보</td>
              </tr>
            </table>
        </td>
        <td class="right">
	    <img src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"  hspace="2" onClick="javascript:addRow();"/>
	    <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onClick="javascript:delRow();"/>
    </td>
    </tr>
    <tr>
     <td width="230">
        <!-- 상품권종류 정보 그리드 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=780 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_MASTER">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
          </tr>
        </table>
     </td>
     <td width=5></td>
     <td colspan=2>
        <!--  금종정보 그리드 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=780 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_DETAIL">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
          </tr>
        </table>
     </td>
    </tr>
    </table>
  </td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_O_GIFT_TYPE_FLAG>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>col=CODE            ctrl=EM_S_GIFT_FLAG        param=Text</c>
        <c>col=NAME            ctrl=EM_S_GIFT_FLAG_NM     param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>

