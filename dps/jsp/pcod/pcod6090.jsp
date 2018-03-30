<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 규격단품관리
 * 작 성 일 : 2010.03.10
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod6090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 규격단품정보를 관리한다
 * 이    력 :
 *        2010.03.10 (정진영) 신규작성
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
<%
	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfSearchPumbunCd;
 var bfMasterRow = 0;
 var btnSaveYn = false;
 var isOnPopup = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-10
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //점별단품정보

    // EMedit에 초기화
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6", PK);  //브랜드(조회)
    initEmEdit(EM_O_PUMBUN_NAME, "GEN", READ);  //브랜드(조회)
    initEmEdit(EM_O_SKU_CD, "CODE^13^0", PK);  //단품(조회)
    initEmEdit(EM_O_SKU_NAME, "GEN^40", NORMAL);  //단품(조회)

    //콤보 초기화
    initComboStyle(LC_O_STR_CD, DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, NORMAL);  //점(조회)
    initComboStyle(LC_O_PUMMOK_CD, DS_O_PUMMOK, "CODE^0^70,NAME^0^100", 1, NORMAL);  //품목(조회)

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화 
    DS_O_PUMMOK.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    
    // 기본값 입력( gauce.js )
    // 품목
    insComboData( LC_O_PUMMOK_CD, "%", "전체", 1 );
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_PUMMOK_CD,"%");
    
    // 점코드  가져오기
    getStore("DS_O_STR_CD", "Y", "", "N");

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_BIZ_TYPE",    "D", "P002", "N");
    getEtcCode("DS_O_TAX_FLAG",    "D", "P004", "N");
    getEtcCode("DS_O_PUMBUN_TYPE", "D", "P070", "N");
    getEtcCode("DS_O_PLU_FLAG",    "D", "P081", "N");
    
    
    
    //조회후 결과표시 초기화
    setPorcCount("CLEAR");

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod609","DS_MASTER,DS_DETAIL" );

    LC_O_STR_CD.Index = 0;
    
    //시작시 포커스
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}             name="NO"          width=25     align=center</FC>'
                     + '<FC>id=PUMBUN_CD            name="브랜드코드"     width=100    align=center show=false</FC>'
    	             + '<FC>id=PUMBUN_NAME          name="브랜드명"       width=130    align=left</FC>'
                     + '<FC>id=VEN_CD               name="협력사코드"   width=100    align=center show=false</FC>'
    	             + '<FC>id=VEN_NAME             name="협력사명"     width=130    align=left</FC>'
                     + '<FC>id=SKU_CD               name="단품코드"     width=100    align=center</FC>'
                     + '<FC>id=SKU_NAME             name="단품명"       width=100    align=left</FC>'
                     + '<FC>id=PUMMOK_NAME          name="품목명"       width=100    align=left</FC>'
                     + '<FC>id=BIZ_TYPE             name="거래형태"     width=100    align=left EditStyle=Lookup data="DS_O_BIZ_TYPE:CODE:NAME"</FC>'
                     + '<FC>id=TAX_FLAG             name="과세구분"     width=100    align=left EditStyle=Lookup data="DS_O_TAX_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=PUMBUN_TYPE          name="브랜드유형"     width=100    align=left EditStyle=Lookup data="DS_O_PUMBUN_TYPE:CODE:NAME"</FC>'
                     + '<FC>id=PLU_FLAG             name="PLU구분"      width=100    align=left EditStyle=Lookup data="DS_O_PLU_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=BOTTLE_CD            name="공병코드"     width=100    align=left</FC>'
                     + '<FC>id=BOTTLE_NAME          name="공병상품명"   width=100    align=left</FC>'                     
                     + '<FC>id=ORIGIN_AREA_NAME     name="원산지"       width=100    align=left</FC>'
                     + '<FC>id=USE_YN               name="사용여부"     width=100    align=center</FC>'
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}           name="NO"            width=30   align=center Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=STR_CD             name="점"            width=80   edit="none" align=center   show=false</FC>'
                     + '<FC>id=SKU_CD             name="단품코드"       width=100  edit="none" align=center  show=false</FC>'
                     + '<FC>id=EVENT_CD           name="행사코드"       width=100   edit="none" align=center  Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=EVENT_NAME         name="행사명"         width=130  edit="none" align=left     Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=APP_S_DT           name="가격시작일"      width=100  edit="none" align=center  Color={decode(EVENT_CD,"00000000000","BLUE")} mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=APP_E_DT           name="가격시작일"      width=100  edit="none" align=center  Color={decode(EVENT_CD,"00000000000","BLUE")} mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=REU_RATE           name="할인율"          width=80  edit="none" align=right    Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=NORM_COST_PRC      name="정상원가단가"     width=100  edit="none" align=right  Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=NORM_SALE_PRC      name="정상매가단가"     width=100  edit="none" align=right  Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=NORM_MG_RATE       name="정상마진율"       width=100  edit="none" align=right  Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=SAL_COST_PRC       name="판매원가단가"     width=100  edit="none" align=right  Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=SALE_PRC           name="판매매가단가"     width=100  edit="none" align=right  Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     + '<FC>id=SALE_MG_RATE       name="판매마진율"       width=100  edit="none" align=right  Color={decode(EVENT_CD,"00000000000","BLUE")}</FC>'
                     ;

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
 * 작 성 일 : 2010-03-10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    
    var strStrCd      = LC_O_STR_CD.BindColVal;
    var strPumbunCd   = EM_O_PUMBUN_CD.Text;
    var strPummokCd   = LC_O_PUMMOK_CD.BindColVal;
    var strSkuCd      = EM_O_SKU_CD.Text;
    var strSkuName    = EM_O_SKU_NAME.Text;
    
    if( strPumbunCd == "" && strSkuCd == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드 또는 단품");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_O_PUMBUN_NAME.Text == "" && strSkuName == ""){
        // 존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드 또는 단품");
        EM_O_PUMBUN_CD.Focus();
        return;
    }

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strPummokCd="+encodeURIComponent(strPummokCd)
                   + "&strSkuCd="+encodeURIComponent(strSkuCd)
                   + "&strSkuName="+encodeURIComponent(strSkuName);
    
    bfMasterRow = 0;               
    TR_SUB.Action="/dps/pcod609.pc?goTo="+goTo+parameters;  
    TR_SUB.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SUB.Post();
    
    //조회후 결과표시
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

}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-10
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-10
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-10
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
  var strStrCd      = LC_O_STR_CD.BindColVal;
  var strPumbunCd   = EM_O_PUMBUN_CD.Text;
  var strPumbunNm   = EM_O_PUMBUN_NAME.Text;
  var strPummokCd   = LC_O_PUMMOK_CD.BindColVal;
  var strSkuCd      = EM_O_SKU_CD.Text;
  var strSkuName    = EM_O_SKU_NAME.Text;
	    
    if (strSkuCd == "")
   	 strSkuCd = "전체";
    if (strSkuName == "")
    	strSkuName = "전체";
    
    if (strPumbunCd == "")
    	strPumbunCd = "전체";
    if (strPumbunNm == "")
        strPumbunNm = "전체";
       
    var parameters = "점코드="+strStrCd                    
                   + " -브랜드코드="+strPumbunCd                    
                   + " _브랜드명="+strPumbunNm                    
                   + " -품목코드="+strPummokCd
                   + " -단품코드="+strSkuCd 
                   + " -단품명="+strSkuName;
      
  //openExcel2(GD_DETAIL, "가격이력조회", parameters, true );
  openExcel5(GD_DETAIL, "가격이력조회", parameters, true , "",g_strPid );

  GD_DETAIL.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-10
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/


 /**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-11
 * 개    요 :  점별단품을 조회한다.
 * return값 : void
 */
function searchDetail(){
    DS_DETAIL.ClearData();
    
    var strStrCd    = DS_MASTER.NameValue( DS_MASTER.RowPosition, "STR_CD");
    var strSkuCd    = DS_MASTER.NameValue( DS_MASTER.RowPosition, "SKU_CD");

    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strSkuCd="+encodeURIComponent(strSkuCd);
                   
    TR_MAIN.Action="/dps/pcod609.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
}



/**
 * setPumbunCdCombo()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCdCombo(selInGb, evnflag){
	var codeObj = EM_O_PUMBUN_CD;
    var nameObj = EM_O_PUMBUN_NAME;
    var pmkComboObj = LC_O_PUMMOK_CD;
    


    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        setPummokCombo( pmkComboObj,"",selInGb);
        return;     
    }
    var result = null;
    var bfPumbunCd = "";
    if( evnflag == "POP" ){
    	bfPumbunCd = codeObj.Text;
    	result = strPbnPop2(codeObj,nameObj,'Y','','','','','','',selInGb=="S"?'':'Y','1','1');
        codeObj.Focus();
    	
    }else if( evnflag == "NAME" ){
        nameObj.Text = "";
    	result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'','','','','','',selInGb=="S"?'':'Y','1','1');
    }
    var pumbunCd = codeObj.Text;

    setPummokCombo( pmkComboObj, pumbunCd ,selInGb);
    if( evnflag == "POP" ){
        codeObj.Focus();
    }
}

/**
 * setPummokCombo()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 :  품목코드 콤보 조회등록한다.
 * return값 : void
 */
function setPummokCombo( obj, pumbunCd, srv ){
	
    eval(obj.ComboDataID).ClearData();
    if( srv == "S"){
        // 기본값 입력( gauce.js )
        insComboData( obj, "%", "전체", 1 );
        setComboData( obj,"%");
    }
	if(pumbunCd == ""){
		return;
	}

    getPbnPmkCode( obj.ComboDataID,pumbunCd,"N",srv=="S"?null:'Y');
    
    if( srv == "S"){
        // 기본값 입력( gauce.js )
        insComboData( obj, "%", "전체", 1 );
        setComboData( obj,"%");
    }else{
        setComboData( obj,DS_MASTER.OrgNameValue(DS_MASTER.RowPosition,"PUMMOK_CD"));
    }
}

/**
 * setSkuCdCombo()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 공병명을 등록한다.
 * return값 : void
 */
function setSkuCdCombo(evnflag, scrFlag){
    var codeObj = EM_O_SKU_CD;
    var nameObj = EM_O_SKU_NAME;
    

    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
    	return;
    }
    if( scrFlag!="I" && evnflag != "POP" && codeObj.Text.length !=13){
        nameObj.Text = "";
        return;
    }
    
    if( evnflag == "POP" ){
        strSkuPop(codeObj,nameObj,scrFlag=="I"?'N':'Y','','',scrFlag=="I"?'':EM_O_PUMBUN_CD.Text,scrFlag=="I"?'2':'','',scrFlag=="I"?'Y':'','',scrFlag=="I"?'':'1',scrFlag=="I"?DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD"):'');
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        nameObj.Text = "";
        setStrSkuNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,scrFlag=="I"?'N':'Y',scrFlag=="I"?1:0,'','',scrFlag=="I"?'':EM_O_PUMBUN_CD.Text,scrFlag=="I"?'2':'','',scrFlag=="I"?'Y':'','',scrFlag=="I"?'':'1',scrFlag=="I"?DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD"):'');
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
<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(btnSaveYn)
    	return true;

    if(DS_DETAIL.IsUpdated || DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 이동하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1049")!=1)
            return false;
        DS_DETAIL.UndoAll();
        DS_MASTER.UndoAll();
    }
    DS_DETAIL.ClearData();
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(row < 1 || bfMasterRow == row)
    	return;
    bfMasterRow = row;
 
    searchDetail();
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    if( row < 1)
        return;
    if( colid == "SEL"){
        if(eval(this.DataID).NameValue(row,"SKU_CD")==""){

            var colCnt = eval(this.DataID).CountColumn;
            for( var j=1; j<=colCnt;j++){
                if(eval(this.DataID).ColumnID(j) != colid)
                    if( eval(this.DataID).NameValue( row, eval(this.DataID).ColumnID(j)) 
                            != eval(this.DataID).OrgNameValue( row, eval(this.DataID).ColumnID(j))){
                        eval(this.DataID).NameValue(row,colid) ="T";
                        return;
                    }
            }

        }
    }
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onSetFocus()>
   bfSearchPumbunCd = this.Text;
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setPumbunCdCombo("S", "NAME");
</script>


<!-- 단품(조회) -->
<script language=JavaScript for=EM_O_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setSkuCdCombo("NAME", "S");
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
<comment id="_NSID_"><object id="DS_O_PUMMOK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TAX_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PUMBUN_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PLU_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object></comment><script>_ws_(_NSID_);</script>

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

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="40" >점</th>
                <td width="140">
                  <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
                  </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="40" >브랜드</th>
                <td width="180">
                  <comment id="_NSID_">
                    <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  onclick="javascript:setPumbunCdCombo('S','POP');"  align="absmiddle" />
                  <comment id="_NSID_">
                    <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=98 tabindex=1 align="absmiddle"></object>
                  </comment><script> _ws_(_NSID_);</script>
                </td>
                <th width="40">품목</th>
                <td >
                  <comment id="_NSID_">
                    <object id=LC_O_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120 tabindex=1 align="absmiddle"></object>
                  </comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
              
              <tr>
                <th width="40">단품</th>
                <td colspan="5">
                <comment id="_NSID_">
                  <object id=EM_O_SKU_CD classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"></object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  onclick="javascript:setSkuCdCombo('POP','S');"  align="absmiddle" />
                <comment id="_NSID_">
                  <object id=EM_O_SKU_NAME classid=<%=Util.CLSID_EMEDIT%> width=135 tabindex=1 align="absmiddle"></object>
                </comment><script> _ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
		</td>
	  </tr>
	</table>
   </td>
  </tr>
        
	
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0" class="BD4A"
			width="100%">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=220 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title PB03 PT10"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
					align="absmiddle" /> 가격변경이력</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_DETAIL
					width="100%" height=235 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_DETAIL">
				</object></comment><script>_ws_(_NSID_);</script></td>
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
