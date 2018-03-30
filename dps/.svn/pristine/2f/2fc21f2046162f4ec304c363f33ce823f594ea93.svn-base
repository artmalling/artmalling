<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 규격단품관리
 * 작 성 일 : 2010.03.10
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod5010.jsp
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
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>

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
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

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

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_O_COPY_POINT.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //점별단품정보

    // EMedit에 초기화
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6", PK);  //브랜드(조회)
    initEmEdit(EM_O_PUMBUN_NAME, "GEN", READ);  //브랜드(조회)
    initEmEdit(EM_O_SKU_CD, "CODE^13^0", NORMAL);  //단품(조회)
    initEmEdit(EM_O_SKU_NAME, "GEN^40", NORMAL);  //단품(조회)
    initEmEdit(EM_I_PUMBUN_CD, "CODE^6", PK);  //브랜드
    initEmEdit(EM_I_PUMBUN_NAME, "GEN", READ);  //브랜드
    initEmEdit(EM_REP_PUMBUN_NAME, "GEN", READ);  //대표브랜드
    initEmEdit(EM_I_VEN_NAME, "GEN", READ);  //협력사 
    initEmEdit(EM_I_SKU_CD, "GEN", READ);  //단품코드
    initEmEdit(EM_I_INPUT_PLU_CD, "CODE^13^0", NORMAL);  //소스마킹코드
    initEmEdit(EM_I_SKU_NAME, "GEN^40", PK);  //단품명
    initEmEdit(EM_I_RECP_NAME, "GEN^20", PK);  //영수증명
    initEmEdit(EM_I_ORIGIN_AREA_CD, "CODE^3", NORMAL);  //원산지
    initEmEdit(EM_I_ORIGIN_AREA_NAME, "GEN", READ);  //원산지
    initEmEdit(EM_I_BOTTLE_CD, "CODE^13^0", NORMAL);  //공병단품코드
    initEmEdit(EM_I_BOTTLE_NAME, "GEN", READ);  //공병단품명
    initEmEdit(EM_I_MODEL_CD, "CODE^24", NORMAL);  //모델코드
    initEmEdit(EM_I_CMP_SPEC_CD, "NUMBER^3^2", NORMAL);  //구성규격
    initEmEdit(EM_I_BAS_SPEC_CD, "NUMBER^6^2", NORMAL);  //기본규격
    initEmEdit(EM_I_REMARK, "GEN^100", NORMAL);  //비고
    initEmEdit(EM_I_MAKER_CD, "CODE^6", NORMAL);  //메이커
    initEmEdit(EM_I_MAKER_NAME, "GEN", READ);  //메이커
    

    //콤보 초기화
    initComboStyle(LC_O_PUMMOK_CD,DS_O_PUMMOK, "CODE^0^70,NAME^0^100", 1, NORMAL);  //품목(조회)
    initComboStyle(LC_I_PLU_FLAG,DS_I_PLU_FLAG, "CODE^0^30,NAME^0^120", 1, READ);  //PLU구분
    initComboStyle(LC_I_PUMMOK_CD,DS_I_PUMMOK_CD, "CODE^0^70,NAME^0^85", 1, PK);  //품목 
    initComboStyle(LC_I_CMP_SPEC_UNIT_CD,DS_I_CMP_SPEC_UNIT_CD, "CODE^0^30,NAME^0^120", 1, NORMAL);  //구성규격단위
    initComboStyle(LC_I_BAS_SPEC_UNIT_CD,DS_I_BAS_SPEC_UNIT_CD, "CODE^0^30,NAME^0^120", 1, NORMAL);  //기본규격단위
    initComboStyle(LC_I_SET_YN,DS_I_SET_YN, "CODE^0^30,NAME^0^120", 1, PK);  //SET여부
    initComboStyle(LC_I_GIFT_FLAG,DS_I_GIFT_FLAG, "CODE^0^30,NAME^0^120", 1, PK);  //GIFT구분
    initComboStyle(LC_O_COPY_POINT,DS_O_COPY_POINT, "CODE^0^20,NAME^0^50", 1, PK);  //복사기준점
    initComboStyle(LC_I_GIFT_TYPE_CD,DS_I_GIFT_TYPE_CD, "CODE^0^30,NAME^0^120", 1, NORMAL);  //상품권종류
    initComboStyle(LC_I_GIFT_AMT_TYPE,DS_I_GIFT_AMT_TYPE, "CODE^0^30,NAME^0^120", 1, NORMAL);  //상품권금종
    initComboStyle(LC_I_SALE_UNIT_CD,DS_I_SALE_UNIT_CD, "CODE^0^30,NAME^0^120",1, PK);  //판매단위
    initComboStyle(LC_I_USE_YN,DS_I_USE_YN, "CODE^0^30,NAME^0^120",1, PK);  //사용여부
    initComboStyle(LC_O_USE_YN,DS_O_USE_YN, "CODE^0^30,NAME^0^120",1, PK);  //사용여부 CENTRAL

    //오브젝트 속성 재 정의    
    EM_I_INPUT_PLU_CD.Alignment = 0;    //왼쪽정렬
    masterEnblCntl(false);              //단품정보 컴포넌트 사용여부 지정(수정시)
    giftEnblCntl(false);                //상품권종류,상품권금종 사용여부 지정
    
    //0보다 큰값 입력(NUMBER)
    EM_I_CMP_SPEC_CD.NumericRange = "0~+:0";
    EM_I_BAS_SPEC_CD.NumericRange = "0~+:0";
    

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_I_PLU_FLAG", "D", "P081", "N");
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");
    getEtcCode("DS_I_CMP_SPEC_UNIT_CD", "D", "P013", "N");
    getEtcCode("DS_I_BAS_SPEC_UNIT_CD", "D", "P013", "N");
    getEtcCode("DS_I_SET_YN", "D", "D022", "N");
    getEtcCode("DS_I_GIFT_FLAG", "D", "P080", "N");
    getEtcCode("DS_I_USE_YN", "D", "D022", "N");
    getEtcCode("DS_O_USE_YN", "D", "D022", "N"); //CENTRAL
    
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_PUMMOK.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_PUMMOK_CD, "%", "전체", 1 );
    insComboData( LC_O_USE_YN,    "%", "전체", 1 ); //CENTRAL

    //상품권 관련 공통 콤보 조회 ( popup_mss.js )
    getGiftCombo("DS_I_GIFT_TYPE_CD", "TP");
    //빈값 추가
    insComboFirstNullId(LC_I_GIFT_TYPE_CD,"");
    insComboFirstNullId(LC_I_CMP_SPEC_UNIT_CD,"");
    insComboFirstNullId(LC_I_BAS_SPEC_UNIT_CD,"");
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_PUMMOK_CD,"%");
    setComboData(LC_I_GIFT_TYPE_CD,"");
    setComboData(LC_I_CMP_SPEC_UNIT_CD,"");
    setComboData(LC_I_BAS_SPEC_UNIT_CD,"");
    setComboData(LC_O_USE_YN,"%"); //CENTRAL
    
    //조회후 결과표시 초기화
    setPorcCount("CLEAR");
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod521","DS_MASTER,DS_DETAIL" );

    //시작시 포커스
    EM_O_PUMBUN_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"          width=25   align=center</FC>'
                     + '<FC>id=SKU_CD       name="단품코드"     width=120   align=center</FC>'
                     + '<FC>id=SKU_NAME     name="단품명"       width=100  align=left</FC>'
                     + '<FC>id=PUMMOK_NAME  name="품목"         width=100   align=left</FC>'
                     + '<FC>id=USE_YN       name="사용여부"     width=60    align=center</FC>'
                     ;

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}    name="NO"          width=30   align=center</FC>'
                     + '<FC>id=SEL         name="선택"        width=30   value={IF(SKU_CD="",IF(CurStatus="U","T","F"),"T")} edit="none" align=center EditStyle=CheckBox </FC>'
                     + '<FC>id=STR_CD      name="*점"          width=100  edit="none" align=left EditStyle=Lookup data="DS_STR_CD:CODE:NAME" </FC>'
                     + '<C>id=VEN_CD       name="*협력사코드"   width=80  edit="Numeric" editStyle=Popup  align=center edit={IF(BIZ_TYPE="1","true","false")}</C>'
                     + '<C>id=VEN_NAME     name="협력사명"      width=150 edit="none" align=left</C>'
                     + '<C>id=SAL_COST_PRC name="*판매원가"     width=70  edit="Numeric" edit={IF(BIZ_TYPE="2" OR BIZ_TYPE="3" OR BIZ_TYPE="5","false",IF(SKU_CD="","true","false"))}  align=right</C>'
                     + '<C>id=SALE_PRC     name="*판매매가"     width=70  edit="Numeric" edit={IF(SKU_CD="","true","false")}  align=right</C>'
                     + '<C>id=SALE_MG_RATE name="*마진율"       width=70  edit="RealNumeric" edit={IF(BIZ_TYPE="1","false",IF(SKU_CD="","true","false"))}  align=right</C>'
                     + '<C>id=NORM_MG_RATE name="정상마진율"       width=70  edit="RealNumeric"   align=right show=false </C>'
                     + '<C>id=ADV_ORD_YN   name="*권고발주여부" width=90 edit={IF(PBN_ADV_ORD_YN="Y","true","false")} editStyle=Combo data="Y:YES,N:NO" align=left</C>'
                     + '<C>id=LOW_ORD_QTY  name="최소발주량"   width=70  edit="Numeric" edit={IF(ADV_ORD_YN="Y","true","false")} align=right</C>'
                     + '<C>id=OTM_STK_QTY  name="적정재고량"   width=70  edit="Numeric" edit={IF(ADV_ORD_YN="Y","true","false")} align=right</C>'
                     + '<C>id=LEAD_TIME    name="리드타임"     width=60  edit="Numeric" edit={IF(ADV_ORD_YN="Y","true","false")} align=right</C>'
                     + '<C>id=SALE_S_DT    name="판매시작일"   width=80  edit="Numeric" edit={IF(SKU_CD="" OR SALE_S_DT="","true",IF(SALE_S_DT<'+getTodayFormat("YYYYMMDD")+',"false","true"))} mask="XXXX/XX/XX" editStyle=popup align=center</C>'
                     + '<C>id=SALE_E_DT    name="판매종료일"   width=80  edit="Numeric"  mask="XXXX/XX/XX" editStyle=popup align=center</C>'
                     + '<C>id=BUY_S_DT     name="매입시작일"   width=80  edit="Numeric"  edit={IF(SKU_CD="" OR BUY_S_DT="","true",IF(BUY_S_DT<'+getTodayFormat("YYYYMMDD")+',"false","true"))} mask="XXXX/XX/XX" editStyle=popup align=center</C>'
                     + '<C>id=BUY_E_DT     name="매입종료일"   width=80  edit="Numeric"  mask="XXXX/XX/XX" editStyle=popup align=center</C>'
                     + '<C>id=USE_YN       name="사용여부"      width=60  editStyle=Combo data="Y:YES,N:NO" align=left</C>';

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
	 
	if( DS_MASTER.IsUpdated || DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1059")!=1){
            EM_I_SKU_NAME.Focus();
            return;
        }
    }  
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();

    //오브젝트 속성 재 정의    
    masterEnblCntl(false);              //단품정보 컴포넌트 사용여부 지정(수정시)
    
    var strPumbunCd  = EM_O_PUMBUN_CD.Text;
    var strPummokCd  = LC_O_PUMMOK_CD.BindColVal;
    var strSkuCd     = EM_O_SKU_CD.Text;
    var strSkuName   = EM_O_SKU_NAME.Text;
    var strUseYn     = LC_O_USE_YN.BindColVal; //CENTRAL
    
    if( strPumbunCd == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_O_PUMBUN_NAME.Text == ""){
        // 존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strPummokCd="+encodeURIComponent(strPummokCd)
                   + "&strSkuCd="+encodeURIComponent(strSkuCd)
                   + "&strSkuName="+encodeURIComponent(strSkuName)
                   + "&strUseYn="+encodeURIComponent(strUseYn); //CENTRAL
    
    bfMasterRow = 0;               
    TR_SUB.Action="/dps/pcod521.pc?goTo="+goTo+parameters;  
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
	var row = DS_MASTER.RowPosition;
    if(DS_MASTER.RowStatus(row)==1){
        // 초기화하시겠습니까?)
        if(showMessage(QUESTION, YESNO, "USER-1051")!=1){
        	EM_I_PUMBUN_CD.Focus();
            return; 
        }
        DS_DETAIL.ClearData();
        DS_MASTER.DeleteRow(row);
    }
    
	if( DS_DETAIL.IsUpdated || DS_MASTER.IsUpdated){
	    // 변경된 상세내역이 존재합니다. 신규추가하시겠습니까?)
	    if(showMessage(QUESTION, YESNO, "USER-1050")!=1){
	    	if( DS_MASTER.IsUpdated){
	            EM_I_SKU_NAME.Focus();	    		
	    	}else{
	            GD_DETAIL.Focus();	    		
	    	}
            return;	    	
	    }
        DS_DETAIL.ClearData();
        DS_MASTER.UndoAll();
	}
    masterEnblCntl(true);     
	DS_MASTER.addRow();
	row = DS_MASTER.CountRow;
    //기초값 설정
    DS_MASTER.NameValue(row,"PLU_FLAG") = "1";   
    EM_I_BAS_SPEC_CD.Text = '';   
    EM_I_CMP_SPEC_CD.Text = '';
    // 제외( 김수현:2010.04.05 요청)
    //DS_MASTER.NameValue(row,"CMP_SPEC_CD") = 1;   
    DS_MASTER.NameValue(row,"SET_YN") = "N";   
    DS_MASTER.NameValue(row,"GIFT_FLAG") = "0";   
    DS_MASTER.NameValue(row,"USE_YN") = "Y";

    DS_MASTER.NameValue(row,"PUMBUN_CD") = EM_O_PUMBUN_CD.Text;       
    if(replaceStr(EM_O_PUMBUN_CD.Text," ","").length == 6){
    	setPumbunCdCombo('I','NAME');
    }
    
    LC_I_PUMMOK_CD.index = 0;
    setComboData(LC_I_SALE_UNIT_CD,"001");
    
    EM_I_PUMBUN_CD.Focus();
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

    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated && !DS_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        
        if( DS_MASTER.CountRow < 1)
        	EM_O_PUMBUN_CD.Focus();
        else
        	GD_MASTER.Focus();
        return;
    }
    if( !checkMasterValidation())
        return;
    if( !checkDetailValidation())
        return;

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        EM_I_SKU_NAME.Focus();
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	EM_I_SKU_NAME.Focus();
        return;
    }
    
    var row           = DS_MASTER.RowPosition;
    var pluCd         = DS_MASTER.NameValue(row,"INPUT_PLU_CD");
    if(pluCd != '')
    	DS_MASTER.NameValue(row,"SKU_CD") = lpad(pluCd,13,'0');
    	
    var strSkuCd      = DS_MASTER.NameValue(row,"SKU_CD");
    var strSkuName    = DS_MASTER.NameValue(row,"SKU_NAME");
    var strRecpName   = DS_MASTER.NameValue(row,"RECP_NAME");
    var strPumbunType = DS_MASTER.NameValue(row,"PUMBUN_TYPE");
    var strPumbunCd   = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var strPummokCd   = DS_MASTER.NameValue(row,"PUMMOK_CD");
    var strSkuType    = DS_MASTER.NameValue(row,"SKU_TYPE");
    var strStyleType  = DS_MASTER.NameValue(row,"STYLE_TYPE");
    var strBottleCd   = DS_MASTER.NameValue(row,"BOTTLE_CD");
    
    btnSaveYn = true;    
    var parameters = "&strSkuCd="+strSkuCd
                   + "&strSkuName="+encodeURIComponent(strSkuName)
                   + "&strRecpName="+encodeURIComponent(strRecpName)
                   + "&strPumbunType="+encodeURIComponent(strPumbunType)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strPummokCd="+encodeURIComponent(strPummokCd)
                   + "&strSkuType="+encodeURIComponent(strSkuType)
                   + "&strStyleType="+encodeURIComponent(strStyleType)
                   + "&strBottleCd="+encodeURIComponent(strBottleCd);
    
    TR_MAIN.Action="/dps/pcod521.pc?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER,I:DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    btnSaveYn = false;
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        var row = 1;
        if(strSkuCd != ""){
        	row = DS_MASTER.NameValueRow('SKU_CD',strSkuCd);
        }else{
        	row = DS_MASTER.NameValueRow('SKU_NAME',strSkuName);
        }
        row = row<1?1:row;
        DS_MASTER.RowPosition = row;
    }
    
    EM_I_INPUT_PLU_CD.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-10
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

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
 * btn_rowClear()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 행초기화
 * return값 : void
 */
function btn_rowClear(){

	var row = DS_DETAIL.RowPosition;
	if(DS_DETAIL.RowStatus(row)!=3){
		showMessage(INFORMATION, OK, "USER-1080");
		GD_DETAIL.Focus();
		return;
	}
    // 초기화하시겠습니까?)
    if(showMessage(QUESTION, YESNO, "USER-1051")!=1){
        GD_DETAIL.Focus();
        return; 
    }
	DS_DETAIL.Undo(row);
    GD_DETAIL.Focus();
}

/**
 * btn_rowClear()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 행초기화
 * return값 : void
 */
function btn_rowCopy(){
   
   var strCd = LC_O_COPY_POINT.BindColVal;
   if( strCd == ''){
       // (복사기준점)은/는 반드시 선택해야 합니다.
       showMessage(EXCLAMATION, OK, "USER-1002", "복사기준점");
       LC_O_COPY_POINT.Focus();
       return;	   
   }
   
   var copyRow = DS_DETAIL.NameValueRow("STR_CD", strCd);
   var row = DS_DETAIL.RowPosition;
   
   //복사기준점과 같은면 무시 
   if( copyRow==row)
	   return;
   
   if( DS_DETAIL.NameValue(row,"SKU_CD")!=""){
       // 신규데이터만 행복사가 가능합니다.
       showMessage(INFORMATION, OK, "USER-1070", "행복사");
       GD_DETAIL.Focus();
	   return;
   }
   var toDay = getTodayFormat("YYYYMMDD");
   DS_DETAIL.NameValue(row,"SAL_COST_PRC") = DS_DETAIL.NameValue(copyRow,"SAL_COST_PRC");
   DS_DETAIL.NameValue(row,"SALE_PRC") = DS_DETAIL.NameValue(copyRow,"SALE_PRC");
   DS_DETAIL.NameValue(row,"SALE_MG_RATE") = DS_DETAIL.NameValue(copyRow,"SALE_MG_RATE");
   DS_DETAIL.NameValue(row,"SALE_S_DT") = DS_DETAIL.NameValue(copyRow,"SALE_S_DT")<toDay?toDay:DS_DETAIL.NameValue(copyRow,"SALE_S_DT");
   DS_DETAIL.NameValue(row,"SALE_E_DT") = DS_DETAIL.NameValue(copyRow,"SALE_E_DT")<toDay?'99991231':DS_DETAIL.NameValue(copyRow,"SALE_E_DT");
   DS_DETAIL.NameValue(row,"BUY_S_DT") = DS_DETAIL.NameValue(copyRow,"BUY_S_DT")<toDay?toDay:DS_DETAIL.NameValue(copyRow,"BUY_S_DT");
   DS_DETAIL.NameValue(row,"BUY_E_DT") = DS_DETAIL.NameValue(copyRow,"BUY_E_DT")<toDay?'99991231':DS_DETAIL.NameValue(copyRow,"BUY_E_DT");
   DS_DETAIL.NameValue(row,"USE_YN") = "Y";
   
   if(DS_DETAIL.NameValue(row,"PBN_ADV_ORD_YN")=="Y"){
       DS_DETAIL.NameValue(row,"ADV_ORD_YN") = DS_DETAIL.NameValue(copyRow,"ADV_ORD_YN");
	   DS_DETAIL.NameValue(row,"LOW_ORD_QTY") = DS_DETAIL.NameValue(copyRow,"LOW_ORD_QTY");
	   DS_DETAIL.NameValue(row,"OTM_STK_QTY") = DS_DETAIL.NameValue(copyRow,"OTM_STK_QTY");
       DS_DETAIL.NameValue(row,"LEAD_TIME") = DS_DETAIL.NameValue(copyRow,"LEAD_TIME");
	   
   }
   GD_DETAIL.Focus();

   setCopyPoint();
}
/**
 * masterEnblCntl()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-11
 * 개    요 :  단품정보의컴포넌트 사용여부 지정
 * return값 : void
 */
function masterEnblCntl(flag){
	 
  enableControl2(EM_I_SKU_NAME        , flag);
  enableControl2(EM_I_RECP_NAME       , flag);
  enableControl2(EM_I_ORIGIN_AREA_CD  , flag);
  enableControl2(EM_I_BOTTLE_CD       , flag);
  enableControl2(EM_I_MODEL_CD        , flag);
  enableControl2(EM_I_CMP_SPEC_CD     , flag);
  enableControl2(EM_I_BAS_SPEC_CD     , flag);
  enableControl2(EM_I_REMARK          , flag);
  enableControl2(EM_I_MAKER_CD        , flag);
  enableControl2(LC_I_PUMMOK_CD       , flag);
  enableControl2(LC_I_CMP_SPEC_UNIT_CD, flag);
  enableControl2(LC_I_BAS_SPEC_UNIT_CD, flag);
  enableControl2(LC_I_SET_YN          , flag);
  enableControl2(LC_I_SALE_UNIT_CD    , flag);
  enableControl2(LC_I_USE_YN          , flag);
  enableControl2(LC_I_GIFT_FLAG       , flag);
  enableControl2(EM_I_PUMBUN_CD       , flag);
  enableControl2(EM_I_INPUT_PLU_CD    , flag);
  enableControl2(LC_O_COPY_POINT      , flag);
//   enableControl2(GD_DETAIL            , flag);
  
  enableImg(IMG_ORIGIN_AREA_CD   , flag);
  enableImg(IMG_BOTTLE_CD        , flag);
  enableImg(IMG_MAKER_CD         , flag);
  enableImg(IMG_PUMBUN           , flag); 
  enableImg(IMG_ROWCLEAR         , flag);
  enableImg(IMG_ROWCOPY          , flag);



//     enableControl(EM_I_SKU_NAME        , flag!=null);
//     enableControl(EM_I_RECP_NAME       , flag!=null);
//     enableControl(EM_I_ORIGIN_AREA_CD  , flag!=null);
//     enableControl(IMG_ORIGIN_AREA_CD   , flag!=null);
//     enableControl(EM_I_BOTTLE_CD       , flag!=null);
//     enableControl(IMG_BOTTLE_CD        , flag!=null);
//     enableControl(EM_I_MODEL_CD        , flag!=null);
//     enableControl(EM_I_CMP_SPEC_CD     , flag!=null);
//     enableControl(EM_I_BAS_SPEC_CD     , flag!=null);
//     enableControl(EM_I_REMARK          , flag!=null);
//     enableControl(EM_I_MAKER_CD        , flag!=null);
//     enableControl(IMG_MAKER_CD         , flag!=null);
//     enableControl(LC_I_PUMMOK_CD       , flag!=null);
//     enableControl(LC_I_CMP_SPEC_UNIT_CD, flag!=null);
//     enableControl(LC_I_BAS_SPEC_UNIT_CD, flag!=null);
//     enableControl(LC_I_SET_YN          , flag!=null);
// 	enableControl(LC_I_SALE_UNIT_CD    , flag!=null);
// 	enableControl(LC_I_USE_YN          , flag!=null);
//     enableControl(LC_I_GIFT_FLAG       , flag!=null);
	
//     enableControl(EM_I_PUMBUN_CD   , flag==null?false:flag);
// 	enableControl(IMG_PUMBUN       , flag==null?false:flag);
//     enableControl(EM_I_INPUT_PLU_CD, flag==null?false:flag);
    
    enableControl(GD_DETAIL      , flag==null?false:!flag);
//     enableControl(IMG_ROWCLEAR   , flag==null?false:!flag);
//     enableControl(IMG_ROWCOPY    , flag==null?false:!flag);
//     enableControl(LC_O_COPY_POINT, flag==null?false:!flag);
    
//     EM_I_SKU_NAME.Enable         = flag;
//     EM_I_RECP_NAME.Enable        = flag;
//     EM_I_ORIGIN_AREA_CD.Enable   = flag;
//     EM_I_BOTTLE_CD.Enable        = flag;
//     EM_I_MODEL_CD.Enable         = flag;
//     EM_I_CMP_SPEC_CD.Enable      = flag;
//     EM_I_BAS_SPEC_CD.Enable      = flag;
//     EM_I_REMARK.Enable           = flag;
//     EM_I_MAKER_CD.Enable         = flag;
//     LC_I_PUMMOK_CD.Enable        = flag;
//     LC_I_CMP_SPEC_UNIT_CD.Enable = flag;
//     LC_I_BAS_SPEC_UNIT_CD.Enable = flag;
//     LC_I_SET_YN.Enable           = flag;
//     LC_I_SALE_UNIT_CD.Enable     = flag;
//     LC_I_USE_YN.Enable           = flag;
//     LC_I_GIFT_FLAG.Enable        = flag;
//     EM_I_PUMBUN_CD.Enable        = flag;
//     EM_I_INPUT_PLU_CD.Enable     = flag;
//     GD_DETAIL.Enable             = flag;
//     LC_O_COPY_POINT.Enable       = flag;
    
//     // 팝업(등록) 이미지
// 	if (flag) {
// 		IMG_ORIGIN_AREA_CD.style.filter = 'alpha(opacity=100)';
// 		IMG_ORIGIN_AREA_CD.disabled = false;
// 		IMG_BOTTLE_CD.style.filter = 'alpha(opacity=100)';
// 		IMG_BOTTLE_CD.disabled = false;
// 		IMG_MAKER_CD.style.filter = 'alpha(opacity=100)';
// 		IMG_MAKER_CD.disabled = false;
// 		IMG_PUMBUN.style.filter = 'alpha(opacity=100)';
// 		IMG_PUMBUN.disabled = false;
// 		IMG_ROWCLEAR.style.filter = 'alpha(opacity=100)';
// 		IMG_ROWCLEAR.disabled = false;
// 		IMG_ROWCOPY.style.filter = 'alpha(opacity=100)';
// 		IMG_ROWCOPY.disabled = false;
// 	} else {
// 		IMG_ORIGIN_AREA_CD.style.filter = 'alpha(opacity=40)';
// 		IMG_ORIGIN_AREA_CD.disabled = true;
// 		IMG_BOTTLE_CD.style.filter = 'alpha(opacity=40)';
// 		IMG_BOTTLE_CD.disabled = true;
// 		IMG_MAKER_CD.style.filter = 'alpha(opacity=40)';
// 		IMG_MAKER_CD.disabled = true;
// 		IMG_PUMBUN.style.filter = 'alpha(opacity=40)';
// 		IMG_PUMBUN.disabled = true;
// 		IMG_ROWCLEAR.style.filter = 'alpha(opacity=40)';
// 		IMG_ROWCLEAR.disabled = true;
// 		IMG_ROWCOPY.style.filter = 'alpha(opacity=40)';
// 		IMG_ROWCOPY.disabled = true;
// 	}
    
//     if(flag){
//         document.getElementById("IMG_ORIGIN_AREA_CD").style.display = "";
//         document.getElementById("IMG_BOTTLE_CD").style.display      = "";
//         document.getElementById("IMG_MAKER_CD").style.display       = "";
//         document.getElementById("IMG_PUMBUN").style.display         = "";
//         document.getElementById("IMG_ROWCLEAR").style.display       = "";
//         document.getElementById("IMG_ROWCOPY").style.display        = "";
//     }else{
//         document.getElementById("IMG_ORIGIN_AREA_CD").style.display = "none";
//         document.getElementById("IMG_BOTTLE_CD").style.display      = "none";
//         document.getElementById("IMG_MAKER_CD").style.display       = "none";
//         document.getElementById("IMG_PUMBUN").style.display         = "none";
//         document.getElementById("IMG_ROWCLEAR").style.display       = "none";
//         document.getElementById("IMG_ROWCOPY").style.display        = "none";
//     }
}

/**
 * giftEnblCntl()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-11
 * 개    요 :  단품정보의 컴포넌트 사용여부 지정
 * return값 : void
 */
function giftEnblCntl( flag){
//     enableControl(LC_I_GIFT_TYPE_CD, flag == null?false:flag);
//     enableControl(LC_I_GIFT_AMT_TYPE, flag == null?false:flag);
//     if(flag == null?false:!flag){
//     	LC_I_GIFT_TYPE_CD.BindColVal = '';
//     	LC_I_GIFT_AMT_TYPE.BindColVal = '';
//     }
    
//     if(!flag){
//     	LC_I_GIFT_TYPE_CD.BindColVal  = '';
//     	LC_I_GIFT_AMT_TYPE.BindColVal = '';
//     }

    enableControl2(LC_I_GIFT_TYPE_CD  , flag);
    enableControl2(LC_I_GIFT_AMT_TYPE , flag);
}
 /**
 * searchDetail()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-11
 * 개    요 :  점별단품을 조회한다.
 * return값 : void
 */
function searchDetail(){
    DS_DETAIL.ClearData();
    DS_O_COPY_POINT.ClearData();
    var strPumbunCd = EM_I_PUMBUN_CD.Text;
    var strSkuCd    = EM_I_SKU_CD.Text;

    if( strPumbunCd == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_I_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_I_PUMBUN_NAME.Text == ""){
        // 존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_I_PUMBUN_CD.Focus();
        return;
    }
    getStrPbnCode('DS_STR_CD',strPumbunCd,'N');
    
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)
                   + "&strSkuCd="+encodeURIComponent(strSkuCd);
                   
    TR_MAIN.Action="/dps/pcod521.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    
    setCopyPoint();
}

/**
 * excelUpload()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 엑셀업로드
 * return값 : void
 */

function excelUpload(){
     showMessage(Information, OK, "USER-1000", "개발예정");
}
/**
 * setPumbunCdCombo()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCdCombo(selInGb, evnflag){
	var codeObj = selInGb=="S"?EM_O_PUMBUN_CD:EM_I_PUMBUN_CD;
    var nameObj = selInGb=="S"?EM_O_PUMBUN_NAME:EM_I_PUMBUN_NAME;
    var pmkComboObj = selInGb=="S"?LC_O_PUMMOK_CD:LC_I_PUMMOK_CD;
    
    if( selInGb == "I"){
        EM_REP_PUMBUN_NAME.Text = "";
        EM_I_VEN_NAME.Text = "";
        DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD") = "";
    }

    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        if(selInGb == "I"){
            EM_I_BOTTLE_CD.Text = "";
            EM_I_BOTTLE_NAME.Text = "";        	
        }
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

    if( result != null || DS_SEARCH_NM.CountRow == 1){

        if(selInGb == "I"){
        	getPumbunInfo("DS_SEARCH_NM",pumbunCd);
        	
        	if( DS_SEARCH_NM.CountRow > 0){
                
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"REP_PUMBUN_NAME") = DS_SEARCH_NM.NameValue(1,"REP_PUMBUN_NAME");
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_NAME") = DS_SEARCH_NM.NameValue(1,"VEN_NAME");
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"VEN_CD") = DS_SEARCH_NM.NameValue(1,"VEN_CD");
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"PUMBUN_TYPE") = DS_SEARCH_NM.NameValue(1,"PUMBUN_TYPE");
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"SKU_TYPE") = DS_SEARCH_NM.NameValue(1,"SKU_TYPE");
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"STYLE_TYPE") = DS_SEARCH_NM.NameValue(1,"STYLE_TYPE");
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"BIZ_TYPE") = DS_SEARCH_NM.NameValue(1,"BIZ_TYPE");
                DS_MASTER.NameValue(DS_MASTER.RowPosition,"TAX_FLAG") = DS_SEARCH_NM.NameValue(1,"TAX_FLAG");
                
                if(DS_SEARCH_NM.NameValue(1,"PUMBUN_TYPE") == "5")
                	giftEnblCntl(true);
                else
                	giftEnblCntl(false);
                
        	}
            if(bfPumbunCd != pumbunCd || pumbunCd == ""){
                EM_I_BOTTLE_CD.Text = "";
                EM_I_BOTTLE_NAME.Text = "";         
            }
        }
        setPummokCombo( pmkComboObj, pumbunCd,selInGb);
    	
    	if(selInGb == "I"){
        	setComboData(pmkComboObj,DS_MASTER.OrgNameValue(DS_MASTER.RowPosition,"PUMMOK_CD"));
        }
    }else{
        setPummokCombo( pmkComboObj, pumbunCd ,selInGb);
    }
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
 * setCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 필수 공통코드/명을 등록한다.
 * return값 : void
 */
function setIndiCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){

    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }

    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : 'SEL_COMM_CODE_ONLY';
    
    if( evnflag == "POP" ){
    	commonPop(title, comSqlId,codeObj ,nameObj,'D',comId);
        codeObj.Focus();
        return;
    }

    nameObj.Text = "";
    setNmWithoutPop('DS_SEARCH_NM',title, comSqlId,codeObj ,nameObj,'D',comId);
    
    if( DS_SEARCH_NM.CountRow == 1){
    	codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
    	nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
    	return;
    }else{
        nameObj.Text = "";
    }
    commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
    codeObj.Focus();
}

/**
 * setSkuCdCombo()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 공병명을 등록한다.
 * return값 : void
 */
function setSkuCdCombo(evnflag, scrFlag){
    var codeObj = scrFlag=="I"?EM_I_BOTTLE_CD:EM_O_SKU_CD;
    var nameObj = scrFlag=="I"?EM_I_BOTTLE_NAME:EM_O_SKU_NAME;
    

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
/**
 * setCopyPoint()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 복사기준점을 생성한다.
 * return값 : void
 */
function setCopyPoint(){
	DS_O_COPY_POINT.ClearData();
	for( var i=1; i<=DS_DETAIL.CountRow; i++){
		if( DS_DETAIL.NameValue(i,"SEL")=="T"||DS_DETAIL.RowStatus(i)==3){
			DS_O_COPY_POINT.addRow();
			DS_O_COPY_POINT.NameValue(DS_O_COPY_POINT.CountRow,"CODE") = DS_DETAIL.NameValue(i,"STR_CD");
            DS_O_COPY_POINT.NameValue(DS_O_COPY_POINT.CountRow,"NAME") = DS_STR_CD.NameValue(DS_STR_CD.NameValueRow("CODE",DS_DETAIL.NameValue(i,"STR_CD")),"NAME");
		}
	}
}

/**
 * setVenCodeToGrid()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 협력사 팝업을 실행한다.(그리드)
 * return값 : void
**/
function setVenCodeToGrid(evnFlag, row){
    var codeStr = DS_DETAIL.NameValue(row,"VEN_CD");
    var strCd   = DS_DETAIL.NameValue(row,"STR_CD");
    if( strCd == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        setTimeout("setFocusGrid(GD_MASTER,DS_DETAIL,"+row+",'STR_CD');",50);
        return ;
    }
    if( codeStr == "" && evnFlag != 'POP'){
        DS_DETAIL.NameValue(row,"VEN_NAME")   = "";
        return;
    }
    var rtnMap;
    if( evnFlag == 'POP'){
        rtnMap = venToGridPop(codeStr,'',strCd,'Y','','1');
    }else{
        DS_DETAIL.NameValue(row,"VEN_NAME") = "";
        rtnMap = setVenNmWithoutToGridPop("DS_SEARCH_NM", codeStr, '' , 1,strCd,'Y','','1');
    }
    
    if( rtnMap == null){
        if( DS_DETAIL.NameValue(row,"VEN_NAME") == ""){
            DS_DETAIL.NameValue(row,"VEN_CD") = "";
        }       
        return;
    }
    
    DS_DETAIL.NameValue(row,"VEN_CD")     = rtnMap.get("VEN_CD");
    DS_DETAIL.NameValue(row,"VEN_NAME")   = rtnMap.get("VEN_NAME");
    
}
/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 단품정보 입력을 체크한다.
 * return값 : void
 */
function checkMasterValidation(){
    var check = false;
    var titleNm = "";
    var componentId = "";
    
    var row = DS_MASTER.RowPosition;
    var rowStatus = DS_MASTER.RowStatus(row);
    
    if( rowStatus == 1 && DS_MASTER.NameValue( row, "PUMBUN_CD") == ''){
        check = true;
        titleNm = "브랜드";
        componentId = "EM_I_PUMBUN_CD";
    } else if( rowStatus == 1 && DS_MASTER.NameValue( row, "PUMBUN_NAME") == ''){
    	// 존재하지 않은 브랜드 입니다.
    	showMessage(EXCLAMATION, OK, "USER-1036", "브랜드")
        EM_I_PUMBUN_CD.Focus();
        return false;
    }else if( DS_MASTER.NameValue( row, "SKU_NAME") == ''){
        check = true;
        titleNm = "단품명";
        componentId = "EM_I_SKU_NAME";
    }else if( !checkInputByte( null, DS_MASTER, row, "SKU_NAME", "단품명", "EM_I_SKU_NAME") ){
        return false;
    	
    }else if( DS_MASTER.NameValue( row, "RECP_NAME") == ''){
        check = true;
        titleNm = "영수증명";
        componentId = "EM_I_RECP_NAME";
    }else if( !checkInputByte( null, DS_MASTER, row, "RECP_NAME", "영수증명", "EM_I_RECP_NAME") ){
        return false;
    }else if( DS_MASTER.NameValue( row, "PUMMOK_CD") == ''){
        check = true;
        titleNm = "품목";
        componentId = "LC_I_PUMMOK_CD";
    }else if( DS_MASTER.NameValue( row, "INPUT_PLU_CD") != ''){    	
        var tmpInputPlu = lpad(EM_I_INPUT_PLU_CD.Text,13,"0");
        if( tmpInputPlu.substr(0,1)=='2'){
            showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드"); 
            EM_I_INPUT_PLU_CD.Focus();
            return false;
        }
        if(!isSkuCdCheckSum(tmpInputPlu)){
            showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드");
            EM_I_INPUT_PLU_CD.Focus();
            return false;     
        }
    }else if( DS_MASTER.NameValue( row, "SALE_UNIT_CD") == ''){
        check = true;
        titleNm = "판매단위";
        componentId = "LC_I_SALE_UNIT_CD";
    }else if( DS_MASTER.NameValue( row, "SET_YN") == ''){
        check = true;
        titleNm = "SET여부";
        componentId = "LC_I_SET_YN";
    }else if( DS_MASTER.NameValue( row, "GIFT_FLAG") == ''){
        check = true;
        titleNm = "GIFT구분";
        componentId = "LC_I_GIFT_FLAG";
    }else if( DS_MASTER.NameValue( row, "GIFT_TYPE_CD") != ''){	// 상품권 종류가 null이 아니면 상품권금종 체크추가 20170131 P.R.H
    	if(DS_MASTER.NameValue( row, "GIFT_AMT_TYPE") == ''){
            check = true;
            titleNm = "상품권 금종";
            componentId = "LC_I_GIFT_AMT_TYPE";
    	}
    }else if( DS_MASTER.NameValue( row, "MAKER_CD") != '' && DS_MASTER.NameValue( row, "EM_I_MAKER_NAME") == ''){
        // 존재하지 않은 메이커 입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "메이커");
        EM_I_MAKER_CD.Focus();
        return false;
    }else if( !checkInputByte( null, DS_MASTER, row, "REMARK", "비고", "EM_I_REMARK") ){
        return false;
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        eval(componentId).Focus();
        return false;
    }
	return true;
}

/**
 * checkDetailValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 점별단품정보 입력을 체크한다.
 * return값 : void
 */
function checkDetailValidation(){
    var check = false;
    var titleNm = "";
    var colId = "";
    var row = "";
    for(var i = 1; i <= DS_DETAIL.CountRow; i++ ) {
        var rowStatus = DS_DETAIL.RowStatus(i);
        if( rowStatus == 0 
                || rowStatus == 2
                || rowStatus == 4)
                continue;
        row = i;
        var skuCd = DS_DETAIL.NameValue( i, "SKU_CD");

        if( DS_DETAIL.NameValue( i, "VEN_CD") == ''){
            check = true;
            titleNm = "협력사";
            colId = "VEN_CD";
            break;
        }
        if( DS_DETAIL.NameValue( i, "VEN_NAME") == ''){
            showMessage(EXCLAMATION, Ok,  "USER-1036", "협력사");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'VEN_CD');
            return false;                    
        }
        if( Number(DS_DETAIL.NameString( i, "SAL_COST_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "판매원가","0");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'SAL_COST_PRC');
            return false;                    
        }
        if( Number(DS_DETAIL.NameString( i, "SALE_PRC")) < 0 ){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "판매매가","0");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'SALE_PRC');
            return false; 
        }
        if( Number(DS_DETAIL.NameString( i, "SALE_PRC")) == 0 ){
        	if(showMessage(QUESTION, YESNO, "USER-1000", "판매매가가  0 입니다.<br>진행하시겠습니까?") != 1){ 
	            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'SALE_PRC');
	            return false; 
        	}
        }
        // MARIO OUTLET 2011-09-05
        //if( Number(DS_DETAIL.NameString( i, "SALE_PRC")) < 1 ){
        //    showMessage(EXCLAMATION, Ok,  "USER-1020", "판매매가","1");
        //    setFocusGrid(GD_DETAIL,DS_DETAIL,i,'SALE_PRC');
        //    return false;                    
        //}
        
        // MARIO OUTLET 2011-08-11 
        // getRoundDec() 원단위 절사함수
        //if(Number(DS_DETAIL.NameString( i, "SALE_PRC")) > 0) {
	    //    if((Number(DS_DETAIL.NameString( i, "SALE_PRC"))%10) > 0) {
	    //    	showMessage(EXCLAMATION, Ok,  "USER-1000", "판매매가는 원단위로 입력 할 수 없습니다.");
	    //        setFocusGrid(GD_DETAIL,DS_DETAIL,i,'SALE_PRC');
	    //    	return false;	
	    //    }
        //}
     
        var lowMgRate = Number(DS_DETAIL.NameString( i, "LOW_MG_RATE"));
        if( Number(DS_DETAIL.NameString( i, "SALE_MG_RATE")) < lowMgRate ){
        	if( lowMgRate == 0)
        	    showMessage(EXCLAMATION, Ok,  "USER-1020", "마진율",lowMgRate);
        	else
                showMessage(EXCLAMATION, Ok,  "USER-1081", lowMgRate);
        	
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'SALE_MG_RATE');
            return false;                    
        }
        if( Number(DS_DETAIL.NameString( i, "SALE_MG_RATE")) > 100 ){
            showMessage(EXCLAMATION, Ok,  "USER-1021", "마진율","100");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'SALE_MG_RATE');
            return false;                    
        }
        
        var ordYn = DS_DETAIL.NameValue( i, "ADV_ORD_YN");
        if( ordYn == 'Y' && Number(DS_DETAIL.NameValue( i, "LOW_ORD_QTY")) < 0){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "최소발주량","0");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'LOW_ORD_QTY');
            return false;  
        }
        if( ordYn == 'Y' && Number(DS_DETAIL.NameValue( i, "OTM_STK_QTY")) < 0){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "적정재고량","0");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'OTM_STK_QTY');
            return false;  
        }
        if( ordYn == 'Y' && Number(DS_DETAIL.NameValue( i, "LEAD_TIME")) < 0){
            showMessage(EXCLAMATION, Ok,  "USER-1020", "리드타임","0");
            setFocusGrid(GD_DETAIL,DS_DETAIL,i,'LEAD_TIME');
            return false;  
        }
        /* 필수체크 제외 (2010.03.18 : 김수현 요청)

        if( DS_DETAIL.NameValue( i, "SALE_S_DT") == ''){
            check = true;
            titleNm = "판매시작일";
            colId = "SALE_S_DT";
            break;
        }
        if( DS_DETAIL.NameValue( i, "SALE_E_DT") == ''){
            check = true;
            titleNm = "판매종료일";
            colId = "SALE_E_DT";
            break;
        }
        if( DS_DETAIL.NameValue( i, "BUY_S_DT") == ''){
            check = true;
            titleNm = "매입시작일";
            colId = "BUY_S_DT";
            break;
        }
        if( DS_DETAIL.NameValue( i, "BUY_E_DT") == ''){
            check = true;
            titleNm = "매입종료일";
            colId = "BUY_E_DT";
            break;
        }
        */
        var toDay = getTodayFormat("YYYYMMDD");
        if( DS_DETAIL.NameValue( i, "SALE_S_DT") != DS_DETAIL.OrgNameValue( i, "SALE_S_DT")
                && DS_DETAIL.NameValue( i, "SALE_S_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "판매시작일");
            setFocusGrid(GD_DETAIL,DS_DETAIL,row,"SALE_S_DT");
            return false;
        }
        if( DS_DETAIL.NameValue( i, "SALE_E_DT") != DS_DETAIL.OrgNameValue( i, "SALE_E_DT")
                && DS_DETAIL.NameValue( i, "SALE_E_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "판매종료일");
            setFocusGrid(GD_DETAIL,DS_DETAIL,row,"SALE_E_DT");
            return false;
        }
        if( DS_DETAIL.NameValue( i, "BUY_S_DT") != DS_DETAIL.OrgNameValue( i, "BUY_S_DT")
                && DS_DETAIL.NameValue( i, "BUY_S_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "매입시작일");
            setFocusGrid(GD_DETAIL,DS_DETAIL,row,"BUY_S_DT");
            return false;
        }
        if( DS_DETAIL.NameValue( i, "BUY_E_DT") != DS_DETAIL.OrgNameValue( i, "BUY_E_DT")
                && DS_DETAIL.NameValue( i, "BUY_E_DT") < toDay){
            showMessage(Information, OK, "USER-1030", "매입종료일");
            setFocusGrid(GD_DETAIL,DS_DETAIL,row,"BUY_E_DT");
            return false;
        }
        
        if( DS_DETAIL.NameValue( i, "SALE_S_DT") > DS_DETAIL.NameValue( i, "SALE_E_DT")){

            showMessage(Information, OK, "USER-1008", "판매시작일","판매종료일");
            setFocusGrid(GD_DETAIL,DS_DETAIL,row,"SALE_E_DT");
            return false;
        }
        if( DS_DETAIL.NameValue( i, "BUY_S_DT") > DS_DETAIL.NameValue( i, "BUY_E_DT")){

            showMessage(Information, OK, "USER-1008", "매입시작일","매입종료일");
            setFocusGrid(GD_DETAIL,DS_DETAIL,row,"BUY_E_DT");
            return false;
        }
        
    }
    
    if( check ){
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", titleNm);
        setFocusGrid(GD_DETAIL,DS_DETAIL,row,colId);
        return false;
    }
    return true;
}


/**
 * fn_mgRate()
 * 작 성 자 : 김장훈
 * 작 성 일 : 2011-03-10
 * 개    요    :  MARIO OUTLET 에만 적용
 * return값 : void
 */
function fn_mgRate(){
	// (2)특정인경우에만 해당  
	if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "BIZ_TYPE") == "2") {
		DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "SALE_MG_RATE") =  DS_DETAIL.NameValue(DS_DETAIL.RowPosition, "NORM_MG_RATE");	
	}
	
}


/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_skuprc_emg(){
	
	 	var strPumbunCd  = EM_O_PUMBUN_CD.Text;
		//var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
		var strProcDt       = getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')));

        if( strPumbunCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","브랜드이 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strProcDt="  + encodeURIComponent(strProcDt)
	    					  + "&strPumbunCd="  + encodeURIComponent(strPumbunCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod521.pc?goTo=sendskuprcemg"+parameters;
	    	TR_MAIN.KeyValue = "SERVLET(O:DS_MASTER=DS_MASTER)";
	    	//searchSetWait("B"); // 프로그래스바
	    	TR_MAIN.Post();        
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

    setPummokCombo( LC_I_PUMMOK_CD,this.NameValue(row,"PUMBUN_CD"),"I");
    //setPumbunCdCombo("I", "NAME");
    
    if( this.RowStatus(row) == 1){
        masterEnblCntl(true);
        if(DS_MASTER.NameValue(row,"PUMBUN_TYPE") == "5")
            giftEnblCntl(true);
        else
            giftEnblCntl(false);
    	return;
    }
    masterEnblCntl(false);
    giftEnblCntl(false);

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
            
            // MARIO OUTLET START 2011-08-10
            if( eval(this.DataID).NameValue(row,colid) =="T") {
            	eval(this.DataID).NameValue(row,colid) ="F";
            } else {
                eval(this.DataID).NameValue(row,colid) ="T";
            	fn_mgRate();
            }
         	// MARIO OUTLET END
        }
    }
</script>
 
 
<script language=JavaScript for=GD_DETAIL event=OnListSelect(index,row,colid)>
    if( row < 1)
    	return;
    if( colid=='ADV_ORD_YN' && index == 2){
        eval(this.DataID).NameValue(row,"LOW_ORD_QTY")="";
        eval(this.DataID).NameValue(row,"OTM_STK_QTY")="";
        eval(this.DataID).NameValue(row,"LEAD_TIME")="";    	
    }else if( colid=='USE_YN'){
    	if(LC_I_USE_YN.BindColVal == 'N' && index == 1){
    		showMessage(EXCLAMATION, OK, "USER-1000", "단품의 사용여부가 'NO'입니다.");
    		eval(this.DataID).NameValue(row,"USE_YN") = "N";
    	}
    }
</script>
 

<!-- DETAIL 데이터별경  -->
<script language=JavaScript for=GD_DETAIL event=OnExit(row,colid,oldValue)>
    if(row < 1)
    	return true;
    if(isOnPopup)
    	return;
    if(oldValue == DS_DETAIL.NameValue(row,colid))
    	return;
    switch(colid){
        case 'SAL_COST_PRC':
        case 'SALE_PRC':
        case 'SALE_MG_RATE':            
            var bizType    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"BIZ_TYPE");
            var taxFlag    = DS_MASTER.NameValue(DS_MASTER.RowPosition,"TAX_FLAG");
            var roundFlag  = DS_DETAIL.NameValue(row,"ROUND_FLAG");
            var salCostPrc = DS_DETAIL.NameString(row,"SAL_COST_PRC");
            var salePrc    = DS_DETAIL.NameString(row,"SALE_PRC");
            var saleMgRate = DS_DETAIL.NameString(row,"SALE_MG_RATE");

            salCostPrc = Number(salCostPrc);
            salePrc    = Number(salePrc);
            saleMgRate = Number(saleMgRate);
            // 거래형태[직매입]
            if( bizType == "1"){
                // 판매원가와 판매매가을 등록하면 마진율을 계산
            	eval(this.DataID).NameValue(row,"SALE_MG_RATE") = getSaleMgRate(salCostPrc, salePrc, roundFlag, taxFlag);
            // 거래형태[특정매입]
            }else {
                // 판매매가와 마진율을 등록하면 판매원가을 계산
                eval(this.DataID).NameValue(row,"SAL_COST_PRC") = getSalCostPrc(salePrc, saleMgRate, roundFlag, taxFlag);
            }
        	break;
        case 'SALE_S_DT':
        case 'SALE_E_DT':
        case 'BUY_S_DT':
        case 'BUY_E_DT':
        	var value = eval(this.DataID).NameValue(row,colid);
            var orgValue = eval(this.DataID).OrgNameValue(row,colid);
            if( value == orgValue || value == "" )
            	break;
            
            if(!checkDateTypeYMD(this,colid,'')){
            	setTimeout("setFocusGrid(GD_DETAIL,DS_DETAIL,"+row+",'"+colid+"');",50);
                return false;
            }
        	var colName = this.GetHdrDispName(-3, colid);
        	// 날짜는 금일 이후로 등록 가능합니다.
        	if( value < getTodayFormat("YYYYMMDD")){
        		// ()는 금일 이후로 등록 가능합니다.
                showMessage(EXCLAMATION, OK, "USER-1030", colName);
                eval(this.DataID).NameValue(row,colid) = "";
                setCopyPoint();
                setTimeout("setFocusGrid(GD_DETAIL,DS_DETAIL,"+row+",'"+colid+"');",50);
                return false;
        	}
        	break;
        case 'USE_YN':

            if((eval(this.DataID).NameValue(row,'SEL')=="T"
                || eval(this.DataID).RowStatus(row)==3)
                && eval(this.DataID).NameValue(row,colid)=="Y"){
                setComboData(LC_I_USE_YN,"Y");
                return;
            }
        	break;
        case 'VEN_CD':
        	setVenCodeToGrid("NAME", row)
            break;
    }
    setCopyPoint();
    return true;
</script>

<!-- DETAIL 팝업  -->
<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
    isOnPopup = true;
    
    switch(colid){
        case 'SALE_S_DT':
        case 'SALE_E_DT':
        case 'BUY_S_DT':
        case 'BUY_E_DT':
            openCal(this,row,colid);
            break;
        case 'VEN_CD':
        	setVenCodeToGrid("POP", row)
            break;
    }
    isOnPopup = false;
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

<!-- 브랜드(입력) -->
<script language=JavaScript for=EM_I_PUMBUN_CD event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPumbunCdCombo("I", "NAME");
</script>

<!-- 품목(입력) -->
<script language=JavaScript for=LC_I_PUMMOK_CD event=onSelChange()>
    if( this.BindColVal == '')
        return;
    DS_MASTER.NameValue(DS_MASTER.RowPosition,"PUMMOK_NAME") = this.Text;
    var unitCd = this.ValueByColumn("CODE", this.BindColVal, "UNIT_CD"); 

    DS_MASTER.NameValue(DS_MASTER.RowPosition,"SALE_UNIT_CD") =  DS_MASTER.NameValue(DS_MASTER.RowPosition,"SALE_UNIT_CD")==''?unitCd:DS_MASTER.NameValue(DS_MASTER.RowPosition,"SALE_UNIT_CD");
</script>
<!-- 판매단위(입력) -->
<script language=JavaScript for=LC_I_SALE_UNIT_CD event=onSelChange()>
    /* 제외( 김수현:2010.04.05 요청)
    if( this.BindColVal == '')
        return;
    var unitCd = this.BindColVal;
    if(DS_MASTER.RowStatus(DS_MASTER.RowPosition)==1){
        DS_MASTER.NameValue(DS_MASTER.RowPosition,"CMP_SPEC_UNIT") = DS_MASTER.NameValue(DS_MASTER.RowPosition,"CMP_SPEC_UNIT")!=''?unitCd:DS_MASTER.NameValue(DS_MASTER.RowPosition,"CMP_SPEC_UNIT");
        DS_MASTER.NameValue(DS_MASTER.RowPosition,"BAS_SPEC_UNIT") = DS_MASTER.NameValue(DS_MASTER.RowPosition,"BAS_SPEC_UNIT")!=''?unitCd:DS_MASTER.NameValue(DS_MASTER.RowPosition,"BAS_SPEC_UNIT");
    }
    */
</script>
<!-- 사용여부 -->
<script language=JavaScript for=LC_I_USE_YN event=onSelChange()>
    if( this.BindColVal == '' || this.BindColVal == 'Y')
        return;
    for(var i=1; i<=DS_DETAIL.CountRow; i++){
    	if(DS_DETAIL.NameValue(i,'SEL')=="T"
    		|| DS_DETAIL.RowStatus(i)==3){
    		if(DS_DETAIL.NameValue(i,'USE_YN')=='Y'){
    			showMessage(EXCLAMATION, OK, "USER-1000","점별단품정보에 사용여부가 [Y]인 항목이 존재합니다.");
    			setComboData(this,"Y");
    			return;
    		}
    	}
    }
</script>

<!-- 원산지 -->
<script language=JavaScript for=EM_I_ORIGIN_AREA_CD event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setIndiCommonPop('원산지', 'P040', 'NAME', EM_I_ORIGIN_AREA_CD, EM_I_ORIGIN_AREA_NAME,'I');
</script>

<!-- 메이커 -->
<script language=JavaScript for=EM_I_MAKER_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setIndiCommonPop('메이커', 'P019', 'NAME', EM_I_MAKER_CD, EM_I_MAKER_NAME,'I');
</script>
<script language=JavaScript for=EM_O_SKU_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setSkuCdCombo('NAME','S');
</script>
<!-- 공병단품 -->
<script language=JavaScript for=EM_I_BOTTLE_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setSkuCdCombo('NAME','I');
</script>
<!-- 상품권종류 -->
<script language=JavaScript for=LC_I_GIFT_TYPE_CD event=onSelChange()>
    DS_I_GIFT_AMT_TYPE.ClearData();
    if( this.BindColVal == '')
    	return;
    //상품권 관련 공통 콤보 조회 ( popup_mss.js ) ( 상품권종류코드(필수) 발행형태(필수) )       
    getGiftCombo("DS_I_GIFT_AMT_TYPE", "AMT", this.BindColVal, '1');
    //빈값 추가
    insComboFirstNullId(LC_I_GIFT_AMT_TYPE,"");
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_I_GIFT_AMT_TYPE,"");
</script>
<!-- 소스마킹코드 -->
<script language=JavaScript for=EM_I_INPUT_PLU_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
    	return;
    if(this.Text==''){
    	//자동발번
        setComboData(LC_I_PLU_FLAG,"1");    	 
        return;   	
    }
    var tmpInputPlu = lpad(this.Text,13,"0");
    if( tmpInputPlu.substr(0,1)=='2'){
        showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드");    	
        this.Text = "";
        this.Focus();
        return;
    }
    if(!isSkuCdCheckSum(tmpInputPlu)){
        showMessage(EXCLAMATION, OK, "USER-1069", "소스마킹코드");
        this.Text = "";
        this.Focus();
        return;    	
    }
    //소스마킹
    setComboData(LC_I_PLU_FLAG,"2");        
    
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
<comment id="_NSID_"><object id="DS_O_COPY_POINT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_PLU_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PUMMOK_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CMP_SPEC_UNIT_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_BAS_SPEC_UNIT_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SET_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_GIFT_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_GIFT_TYPE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_GIFT_AMT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SALE_UNIT_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="50" class="point">브랜드</th>
            <td width="180">
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  onclick="javascript:setPumbunCdCombo('S','POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=98 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="30">품목</th>
            <td width="90">
              <comment id="_NSID_">
                <object id=LC_O_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=90 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="30">단품</th>
            <td width="240">
              <comment id="_NSID_">
                <object id=EM_O_SKU_CD classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  onclick="javascript:setSkuCdCombo('POP','S');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_SKU_NAME classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="50">사용여부</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=60 tabindex=1 align="absmiddle"></object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"  ></td>
  </tr> 
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="280">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=604 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table></td>
          <td class="PL10 PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PB03" align="absmiddle"/> 단품정보</td>
                  
	                    <td width="140">
	            		<table width="100%" >
	                    <td align="right">
							<table border="0" cellspacing="0" cellpadding="0">
							  <tr>
							    <td class="btn_l"> </td>
							    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_skuprc_emg()">긴급단품정보전송</a></td>
							    <td class="btn_r"></td>
							  </tr>
							</table>                
		                </td>		
						</table>				
			            </td>		
			            
                </tr>
              </table></td>
            </tr>
            <tr>
              <td class="PT03"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td ><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                  
                  
                    <tr>
                      <th class="point" width="90">브랜드</th>
                      <td colspan="3">
                        <comment id="_NSID_">
                          <object id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=137 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_PUMBUN onclick="javascript:if(EM_I_PUMBUN_CD.Enable) setPumbunCdCombo('I','POP');"  align="absmiddle" />
                        <comment id="_NSID_">
                          <object id=EM_I_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=243 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    <tr>
                      <th>대표브랜드</th>
                      <td  width="170">
                        <comment id="_NSID_">
                          <object id=EM_REP_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                      <th width="120">협력사</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    <tr>
                      <th class="point">단품코드</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_SKU_CD classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                      <th class="point">PLU구분</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=LC_I_PLU_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th class="point">단품명</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_SKU_NAME classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                      <th >소스마킹코드</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_INPUT_PLU_CD classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th class="point">영수증명</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_RECP_NAME classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                      <th class="point">품목</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=LC_I_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th >원산지</th>
                      <td colspan="3">
                        <comment id="_NSID_">
                          <object id=EM_I_ORIGIN_AREA_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_ORIGIN_AREA_CD onclick="javascript:setIndiCommonPop('원산지', 'P040', 'POP', EM_I_ORIGIN_AREA_CD, EM_I_ORIGIN_AREA_NAME,'I');"  align="absmiddle" />
                        <comment id="_NSID_">
                          <object id=EM_I_ORIGIN_AREA_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th >공병단품코드</th>
                      <td colspan="3">
                        <comment id="_NSID_">
                          <object id=EM_I_BOTTLE_CD classid=<%=Util.CLSID_EMEDIT%> width=137 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_BOTTLE_CD onclick="javascript:setSkuCdCombo('POP','I');"  align="absmiddle" />
                        <comment id="_NSID_">
                          <object id=EM_I_BOTTLE_NAME classid=<%=Util.CLSID_EMEDIT%> width=243 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th class="point">판매단위</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=LC_I_SALE_UNIT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                      <th class="point">SET여부</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=LC_I_SET_YN classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th >기본규격</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_BAS_SPEC_CD classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                      <th >기본규격단위</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=LC_I_BAS_SPEC_UNIT_CD classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th >구성규격</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_CMP_SPEC_CD classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                      <th >구성규격단위</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=LC_I_CMP_SPEC_UNIT_CD classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th class="point">GIFT구분</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=LC_I_GIFT_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                      <th class="point">사용여부</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=LC_I_USE_YN classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th >상품권종류</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=LC_I_GIFT_TYPE_CD classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                      <th >상품권금종</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=LC_I_GIFT_AMT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                    
                    <tr>
                      <th >메이커</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_MAKER_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_MAKER_CD onclick="javascript:setIndiCommonPop('메이커', 'P019', 'POP', EM_I_MAKER_CD, EM_I_MAKER_NAME,'I');"  align="absmiddle" />
                        <comment id="_NSID_">
                          <object id=EM_I_MAKER_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
<!--                       <th >모델코드</th> -->
                      <th >브랜드상품코드</th>
                      <td >
                        <comment id="_NSID_">
                          <object id=EM_I_MODEL_CD classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>비고</th>
                      <td>
                        <comment id="_NSID_">
                          <object id=EM_I_REMARK classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                      </td>
                    </tr>
                    
                    
                   	<tr>
                      <td colspan="4">
                      	<font color="red"><b>여기서 메뉴등록 후 F&B메뉴관리에 추가를 해야 해당메뉴를 POS에서 사용할 수 있습니다.</b></font>
                      </td>
                   	</tr>
                    
                   	<tr>
                   		<td colspan="4">
                   			<font color="red"><b>마진율 직영일경우 100%로 꼭 입력하세요.    특정매입은 해당 브랜드마진을 입력&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↓↓↓</b></font>
                   		</td>
                   	</tr>
                   	
                    	
                  </table></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td class="PT10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr >
                  <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" align="absmiddle"/>점별단품정보</td>
                  <td class="right PB02" valign="bottom"> <img src="/<%=dir%>/imgs/comm/square_blue.gif" hspace="2" align="absmiddle"/>복사기준점
                    <comment id="_NSID_">
                      <object id=LC_O_COPY_POINT classid=<%= Util.CLSID_LUXECOMBO %> class="PB03" width=70 align="absmiddle" tabindex=1  hspace="2">
                      </object>
                    </comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/copy_row.gif" id=IMG_ROWCOPY  class="PB03" onClick="javascript:btn_rowCopy();" hspace="2" align="absmiddle"/><img src="/<%=dir%>/imgs/btn/reset_row.gif" id=IMG_ROWCLEAR onClick="javascript:btn_rowClear();" align="absmiddle"/>
                  </td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr valign="top">
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                    <tr>
                      <td>
                        <comment id="_NSID_"><object id=GD_DETAIL width="100%" height=140 classid=<%=Util.CLSID_GRID%>>
                          <param name="DataID" value="DS_DETAIL">
                        </object></comment><script>_ws_(_NSID_);</script>
                      </td>
                    </tr>
                  </table></td>
                </tr>
              </table></td>
            </tr>
          </table></td>
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
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID          value=DS_MASTER>
    <param name="ActiveBind"    value=true>
    <param name=BindInfo        value='
        <c>col=PUMBUN_CD        ctrl=EM_I_PUMBUN_CD         param=Text </c>
        <c>col=PUMBUN_NAME      ctrl=EM_I_PUMBUN_NAME       param=Text </c>
        <c>col=REP_PUMBUN_NAME  ctrl=EM_REP_PUMBUN_NAME     param=Text </c>
        <c>col=VEN_NAME         ctrl=EM_I_VEN_NAME          param=Text </c>
        <c>col=SKU_CD           ctrl=EM_I_SKU_CD            param=Text </c>
        <c>col=PLU_FLAG         ctrl=LC_I_PLU_FLAG          param=BindColVal </c>
        <c>col=SKU_NAME         ctrl=EM_I_SKU_NAME          param=Text </c>
        <c>col=INPUT_PLU_CD     ctrl=EM_I_INPUT_PLU_CD      param=Text </c>
        <c>col=RECP_NAME        ctrl=EM_I_RECP_NAME         param=Text </c>
        <c>col=PUMMOK_CD        ctrl=LC_I_PUMMOK_CD         param=BindColVal </c>
        <c>col=ORIGIN_AREA_CD   ctrl=EM_I_ORIGIN_AREA_CD    param=Text </c>
        <c>col=ORIGIN_AREA_NAME ctrl=EM_I_ORIGIN_AREA_NAME  param=Text </c>
        <c>col=SALE_UNIT_CD     ctrl=LC_I_SALE_UNIT_CD      param=BindColVal </c>
        <c>col=BOTTLE_CD        ctrl=EM_I_BOTTLE_CD         param=Text </c>
        <c>col=BOTTLE_NAME      ctrl=EM_I_BOTTLE_NAME       param=Text </c>
        <c>col=MODEL_NO         ctrl=EM_I_MODEL_CD          param=Text </c>
        <c>col=CMP_SPEC_CD      ctrl=EM_I_CMP_SPEC_CD       param=Text </c>
        <c>col=CMP_SPEC_UNIT    ctrl=LC_I_CMP_SPEC_UNIT_CD  param=BindColVal </c>
        <c>col=BAS_SPEC_CD      ctrl=EM_I_BAS_SPEC_CD       param=Text </c>
        <c>col=BAS_SPEC_UNIT    ctrl=LC_I_BAS_SPEC_UNIT_CD  param=BindColVal </c>
        <c>col=REMARK           ctrl=EM_I_REMARK            param=Text </c>
        <c>col=SET_YN           ctrl=LC_I_SET_YN            param=BindColVal </c>
        <c>col=GIFT_FLAG        ctrl=LC_I_GIFT_FLAG         param=BindColVal </c>
        <c>col=GIFT_TYPE_CD     ctrl=LC_I_GIFT_TYPE_CD      param=BindColVal </c>
        <c>col=GIFT_AMT_TYPE    ctrl=LC_I_GIFT_AMT_TYPE     param=BindColVal </c>
        <c>col=MAKER_CD         ctrl=EM_I_MAKER_CD          param=Text </c>
        <c>col=MAKER_NAME       ctrl=EM_I_MAKER_NAME        param=Text </c>
        <c>col=USE_YN           ctrl=LC_I_USE_YN            param=BindColVal </c>            
    '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

