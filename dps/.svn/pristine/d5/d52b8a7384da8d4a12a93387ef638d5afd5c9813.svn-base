<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> POS 메세지 관리
 * 작 성 일 : 2010.01.19
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS 영수증 메세지를 관리한다
 * 이    력 :
 *        2010.01.19 (정진영) 신규작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfMasterRowPosition = 1;
 var newMasterYn = false;
 
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
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //메시지 상세

    // EMedit에 초기화( gauce.js )
    initEmEdit(EM_MSG_EXPL, "GEN^40",  NORMAL);  //메세지설명
    
    //콤보 초기화 ( gauce.js )
    initComboStyle(LC_STR,DS_I_STR          , "CODE^0^30,NAME^0^140" , 1, NORMAL);  //점(조회)
    initComboStyle(LC_MSG_FLAG,DS_I_MSG_FLAG, "CODE^0^30,NAME^0^110", 1, NORMAL);  //메세지구분(조회)
    initComboStyle(LC_USE_YN,DS_I_USE_YN    , "CODE^0^30,NAME^0^80" , 1, NORMAL);  //사용여부(조회)
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_I_USE_YN"  , "D", "D022", "Y");
    getEtcCode("DS_I_MSG_FLAG", "D", "P018", "Y");    
    getEtcCode("DS_O_MSG_FLAG", "D", "P018", "N");
    getEtcCode("DS_O_PRT_FLAG", "D", "P060", "N");
    
    //점콤보 가져오기 ( popup_dps.js )
    getStore("DS_O_STR", "N", "1", "N");
    getStore("DS_I_STR", "N", "1", "Y");

    // 전점 추가(gauce.js )
    insComboData(LC_STR,"**","전점");
    DS_O_STR.AddRow();
    DS_O_STR.NameValue(DS_O_STR.CountRow, "CODE") = "**";
    DS_O_STR.NameValue(DS_O_STR.CountRow, "NAME") = "전점";
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR     ,"%");
    LC_STR.Index=0;
    
    setComboData(LC_MSG_FLAG,"%");
    setComboData(LC_USE_YN  ,"%");

    //조회
    //searchMaster();
    //searchDetail();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    //argument[0] : Program ID
    //argument[1] : 변경여부 확인 대상 데이터셋 ','로 구분
    //registerUsingDataset("tcom101","DS_IO_DETAIL,DS_O_DETAIL")
    registerUsingDataset("pcod803","DS_IO_DETAIL,DS_IO_MASTER" );
    
    LC_STR.Focus();
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}   name="NO"          width=30    align=center  edit="none" </FC>'
                     + '<FC>id=STR_CD     name="*점  "          width=135   align=left    EditStyle=Lookup   Data="DS_O_STR:CODE:NAME"</FC>'
                     + '<FC>id=MSG_ID     name="메세지ID"     width=60   align=center  edit="none"</FC>'
                     + '<FC>id=MSG_EXPL   name="*메세지설명 "   width=380  align=left    </FC>'
                     + '<FC>id=MSG_FLAG   name="*메세지구분 "   width=110  align=left    EditStyle=Lookup   Data="DS_O_MSG_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=USE_YN     name="*사용여부 "     width=70   align=left  EditStyle=Combo    Data="Y:YES,N:NO"</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}    name="NO"           width=30     align=center  edit="none" </FC>'
                     + '<FC>id=MSG_ID      name="메세지ID"      width=90    align=center  show="false" </FC>'
                     + '<FC>id=PRT_FLAG    name="*출력구분"     width=90     align=left    EditStyle=Lookup   Data="DS_O_PRT_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=MSG_NO      name="일련번호"     width=90     align=center  show="false" edit="none" </FC>'
                     + '<FC>id=SORT_NO     name="*출력순서"     width=90     align=right  </FC>'
                     + '<FC>id=PRT_MSG     name="*출력메세지"    width=480    align=left    </FC>'
                     + '<FC>id=USE_YN      name="*사용여부 "      width=90     align=left  EditStyle=Combo Data="Y:YES,N:NO"</FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
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
    if( DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1 ){
            GD_MASTER.Focus();
            return;
        }
    }
    searchMaster();
    
    if(DS_IO_MASTER.CountRow > 0)
        searchDetail();
    
    setPorcCount("SELECT",GD_MASTER);  
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
	//기존의 신규로우 존재 시 데이타 클리어 
    if( newMasterYn ) {
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
        	GD_MASTER.Focus();
            return;
        }
        DS_IO_DETAIL.ClearData();
        DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STR_CD") = "**";
        DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "MSG_FLAG") = "1";
        DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "USE_YN") = "Y";
        DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "MSG_EXPL") = "";
        bfMasterRowPosition = DS_IO_MASTER.CountRow;
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STR_CD");
        return;        
    }
	
    if( DS_IO_DETAIL.IsUpdated ){
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
        	GD_DETAIL.Focus();
            return;
        }
    }
    
    DS_IO_DETAIL.ClearData();
    DS_IO_MASTER.Addrow();
    DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "STR_CD") = "**";
    DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "MSG_FLAG") = "1";
    DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "USE_YN") = "Y";
    bfMasterRowPosition = DS_IO_MASTER.CountRow;
    newMasterYn = true;
    setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"STR_CD");

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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if(DS_IO_MASTER.CountRow < 1){
        	LC_STR.Focus();
        }else{
        	GD_MASTER.Focus();
        }
        return;
    }


    //1. validation Master 그리드 필수 입력 체크 ( 콤보 제외)
   	var nCnt       = 0;
	var strMsgFlag = "";
    for(var i=1; i<=DS_IO_MASTER.CountRow; i++ ) {
        //메세지설명
        if (DS_IO_MASTER.NameValue(i,"MSG_EXPL")=="" ) {
            // 메세지설명은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003","메세지설명");
            setFocusGrid(GD_MASTER, DS_IO_MASTER,i,"MSG_EXPL");
            return;
        }

		strMsgFlag = DS_IO_MASTER.NameValue(i, "MSG_FLAG");
		if(strMsgFlag == "1") nCnt++;
		
		// 메세지 등록 체크
		if(nCnt > 10){
			showMessage(EXCLAMATION, OK, "USER-1000","상단 메세지는 10건이상 등록할 수 없습니다.");
			return;
		}
        
        
        if( !checkInputByte( GD_MASTER, DS_IO_MASTER, i, 'MSG_EXPL', '메세지설명'))
            return;
        if( DS_IO_MASTER.RowStatus(i)=="1"){
        	if(DS_IO_DETAIL.CountRow < 1){
                showMessage(EXCLAMATION, OK, "USER-1000","메시지 상세를 1건 이상 입력하여야 합니다.");
                GD_DETAIL.Focus();
                return;
        		
        	}
        }
    }    
    
    
    //1. validation Detail 그리드 필수 입력 체크 (콤보제외)
    for(var i=1; i<=DS_IO_DETAIL.CountRow; i++ ) {
        //출력메세지
        if (DS_IO_DETAIL.NameValue(i,"PRT_MSG")=="" ) {
            // 출력메세지명은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003","출력메세지");
            setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"PRT_MSG");
            return;
        }
        //출력순서
        if (DS_IO_DETAIL.NameValue(i,"SORT_NO")<1 ) {
            // 출력순서은/는  0 보다 커야해야 합니다.
            showMessage(Information, OK, "USER-1008","출력순서","0");
            setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"SORT_NO");
            return;
        }
        //출력구분에 따른 출력메세지 크기 제한
        if (DS_IO_DETAIL.NameValue(i,"PRT_FLAG")=="3" 
            || DS_IO_DETAIL.NameValue(i,"PRT_FLAG")=="4" ) {
            var prtMsg = DS_IO_DETAIL.NameValue(i,"PRT_MSG");
            if( getByteValLength(prtMsg) > 21 ) {
                showMessage(Information, OK, "USER-1000","[출력구분]이  가로 두배 일 경우<br> [출력메세지]는 [영문(21),한글(10)]자리 이하입니다.");
                setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"PRT_MSG");
                return;
            }
        }

        if( !checkInputByte( GD_DETAIL, DS_IO_DETAIL, i, 'PRT_MSG', '출력메세지'))
            return;
        
    }    
    // Detail 그리드 출력순서 중복체크
    var dupRow = checkDupKey(DS_IO_DETAIL, "SORT_NO");
    if (dupRow > 0) {
        showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);
        
        DS_IO_DETAIL.NameValue(row, "SORT_NO")    = "";
        GD_DETAIL.SetColumn("SORT_NO");
        
        return false;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	GD_MASTER.Focus();
        return;
    }
    var msgId = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MSG_ID");
    
    TR_MAIN.Action="/dps/pcod803.pc?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();

    if(TR_MAIN.ErrorCode == 0){
        btn_Search();

        if(msgId != ""){
        	DS_IO_MASTER.RowPosition = DS_IO_MASTER.NameValueRow("MSG_ID",msgId);
        }else{
        	DS_IO_MASTER.RowPosition = DS_IO_MASTER.CountRow;
        }
    }
    GD_MASTER.Focus();
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
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function searchMaster(){

    newMasterYn = false;
    DS_IO_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
     
    var strStrCd   = LC_STR.BindColVal;
    var strMsgFlag = LC_MSG_FLAG.BindColVal;
    var strUseYn   = LC_USE_YN.BindColVal;
    var strMsgExpl = EM_MSG_EXPL.text;

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strMsgFlag="+encodeURIComponent(strMsgFlag)
                   + "&strUseYn="+encodeURIComponent(strUseYn)
                   + "&strMsgExpl="+encodeURIComponent(strMsgExpl);
    TR_MAIN.Action="/dps/pcod803.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

}

 /**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-12-31
 * 개    요 :  디테일 리스트 조회
 * return값 : void
 */
 function searchDetail(){

     DS_IO_DETAIL.ClearData();
     
     var strMsgId = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MSG_ID");
     
     var goTo       = "searchDetail" ;    
     var action     = "O";     
     var parameters = "&strMsgId="+encodeURIComponent(strMsgId);
     TR_MAIN.Action="/dps/pcod803.pc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_MAIN.Post();

     // 조회결과 Return
     setPorcCount("SELECT", GD_DETAIL);
 }

 /**
  * btn_Add1()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-01-25
  * 개    요 : 상세 그리드 Row추가 
  * return값 : void
*/
function btn_Add1(){
    if(DS_IO_MASTER.RowPosition > 0) {
        var masterUseYn = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"USE_YN");
        var masterMsgId = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MSG_ID");
        if( masterUseYn != 'Y') {
            showMessage(INFORMATION, OK, "GAUCE-1000", "[ "+masterMsgId+" ]는 사용되지 않는 메세지  코드입니다.");
            return;
        }
        DS_IO_DETAIL.Addrow();
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "MSG_ID") = masterMsgId;
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "PRT_FLAG") = "0";
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "USE_YN") = "Y";
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "SORT_NO") = DS_IO_DETAIL.CountRow;
        
        setFocusGrid(GD_DETAIL,DS_IO_DETAIL,DS_IO_DETAIL.CountRow,"PRT_MSG");
    }
}

/**
  * btn_Del1()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-01-25
  * 개    요 : 상세 그리드 Row 삭제 
  * return값 : void
*/
function btn_Del1(){
    var row = DS_IO_DETAIL.RowPosition;
    if( DS_IO_DETAIL.RowStatus(row) == "1")
        DS_IO_DETAIL.DeleteRow(row);
    else
    	showMessage(INFORMATION, OK, "USER-1052");
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
<script language=JavaScript for=DS_IO_MASTER event=OnLoadCompleted(rowcnt)>
    if(rowcnt > 0) {
    	DS_IO_MASTER.RowPosition = bfMasterRowPosition;
    }
</script>

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

</script>
<!-- 중복 체크-->
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>
<!--//데이터셋의 값이 변경되었을때 처리 루틴
    switch(colid){
        case "SORT_NO" :
            var dupRow = checkDupKey(DS_IO_DETAIL, "SORT_NO");
            if (dupRow > 0) {
                showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);
                
                DS_IO_DETAIL.NameValue(row, "SORT_NO")    = "";
                GD_DETAIL.SetColumn("SORT_NO");
                
                return false;
            }
            break;
        default :
            break;
    }
//-->
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>

    if( row < 1) {
    	sortColId( eval(this.DataID), row , colid );
    } else {

        if( bfMasterRowPosition == row)
            return;            
        if( DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated ) {
            if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
                DS_IO_MASTER.RowPosition = bfMasterRowPosition;
                return;
            }
        }
        DS_IO_MASTER.UndoAll();
        
        bfMasterRowPosition = row;        
        searchDetail();
    }
</script>
 
 
 

<!-- Grid master 상하키 event 처리 -->
<script language=JavaScript for=GD_MASTER event=onKeyPress(keycode)>
    if ((keycode == 38) || (keycode == 40)){
        if (DS_IO_MASTER.RowPosition > 0 && DS_IO_MASTER.RowPosition != DS_IO_MASTER.CountRow ){
            
            if( DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated ) {
                if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
                    DS_IO_MASTER.RowPosition = bfMasterRowPosition;
                    return;
                }
            }

            bfMasterRowPosition = DS_IO_MASTER.RowPosition;
            DS_IO_MASTER.UndoAll();
            searchDetail();
        }
    }
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    
    if (DS_IO_DETAIL.NameValue(row, "PRT_FLAG")=="3" 
        || DS_IO_DETAIL.NameValue(row,"PRT_FLAG")=="4" ) {
        GD_DETAIL.ColumnProp( "PRT_MSG", 'EditLimit') = 21;
    } else {
        GD_DETAIL.ColumnProp( "PRT_MSG", 'EditLimit' ) = 42;
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
<comment id="_NSID_"><object id="DS_I_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_MSG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MSG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PRT_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="80" >점</th>
            <td width="165" >
               <comment id="_NSID_">
                 <object id=LC_STR classid=<%= Util.CLSID_LUXECOMBO %> width=165 align="absmiddle" tabindex=1 >
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" >메세지구분</th>
            <td width="165" >
               <comment id="_NSID_">
                 <object id=LC_MSG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=165 align="absmiddle" tabindex=1 >
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" >사용여부</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=165 align="absmiddle" tabindex=1 >
                 </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
          <th>메세지설명</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_MSG_EXPL classid=<%=Util.CLSID_EMEDIT%>  width=694  align="absmiddle" tabindex=1 class="input">
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
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=225 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_IO_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 메시지 상세</td>
               <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif" onclick="javascript:btn_Add1();" hspace="2" /><img src="/<%=dir%>/imgs/btn/del_row.gif"  onclick="javascript:btn_Del1();" /></td>
           </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_DETAIL width=100% height=224 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_IO_DETAIL">
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
 </tr>
 </table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

