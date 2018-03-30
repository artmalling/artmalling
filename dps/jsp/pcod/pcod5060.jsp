<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 품목코드> 규격단품조회
 * 작 성 일 : 2010.03.18
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod5060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 규격단품정보를 조회한다.
 * 이    력 :
 *        2010.03.18 (이재득) 신규작성
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

var strPumbunCd          = "";
var strSkuNm          = "";
var strSkuCd        = "";
var strPummokCd     = "";
var g_strPid           = "<%=pageName%>";                 // PID

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_I_SKU_COND.setDataHeader(   
            'PUMBUN_CD:STRING(8)'            
            +',PUMMOK_CD:STRING(8)'                        
            +',SKU_CD:STRING(13)'
            +',SKU_NM:STRING(40)' ); 
    DS_I_SKU_COND.ClearData();
    DS_I_SKU_COND.Addrow();
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화 
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6^0",  PK);    //브랜드코드
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", READ);  //브랜드명 
    initEmEdit(EM_O_SKU_CD, "CODE^13^#", NORMAL);   //단품코드
    initEmEdit(EM_O_SKU_NM, "GEN^40", NORMAL);   //단품명
    
    //콤보 초기화
    initComboStyle(LC_O_PUMMOK_CD,DS_O_PUMMOK_CD, "CODE^0^70,NAME^0^100", 1, NORMAL);  //품목(조회)
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )           
    getEtcCode("DS_I_ORIGIN_AREA_CD", "D", "P040", "N");  //원산지  
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");    //판매단위
    getEtcCode("DS_I_BAS_SPEC_UNIT", "D", "P013", "N");   //기본규격단위
    getEtcCode("DS_I_CMP_SPEC_UNIT", "D", "P013", "N");   //구성규격단위
    getEtcCode("DS_I_MAKER_CD", "D", "P019", "N");        //메이커코드
    getEtcCode("DS_I_GIFT_FLAG", "D", "P080", "N");       //GIFT구분    
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_PUMMOK_CD.setDataHeader('CODE:STRING(8),NAME:STRING(40)');    
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_PUMMOK_CD, "%", "전체", 1 );    
    
    setComboData(LC_O_PUMMOK_CD,"%");
    
    EM_O_PUMBUN_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"            width=30   align=center  </FC>' 
                     + '<FC>id=SKU_CD          name="단품코드"      width=110   align=center  </FC>'
                     + '<FC>id=SKU_NAME        name="단품명"        width=130   align=left    </FC>'
                     + '<FC>id=RECP_NAME       name="영수증명"      width=130   align=left   </FC>'                      
                     + '<FC>id=INPUT_PLU_CD    name="소스마킹코드"  width=110   align=left  </FC>'
                     + '<FC>id=PUMMOK_CD       name="품목코드"      width=90    align=center  </FC>'
                     + '<FC>id=PUMMOK_NAME     name="품목명"        width=90    align=left    </FC>'
                     + '<FC>id=ORIGIN_AREA_CD  name="원산지"        width=70    align=left    EditStyle=Lookup    Data="DS_I_ORIGIN_AREA_CD:CODE:NAME"</FC>'
                     + '<FC>id=MODEL_NO        name="모델코드"       width=200   align=left    </FC>' 
                     + '<FC>id=BOTTLE_CD       name="공병단품코드"   width=110  align=center  </FC>'
                     + '<FC>id=SALE_UNIT_CD    name="판매단위"       width=60   align=left   EditStyle=Lookup    Data="DS_I_SALE_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=BAS_SPEC_CD     name="기본규격"       width=60   align=right   </FC>'                      
                     + '<FC>id=BAS_SPEC_UNIT   name="기본규격단위"   width=90   align=left   EditStyle=Lookup    Data="DS_I_BAS_SPEC_UNIT:CODE:NAME"</FC>'
                     + '<FC>id=CMP_SPEC_CD     name="구성규격"       width=65   align=right    </FC>'
                     + '<FC>id=CMP_SPEC_UNIT   name="구성규격단위"   width=90   align=left   EditStyle=Lookup    Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"</FC>'                     
                     + '<FC>id=SET_YN          name="SET여부"        width=60   align=center  </FC>'
                     + '<FC>id=GIFT_FLAG       name="GIFT구분"       width=60   align=left  EditStyle=Lookup    Data="DS_I_GIFT_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=GIFT_TYPE_CD    name="상품권종류코드"  width=100  align=left  show="false" </FC>'                      
                     + '<FC>id=GIFT_AMT_TYPE   name="상품권금종코드"  width=100  align=left  show="false" </FC>'
                     + '<FC>id=GIFT_TYPE_NAME  name="상품권종류"     width=100  align=left   </FC>'                      
                     + '<FC>id=GIFT_AMT_NAME   name="상품권금종"     width=100  align=left   </FC>'
                     + '<FC>id=MAKER_CD        name="메이커"         width=100  align=left     EditStyle=Lookup    Data="DS_I_MAKER_CD:CODE:NAME"</FC>'
                     + '<FC>id=USE_YN          name="사용여부"       width=55   align=center   </FC>'                     
                     + '<FC>id=REMARK          name="비고"           width=200  align=left  </FC>';
                     
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
 * 작 성 일 : 2010.03.17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	DS_IO_MASTER.ClearData();
	DS_I_SKU_COND.UserStatus(1) = '1';

	strPumbunCd     = EM_O_PUMBUN_CD.Text;
	strSkuCd        = EM_O_SKU_CD.Text; 
    strSkuNm        = EM_O_SKU_NM.Text;       
    strPummokCd     = LC_O_PUMMOK_CD.Text;
    
    if( strPumbunCd == ""){
        // (브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_O_PUMBUN_NM.Text == ""){
        // 존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    

	var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod506.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_I_SKU_COND=DS_I_SKU_COND,"+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
     if (strSkuCd == "")
    	 strSkuCd = "전체";
     if (strSkuNm == "")
         strSkuNm = "전체";
     
     var parameters = "브랜드코드="+strPumbunCd                    
                    + " -품목코드="+strPummokCd
                    + " -단품코드="+strSkuCd 
                    + " -단품명="+strSkuNm;
       
   //openExcel2(GD_MASTER, "규격단품조회", parameters, true );
   openExcel5(GD_MASTER, "규격단품조회", parameters, true , "",g_strPid );

   
   GD_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.17
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * setPumbunCdCombo()
 * 작 성 자 : 이재득
 * 작 성 일 : 2010.03.18
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCdCombo(evnflag){
    var codeObj = EM_O_PUMBUN_CD;
    var nameObj = EM_O_PUMBUN_NM;
    var pmkComboObj = LC_O_PUMMOK_CD;
    eval(pmkComboObj.ComboDataID).ClearData();
    
    // 기본값 입력( gauce.js )
    insComboData( pmkComboObj, "%", "전체", 1 );      
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(pmkComboObj,"%");
    
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }

    var result = null;

    if( evnflag == "POP" ){
        result = strPbnPop2(codeObj,nameObj,'Y','','','','','','','','1','1');
        
    }else if( evnflag == "NAME" ){
        result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'','','','','','','','1','1');

        if( result != null){
            codeObj.Text = result.get("PUMBUN_CD");
            nameObj.Text = result.get("PUMBUN_NAME");
        }
    }

    if( result != null || DS_SEARCH_NM.CountRow == 1 ){   
    	var pumbunCd = codeObj.Text;
        getPbnPmkCode(pmkComboObj.ComboDataID,pumbunCd,"N");
        //콤보에 '전체' 추가
        insComboData(pmkComboObj,"%","전체",1);
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(pmkComboObj,"%");
    }
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

<!-- 단품코드 변경시 -->
<script language=JavaScript for=EM_O_SKU_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_SKU_NM.Text = "";
        return;
    }     
    setStrSkuNmWithoutPop( "DS_O_SKU_CD", this, EM_O_SKU_NM , 'Y' , '0','','',EM_O_PUMBUN_CD.Text,'','','','','1');
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    setPumbunCdCombo("NAME");
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
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
<comment id="_NSID_">
<object id="DS_O_PUMMOK_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_ORIGIN_AREA_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SALE_UNIT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BAS_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CMP_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_MAKER_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_GIFT_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SKU_COND" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="50" class="point">브랜드</th>
						<td width="166"><comment id="_NSID_"> <object id=EM_O_PUMBUN_CD
							classid=<%= Util.CLSID_EMEDIT %> width=55 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:setPumbunCdCombo('POP')" align="absmiddle" />
						<comment id="_NSID_"> <object id=EM_O_PUMBUN_NM
							classid=<%= Util.CLSID_EMEDIT %> width=80 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="50">품목</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_O_PUMMOK_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="50">단품</th>
						<td><comment id="_NSID_"> <object id=EM_O_SKU_CD
							classid=<%= Util.CLSID_EMEDIT %> width=100 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:strSkuPop(EM_O_SKU_CD,EM_O_SKU_NM,'Y','','',EM_O_PUMBUN_CD.Text,'','','','','1'); EM_O_SKU_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_SKU_NM classid=<%= Util.CLSID_EMEDIT %> width=130
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width="100%" height=503 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BO_SKU_COND classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_I_SKU_COND>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='            
            <c>col=PUMBUN_CD        ctrl=EM_O_PUMBUN_CD       param=Text </c>            
            <c>col=PUMMOK_CD        ctrl=LC_O_PUMMOK_CD       param=BindColVal </c>                         
            <c>col=SKU_CD           ctrl=EM_O_SKU_CD          param=Text </c>
            <c>col=SKU_NM           ctrl=EM_O_SKU_NM          param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

