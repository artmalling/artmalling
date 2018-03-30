<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상담/계약 > 상담관리 > 상담일지작성
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : mcou1050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.17 (김슬기) 신규작성
          2011.03.05 (김유완) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	//session 정보
	SessionInfo sessionInfo = (SessionInfo) session
			.getAttribute("sessionInfo");
	String sess_org_cd_t = sessionInfo.getORG_CD();
	String sess_user_id = sessionInfo.getUSER_ID();
	String contextRoot = request.getContextPath();

	int tmplen = (10 - (sess_org_cd_t.length()));
	String sess_org_cd = sess_org_cd_t;
	for (int i = 0; i < tmplen; i++) {
		sess_org_cd += "0";
	}
	//기본 URL
	String u = javax.servlet.http.HttpUtils.getRequestURL(request)
			.toString();
	String webDir = u.substring(0, u.lastIndexOf("mss") - 1);
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
//Session ORG_CD
var g_session_org_cd = "<%=sess_org_cd%>";
var g_today    = getTodayFormat("yyyymmdd")
var g_saveFlag  = true; //저장버튼 Flag
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
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MO_COUNSELDAILY"/>');
    // Output Data Set Header 초기화
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate("MST"); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_WRITE_SDT,  "SYYYYMMDD", NORMAL);   // [조회용]상담일자S
    initEmEdit(EM_S_WRITE_EDT,  "TODAY", NORMAL);       // [조회용]상담일자E
    initEmEdit(EM_S_TITLE,      "GEN", NORMAL);         // [조회용]제목
    initEmEdit(EM_S_PLACE,      "GEN", NORMAL);         // [조회용]장소
    initEmEdit(EM_S_BRAND_NM,   "GEN", NORMAL);         // [조회용]브랜드명
    initEmEdit(EM_S_VAN_NM,     "GEN", NORMAL);         // [조회용]협력사명
    initEmEdit(EM_S_PUMMOK_NM,  "GEN", NORMAL);         // [조회용]취급품목
    initEmEdit(EM_BUYER_CD,     "NUMBER3^6^2",NORMAL);  // [조회용]바이어코드
    initEmEdit(EM_BUYER_NM,     "GEN",READ);            // [조회용]바이어명
    initEmEdit(EM_TITLE,        "GEN", PK);             // 제목
    initEmEdit(EM_WRITE_DT,     "TODAY", PK);           // 상담일자
    initEmEdit(EM_PLACE,        "GEN", NORMAL);         // 장소
    initEmEdit(EM_BRAND_NM,     "GEN", NORMAL);         // 브랜드명
    initEmEdit(EM_VAN_NM,       "GEN", NORMAL);         // 협력사명
    initEmEdit(EM_PUMMOK_NM,    "GEN", NORMAL);         // 취급품목
    initEmEdit(EM_VAN_ATNT_NM,  "GEN^40^2", NORMAL);    // 협력사참석자 
    initEmEdit(EM_REQ_DT,       "YYYYMMDD", READ);      // 상담신청일(온라인)
    initEmEdit(EM_REQ_SEQ,      "GEN", READ);           // 상담SEQ(온라인)
    initEmEdit(EM_FILE_NM,      "GEN", READ);           // 첨부파일
    initTxtAreaEdit(TXT_CONTENT, "NORMAL");              // 내용
    
    //콤보 초기화
    initComboStyle(LC_SEL_STR_CD,DS_LC_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);     // [조회용]점코드 
    initComboStyle(LC_SEL_DEPT_CD,DS_LC_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]팀     
    initComboStyle(LC_SEL_TEAM_CD,DS_LC_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]파트    
    initComboStyle(LC_SEL_PC_CD,DS_LC_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);     // [조회용]PC  

    initComboStyle(LC_STR_CD,DS_LC_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);           // 점코드     
    initComboStyle(LC_BUYER,DS_LC_BUYER, "CODE^0^50,NAME^0^80", 1, PK);             // 바이어코드     
    initComboStyle(LC_PATH,DS_LC_PATH, "CODE^0^30,NAME^0^80", 1, NORMAL);           // 상담경로
    initComboStyle(LC_REQ_PATH,DS_LC_REQ_PATH, "CODE^0^30,NAME^0^80", 1, NORMAL);   // 상담신청경로
    initComboStyle(LC_TIME_HH,DS_LC_TIME_HH, "CODE^0^30,NAME^0^80", 1, PK);         // 시간
    initComboStyle(LC_TIME_MM,DS_LC_TIME_MM, "CODE^0^30,NAME^0^80", 1, PK);         // 분
    
    //시스템 코드 공통코드에서 가지고 오기
    getStore("DS_LC_STR_CD",    "Y", "1", "N");
    getStore("DS_LC_S_STR_CD",  "Y", "1", "N");
    getDept("DS_LC_DEPT_CD",    "N", LC_SEL_STR_CD.BindColVal, "Y");
    getTeam("DS_LC_TEAM_CD",    "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, "Y");
    getPc("DS_LC_PC_CD",        "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, LC_SEL_TEAM_CD.BindColVal, "Y");
    
    LC_SEL_STR_CD.Focus();
    LC_SEL_STR_CD.Index = 0;
    getEtcCode("DS_LC_PATH",   "D", "M069", "N");       // 상담경로
    getEtcCode("DS_LC_REQ_PATH",   "D", "M070", "N");   // 상담신청경로
    getEtcCode("DS_LC_TIME_HH",   "D", "M059", "N");    // 시간
    getEtcCode("DS_LC_TIME_MM",   "D", "M060", "N");    // 분
    
    enableControl(IMG_REQ,false);
    enableControl(IMG_WRITE_DT,false);
    enableControl(IMG_FILE_LINK,false);
    enableControl(IMG_FILE_DEL,false);
    enableControl(LC_STR_CD,false);
    objControl(false);
    
    getBuyer();
}

function gridCreate(gdGnb){
        //마스터그리드
        if (gdGnb == "MST") {
            var hdrProperies = ''
                + '<FC>ID={CURROW}      NAME="NO"'
                + '                                         WIDTH=30    ALIGN=CENTER</FC>'
                + '<FC>ID=WRITE_DT      NAME="상담일자"'
                + '                                         WIDTH=80    ALIGN=CENTER MASK="XXXX/XX/XX"  </FC>'
                + '<FC>ID=STR_CD        NAME="점"'
                + '                                         WIDTH=80    ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_LC_STR_CD:CODE:NAME" </FC>'
                + '<FC>ID=BUYER_CD      NAME="바이어"'
                + '                                         WIDTH=80    ALIGN=LEFT  SHOW=FALSE</FC>'
                + '<FC>ID=BUYER_NM      NAME="바이어명"'
                + '                                         WIDTH=80    ALIGN=LEFT  </FC>'
                + '<FC>ID=TITLE         NAME="제목"'
                + '                                         WIDTH=250   ALIGN=LEFT  </FC>'
                + '<FC>ID=BRAND_NM      NAME="브랜드명"'
                + '                                         WIDTH=80    ALIGN=LEFT  </FC>'
                + '<FC>ID=VAN_NM        NAME="협력사명"'
                + '                                         WIDTH=100   ALIGN=LEFT  </FC>'
                + '<FC>ID=PATH          NAME="상담경로 "'
                + '                                         WIDTH=100   ALIGN=RIGHT ALIGN=LEFT EDITSTYLE=LOOKUP   DATA="DS_LC_PATH:CODE:NAME" </FC>'
                + '<FC>ID=REQ_DT        NAME="상담신청일"'
                + '                                         WIDTH=80    ALIGN=CENTER    MASK="XXXX/XX/XX"   </FC>'
                + '<FC>ID=REQ_SEQ       NAME="상담신청순번"'
                + '                                         WIDTH=80    ALIGN=CENTER    </FC>'
                + '<FC>ID=REQ_TITLE     NAME="상담신청제목"'
                + '                                         WIDTH=250   ALIGN=LEFT  </FC>'
                + '<FC>ID=TIME_HH       NAME="상담시간(시)"'
                + '                                         WIDTH=70    ALIGN=CENTER    SHOW=FALSE</FC>'
                + '<FC>ID=TIME_MM       NAME="상담시간(분)"'
                + '                                         WIDTH=70    ALIGN=CENTER    SHOW=FALSE</FC>'
                + '<FC>ID=PLACE         NAME="상담시간"'
                + '                                         WIDTH=60    ALIGN=CENTER    SHOW=FALSE</FC>'
                + '<FC>ID=PUMMOK_NM     NAME="상담품목"'
                + '                                         WIDTH=80    ALIGN=CENTER    SHOW=FALSE</FC>'
                + '<FC>ID=VAN_ATNT_NM   NAME="협력참석자"'
                + '                                         WIDTH=80    ALIGN=CENTER    SHOW=FALSE</FC>'
                + '<FC>ID=REQ_PATH      NAME="신청경로"'
                + '                                         WIDTH=80    ALIGN=CENTER    SHOW=FALSE</FC>'
                + '<FC>ID=FILE_PATH     NAME="첨부파일경로"'
                + '                                         WIDTH=80    ALIGN=CENTER    SHOW=FALSE</FC>'
                + '<FC>ID=FILE_NM       NAME="첨부파일명"'
                + '                                         WIDTH=70    ALIGN=CENTER    SHOW=FALSE</FC>'
                ;
            initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
        }
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
function btn_Search(preRow) {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
            //일자체크
            if (!checkValidate()) return;
            
            //parameters
            var strSStrCd       = LC_SEL_STR_CD.BindColVal; // [조회용]점코드
            var strSSdate       = EM_S_WRITE_SDT.Text;      // [조회용]조회시작일
            var strSEdate       = EM_S_WRITE_EDT.Text;      // [조회용]조회종료일
            var strSTitle       = EM_S_TITLE.Text;          // [조회용]제목
            var strSPlace       = EM_S_PLACE.Text;          // [조회용]장소
            var strSBrandNm     = EM_S_BRAND_NM.Text;       // [조회용]브랜드명
            var strSVanNm       = EM_S_VAN_NM.Text;         // [조회용]협력사명
            var strSPummokNm    = EM_S_PUMMOK_NM.Text;      // [조회용]취급품목
            var strSBuyerCd     = EM_BUYER_CD.Text;         // [조회용]바이어
            var strOrgCd        = LC_SEL_STR_CD.BindColVal;
            if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
                strOrgCd +=  "00000000";
            } else {
                strOrgCd += LC_SEL_DEPT_CD.BindColVal;
                if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
                    strOrgCd +=  "000000";
                } else {
                    strOrgCd += LC_SEL_TEAM_CD.BindColVal;
                    if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
                        strOrgCd +=  "0000";
                    } else {
                        strOrgCd += LC_SEL_TEAM_CD.BindColVal + "00";
                    }
                }
            }
            
            var goTo = "getMaster";
            var parameters = ""
                + "&strSStrCd="     + encodeURIComponent(strSStrCd) 
                + "&strSSdate="     + encodeURIComponent(strSSdate) 
                + "&strSEdate="     + encodeURIComponent(strSEdate) 
                + "&strSTitle="     + encodeURIComponent(strSTitle)
                + "&strSPlace="     + encodeURIComponent(strSPlace)
                + "&strSBrandNm="   + encodeURIComponent(strSBrandNm)
                + "&strSVanNm="     + encodeURIComponent(strSVanNm)
                + "&strSPummokNm="  + encodeURIComponent(strSPummokNm)
                + "&strSBuyerCd="   + encodeURIComponent(strSBuyerCd) 
                + "&strOrgCd="      + encodeURIComponent(strOrgCd);
            TR_MAIN.Action = "/mss/mcou105.mu?goTo=" + goTo + parameters;
            TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
            TR_MAIN.Post();
            
            // 조회결과 Return
            setPorcCount("SELECT", GD_MASTER);
            if (arguments[0] != undefined) {
                DS_IO_MASTER.RowPosition = arguments[0];
            }
            if (DS_IO_MASTER.CountRow < 1) {
                enableControl(IMG_REQ,false);
                enableControl(LC_STR_CD,false);
                objControl(false);
            }
        } else {
            return;
        }
        
    }  else {
		//일자체크
		if (!checkValidate()) return;
		//parameters
		var strSStrCd       = LC_SEL_STR_CD.BindColVal; // [조회용]점코드
		var strSSdate       = EM_S_WRITE_SDT.Text;      // [조회용]조회시작일
		var strSEdate       = EM_S_WRITE_EDT.Text;      // [조회용]조회종료일
		var strSTitle       = EM_S_TITLE.Text;          // [조회용]제목
		var strSPlace       = EM_S_PLACE.Text;          // [조회용]장소
		var strSBrandNm     = EM_S_BRAND_NM.Text;       // [조회용]브랜드명
		var strSVanNm       = EM_S_VAN_NM.Text;         // [조회용]협력사명
		var strSPummokNm    = EM_S_PUMMOK_NM.Text;      // [조회용]취급품목
		var strSBuyerCd     = EM_BUYER_CD.Text;         // [조회용]바이어
		var strOrgCd        = LC_SEL_STR_CD.BindColVal;
		if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
		    strOrgCd +=  "%";
		} else {
		    strOrgCd += LC_SEL_DEPT_CD.BindColVal;
		    if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
		        strOrgCd +=  "%";
		    } else {
		        strOrgCd += LC_SEL_TEAM_CD.BindColVal;
		        if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
		            strOrgCd +=  "%";
		        } else {
		            strOrgCd += LC_SEL_TEAM_CD.BindColVal + "%";
		        }
		    }
		}
		
		var goTo = "getMaster";
		var parameters = ""
		    + "&strSStrCd="     + encodeURIComponent(strSStrCd) 
		    + "&strSSdate="     + encodeURIComponent(strSSdate) 
		    + "&strSEdate="     + encodeURIComponent(strSEdate) 
		    + "&strSTitle="     + encodeURIComponent(strSTitle)
		    + "&strSPlace="     + encodeURIComponent(strSPlace)
		    + "&strSBrandNm="   + encodeURIComponent(strSBrandNm)
		    + "&strSVanNm="     + encodeURIComponent(strSVanNm)
		    + "&strSPummokNm="  + encodeURIComponent(strSPummokNm)
		    + "&strSBuyerCd="   + encodeURIComponent(strSBuyerCd) 
		    + "&strOrgCd="      + encodeURIComponent(strOrgCd);
			TR_MAIN.Action = "/mss/mcou105.mu?goTo=" + goTo + parameters;
			TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
			TR_MAIN.Post();
			
			// 조회결과 Return
			setPorcCount("SELECT", DS_IO_MASTER.CountRow);
			if (arguments[0] != undefined) {
			    DS_IO_MASTER.RowPosition = arguments[0];
			}
			
			if (DS_IO_MASTER.CountRow < 1) {
			    enableControl(IMG_REQ,false);
			    enableControl(LC_STR_CD,false);
			    objControl(false);
			}
			setPorcCount("SELECT", GD_MASTER);
    }
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
         var ret = showMessage(Question, YesNo, "USER-1050");
         if (ret == "1") {
             //일자체크
             if (!checkValidate()) return;
             
             //parameters
             var strSSdate       = EM_S_WRITE_SDT.Text;      // [조회용]조회시작일
             var strSEdate       = EM_S_WRITE_EDT.Text;      // [조회용]조회종료일
             var strSTitle       = EM_S_TITLE.Text;          // [조회용]제목
             var strSPlace       = EM_S_PLACE.Text;          // [조회용]장소
             var strSBrandNm     = EM_S_BRAND_NM.Text;       // [조회용]브랜드명
             var strSVanNm       = EM_S_VAN_NM.Text;         // [조회용]협력사명
             var strSPummokNm    = EM_S_PUMMOK_NM.Text;      // [조회용]취급품목
             
             var goTo = "getMaster";
             var parameters = ""
                 + "&strSSdate="     + encodeURIComponent(strSSdate) 
                 + "&strSEdate="     + encodeURIComponent(strSEdate) 
                 + "&strSTitle="     + encodeURIComponent(strSTitle)
                 + "&strSPlace="     + encodeURIComponent(strSPlace)
                 + "&strSBrandNm="   + encodeURIComponent(strSBrandNm)
                 + "&strSVanNm="     + encodeURIComponent(strSVanNm)
                 + "&strSPummokNm="  + encodeURIComponent(strSPummokNm);
             TR_MAIN.Action = "/mss/mcou105.mu?goTo=" + goTo + parameters;
             TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
             TR_MAIN.Post();
             
             // 조회결과 Return
             if (DS_IO_MASTER.CountRow < 1) {
                 enableControl(IMG_REQ,false);
                 enableControl(LC_STR_CD,false);
                 objControl(false);
             }
             setPorcCount("SELECT", GD_MASTER);
             DS_IO_MASTER.AddRow();
             DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "WRITE_DT")   = g_today; // 오늘일자(상담일자)
             DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_HH")    = "01"; // 시간
             DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_MM")    = "00"; // 분
             DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PATH")       = "1";  // 상담경로
             DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REQ_PATH")   = "0";  // 상담신청경로
             LC_STR_CD.Index = 0;                                                   // 점
             enableControl(LC_STR_CD,true);
         } else {
        	 return;
         }
     } else {
         DS_IO_MASTER.AddRow();
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "WRITE_DT")   = g_today; // 오늘일자(상담일자)
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_HH")    = "01"; // 시간
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TIME_MM")    = "00"; // 분
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PATH")       = "1";  // 상담경로
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REQ_PATH")   = "0";  // 상담신청경로
         LC_STR_CD.Index = 0;                                                   // 점
    	 enableControl(LC_STR_CD,true);
     }
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
        //저장시 체크
        if (!checkValidateSave()) return;
    
      //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
        
        var goTo = "save";
        var parameters = "";
        TR_MAIN.Action = "/mss/mcou105.mu?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        g_saveFlag  = false;
        TR_MAIN.Post();
        
        //재조회
        btn_Search(DS_IO_MASTER.RowPosition);
        g_saveFlag  = true;
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
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
  * saveAsFiles()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.04.01
  * 개    요 : 값체크(저장)
  * return값 :
  */
 function saveAsFiles() {
	  
	var strPath   = "upload/";    
	var strFileNm = DS_IO_MASTER.NameValue(DS_IO_MASTER.Rowposition, "OLD_FILE_NM");       
	if( strFileNm != null  ) {                          
	    iFrame.location.href="/mss/jsp/fileDownload.jsp?strPath="+strPath+"&strFileNm="+encodeURIComponent(strFileNm);
	}  
 }
 
 /**
  * checkLenByte()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 문자열 Byte체크
  * return값 :
  */
 function checkLenByte(objDateSet, row, colid) {
     //byte체크
     var intByte = 0;
     var strTemp = trim(objDateSet.NameValue(row, colid));
     for (k = 0; k < strTemp.length; k++) {
         var onechar = strTemp.charAt(k);
         if (escape(onechar).length > 4) {
             intByte += 2;
         } else {
             intByte++;
         }
     }
     return intByte;
 }
 
 /**
  * checkValidate()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 값체크
  * return값 :
  */
 function checkValidateSave() {
     for (i=1; i<=DS_IO_MASTER.CountRow; i++) {
         if (DS_IO_MASTER.RowStatus(i) == 1 || DS_IO_MASTER.RowStatus(i) == 3) {
        	 //제목
             var strTitle = checkLenByte(DS_IO_MASTER, i, "TITLE");
             if (strTitle < 1) {
                 showMessage(STOPSIGN, OK, "USER-1004", "제목");
                 DS_IO_MASTER.RowPosition = i;
                 EM_TITLE.Focus();
                 return false;
             } else if (strTitle > 50) {
                 showMessage(STOPSIGN, OK, "USER-1000", "제목은 50Byte이하로 작성해 주세요");
                 DS_IO_MASTER.RowPosition = i;
                 EM_TITLE.Focus();
                 return false;
             }
             
        	 // 브랜드
             var strBrand = checkLenByte(DS_IO_MASTER, i, "BRAND_NM");
             if (strBrand > 40) {
                 showMessage(STOPSIGN, OK, "USER-1000", "브랜드는 40Byte이하로 작성해 주세요");
                 DS_IO_MASTER.RowPosition = i;
                 EM_BRAND_NM.Focus();
                 return false;
             }
             
        	 // 협력사명
             var strVenCd = checkLenByte(DS_IO_MASTER, i, "VAN_NM");
             if (strVenCd > 40) {
                 showMessage(STOPSIGN, OK, "USER-1000", "협력사명은 40Byte이하로 작성해 주세요");
                 DS_IO_MASTER.RowPosition = i;
                 EM_VAN_NM.Focus();
                 return false;
             }
             
        	 // 취급품목
             var strPummok = checkLenByte(DS_IO_MASTER, i, "PUMMOK_NM");
             if (strPummok > 40) {
                 showMessage(STOPSIGN, OK, "USER-1000", "취급품목은 40Byte이하로 작성해 주세요");
                 DS_IO_MASTER.RowPosition = i;
                 EM_PUMMOK_NM.Focus();
                 return false;
             }
             
        	 // 협력사참석자
             var strVenAtnt = checkLenByte(DS_IO_MASTER, i, "VAN_ATNT_NM");
             if (strVenAtnt > 40) {
                 showMessage(STOPSIGN, OK, "USER-1000", "협력사참석자는 40Byte이하로 작성해 주세요");
                 DS_IO_MASTER.RowPosition = i;
                 EM_VAN_ATNT_NM.Focus();
                 return false;
             }
             
             //발송일자
             var strIpDate = (trim(DS_IO_MASTER.NameValue(i, "WRITE_DT"))).replace(' ','');
             if (strIpDate.length < 8) {
                 showMessage(STOPSIGN, OK, "USER-1004", "상담일자");
                 DS_IO_MASTER.RowPosition = i;
                 setTimeout("EM_WRITE_DT.Focus()",100);
                 return false;
             } 
             
             //발송일자는 오늘 이후만 입력가능하다.
             if (strIpDate > g_today ) {
                 EM_WRITE_DT.Text = g_today;
                 showMessage(STOPSIGN, OK, "USER-100", "상담일자는 오늘 이 후 일자는 입력 할 수 없습니다.");
                 DS_IO_MASTER.RowPosition = i;
                 setTimeout("EM_WRITE_DT.Focus()",100);
                 return;
             }
             
             //상담신청경로가 ONLINE인 경우 상담신청내역 필수
             var strReqPath = DS_IO_MASTER.NameValue(i, "REQ_PATH"); //상담신청경로
             var strReqDt = DS_IO_MASTER.NameValue(i, "REQ_DT");     //상담신청일자
             if (strReqPath ==  "4") {
                 if (strReqDt.length < 1 ) {
                     EM_WRITE_DT.Text = g_today;
                     showMessage(STOPSIGN, OK, "USER-1003", "[상담신청경로가 ONLINE인 경우] 상담신청(일자/SEQ)");
                     DS_IO_MASTER.RowPosition = i;
                     setTimeout("LC_REQ_PATH.Focus()",100);
                     return;
                 }
             }
             
             //바이어 코드
             var strBuyerCd = (trim(DS_IO_MASTER.NameValue(i, "BUYER_CD"))).replace(' ','');
             if (strBuyerCd.length < 1) {
                 showMessage(STOPSIGN, OK, "USER-1004", "바이어");
                 DS_IO_MASTER.RowPosition = i;
                 setTimeout("LC_BUYER.Focus()",100);
                 return false;
             } 
             
             //발송내용
             var strSCont = checkLenByte(DS_IO_MASTER, i, "CONTENT");
             if (strSCont < 1) {
                 showMessage(STOPSIGN, OK, "USER-1003", "내용");
                 DS_IO_MASTER.RowPosition = i;
                 setTimeout("TXT_CONTENT.Focus()",100);
                 return false;
             } else if (strSCont > 4000) {
                 showMessage(STOPSIGN, OK, "USER-1000", "내용은 4000Byte이하로 작성해 주세요");
                 DS_IO_MASTER.RowPosition = i;
                 setTimeout("TXT_CONTENT.Focus()",100);
                 return false;
             }
             
         }
     }
     return true;
 }
 
 
 /**
  * checkValidate()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 값체크
  * return값 :
  */
 function checkValidate() {
     
     //시작, 종료일 일자체크
     var em_sdate = (trim(EM_S_WRITE_SDT.Text)).replace(' ','');
     var em_edate = (trim(EM_S_WRITE_EDT.Text)).replace(' ','');
     if (em_sdate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1003", "시작일");
         EM_S_WRITE_SDT.Focus();
         return false;
     } else if (em_edate.length < 8) {
         showMessage(STOPSIGN, OK, "USER-1003", "종료일");
         EM_S_WRITE_EDT.Focus();
         return false;
     }

     if (em_sdate > em_edate) { //시작일은 종료일보다 커야 합니다.
         showMessage(STOPSIGN, OK, "USER-1015");
         EM_S_WRITE_SDT.Focus();
         return false;
     }

     return true;
 }

 /**
  * callPopup()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 팝업 호출
  * return값 :
  */
 function callPopup(popupNm) {
	  if (popupNm == "req") {
	     var arrArg  = new Array();
	     var returnArg  = new Array();
	     arrArg.push(EM_S_WRITE_SDT.Text);
	     arrArg.push(EM_S_WRITE_EDT.Text);
	     arrArg.push(LC_STR_CD.BindColVal);
	     arrArg.push(LC_BUYER.BindColVal);
	     arrArg.push(LC_BUYER.Text);
	     arrArg.push(g_session_org_cd);
	     arrArg.push(returnArg);
	     
	     var returnVal = window.showModalDialog("/mss/mcou105.mu?goTo=listSelect",
	                                            arrArg,
	                                            "dialogWidth:900px;dialogHeight:620px;scroll:no;" +
	                                            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	     if (returnVal) {
	    	 EM_REQ_DT.Text = arrArg[6][0].REQ_DT;
	    	 EM_REQ_SEQ.Text = arrArg[6][0].REQ_SEQ;
	     }
	     
	  } else if (popupNm == "buyer") {//바이어
          if (LC_SEL_STR_CD.BindColVal == ""|| LC_SEL_STR_CD.BindColVal == "%") {//점 미선택시
              showMessage(STOPSIGN, OK, "USER-1003", "점");
              LC_SEL_STR_CD.Focus();
              return;
          }  
      
          var strOrgCd = LC_SEL_STR_CD.BindColVal;
          if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
              strOrgCd +=  "00000000";
          } else {
              strOrgCd += LC_SEL_DEPT_CD.BindColVal;
              if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
                  strOrgCd +=  "000000";
              } else {
                  strOrgCd += LC_SEL_TEAM_CD.BindColVal;
                  if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
                      strOrgCd +=  "0000";
                  } else {
                      strOrgCd += LC_SEL_TEAM_CD.BindColVal + "00";
                  }
              }
          }
          
          buyerPop( EM_BUYER_CD, EM_BUYER_NM , 'N', '', '1', strOrgCd, '', '');
      }
 }
 
 /**
  * objControl()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 버튼컨트롤
  * return값 :
  */
 function objControl(objBoolean) {
    if (objBoolean) {
        //버튼
        //enableControl(IMG_REQ,true );
        //enableControl(IMG_BUYER_CD,true);
        //enableControl(IMG_WRITE_DT,true);
        enableControl(IMG_FILE_SELECT,true);
        //오브젝트
        enableControl(EM_TITLE,true);
        enableControl(EM_WRITE_DT,true);
        enableControl(EM_PLACE,true);
        enableControl(EM_BRAND_NM,true);
        enableControl(EM_VAN_NM,true);
        enableControl(EM_PUMMOK_NM,true);
        enableControl(EM_VAN_ATNT_NM,true);
        enableControl(LC_BUYER,true);
        enableControl(TXT_CONTENT,true);
        TXT_CONTENT.Enable = true;
        enableControl(LC_PATH,true);
        enableControl(LC_REQ_PATH,true);
        enableControl(LC_TIME_HH,true);
        enableControl(LC_TIME_MM,true);
    } else {
        //버튼
        //enableControl(IMG_REQ,false );
        //enableControl(IMG_BUYER_CD,false);
        //enableControl(IMG_WRITE_DT,false);
        enableControl(IMG_FILE_SELECT,false);
        //오브젝트
        enableControl(EM_TITLE,false);
        enableControl(EM_WRITE_DT,false);
        enableControl(EM_PLACE,false);
        enableControl(EM_BRAND_NM,false);
        enableControl(EM_VAN_NM,false);
        enableControl(EM_PUMMOK_NM,false);
        enableControl(EM_VAN_ATNT_NM,false);
        enableControl(LC_BUYER,false);
        TXT_CONTENT.Enable = false;
        enableControl(LC_PATH,false);
        enableControl(LC_REQ_PATH,false);
        enableControl(LC_TIME_HH,false);
        enableControl(LC_TIME_MM,false);
    }
 }

 /**
  * deleteFile()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 파일열기
  * return값 :
  */
 function deleteFile() {
      var strFlag = "";
      if (DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"FILE_NM") != "") {
          strFlag = "D";
      } else {
          strFlag = "N";
      }
      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;    // 파일Flag
      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = "";   // 경로명 표기
      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_NM") = ""; // 경로명 표기
 }
 
 /**
  * openFile()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 파일열기
  * return값 :
  */
 function openFile() {
	INF_FILEUPLOAD.Open();
	if (INF_FILEUPLOAD.SelectState) {
	    var strFileInfo = INF_FILEUPLOAD.Value; //파일이름
	    var tmpFileName = strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1);
	    var strFileName = tmpFileName.substring(0, tmpFileName.lastIndexOf("."));
        var chrByre = checkLenByteStr(strFileName);
        var chrLen  = strFileName.length;
        /* [2011.07.26] 한글파일명 제한 해제
        if (chrByre != chrLen) {    // 파일명 한글
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 영문,숫자만으로 작성해주세요");
            return;
        } else */if (chrByre > 21) {  // 파일명 22Byte이내작성
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 21Byte(영문,숫자21자)이내로 작성해주세요");
            return;
        } else {
            if((1024 * 1024 * 5) < INF_FILEUPLOAD.FileInfo("size")){
                showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 5M 를 넘을 수 없습니다.");
                var strFlag = "";
                if (DS_IO_MASTER.OrgNameString(DS_IO_MASTER.RowPosition,"FILE_NM") != "") {
                    strFlag = "D";
                } else {
                    strFlag = "N";
                }
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = strFlag;    // 파일Flag
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = ""; // 경로명 표기
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_NM") = ""; // 경로명 표기
            } else {
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_GB") = "Y";   // 파일Flag
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_PATH") = strFileInfo;
                DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "FILE_NM") = strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1)
            }
        }
	} 
 }

 /**
  * checkLenByteStr()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
  * 개    요 : 문자열 Byte체크
  * return값 :
  */
 function checkLenByteStr(str) {
     //byte체크
     var intByte = 0;
     for (k = 0; k < str.length; k++) {
         var onechar = str.charAt(k);
         if (escape(onechar).length > 4) {
             intByte += 2;
         } else {
             intByte++;
         }
     }
     return intByte;
 }
 
 /**
  * getBuyer()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-12-12
  * 개    요 : 바이어조회
  * return값 : void
  */
 function getBuyer() {
     //parameters
     var strSStrCd       = LC_SEL_STR_CD.BindColVal; // [조회용]점코드
     
     var goTo = "getBuyer";
     var parameters = ""
         + "&strSStrCd="     + encodeURIComponent(strSStrCd);
     TR_MAIN.Action = "/mss/mcou105.mu?goTo=" + goTo + parameters;
     TR_MAIN.KeyValue = "SERVLET(O:DS_LC_BUYER=DS_LC_BUYER)";
     TR_MAIN.Post();
 }

 -->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(Row)>
//마스터 row변경 전
if (g_saveFlag) {
	if (DS_IO_MASTER.IsUpdated) {//마스터 컬럼변경전 변경데이터 있을 시 이동할것인지 확인
	    var ret = showMessage(Question, YesNo, "USER-1049");
	    if (ret == "1") {
	    	if (DS_IO_MASTER.RowStatus(Row) == 1) {
	    		DS_IO_MASTER.DeleteRow(Row);
	    	} else {
		    	rollBackRowData(DS_IO_MASTER, Row);
	    	}
	        return true;
	    } else {
	        return false;
	    }
	} 
	return true;
}
return true;
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_IO_MASTER.CountRow > 0) {
	if (DS_IO_MASTER.NameValue(row, "AUTHCHK") == "N") { 
	    enableControl(IMG_REQ,false);
	    enableControl(IMG_WRITE_DT,false);
	    enableControl(IMG_FILE_LINK,false);
	    enableControl(IMG_FILE_DEL,false);
	    enableControl(LC_STR_CD,false);
	    objControl(false);
		
	} else {
		objControl(true);
	    
	    if (DS_IO_MASTER.NameValue(row, "REQ_PATH") == "1") {// 상담신청경로(온라인)
	        enableControl(IMG_REQ,true);
	    } else {
	        enableControl(IMG_REQ,false);
	    }
	    
	    if (DS_IO_MASTER.RowStatus(row) == "1") {
	    	enableControl(LC_STR_CD,true);
	    	enableControl(LC_BUYER,true);
	        enableControl(EM_WRITE_DT,true);
	        enableControl(IMG_WRITE_DT,true);
	        
	        
	    } else if (DS_IO_MASTER.RowStatus(row) == "0") {
	    	enableControl(LC_STR_CD,false);
	    	enableControl(LC_BUYER,false);
	        enableControl(EM_WRITE_DT,false);
	        enableControl(IMG_WRITE_DT,false);

	        // 파일다운로드 컨트롤
	        if (DS_IO_MASTER.NameValue(row, "OLD_FILE_NM").length > 0 ) {
	            //document.all.IFPAGE.src = DS_IO_MASTER.NameValue(DS_IO_MASTER.Rowposition, "FILE_PATH") 
	            //   + "" + DS_IO_MASTER.NameValue(DS_IO_MASTER.Rowposition, "OLD_FILE_NM") ;
	            enableControl(IMG_FILE_LINK,true);
	            enableControl(IMG_FILE_DEL,true);
	        } else {
	            //document.all.IFPAGE.src = "about:blank";
	            enableControl(IMG_FILE_LINK,false);
	            enableControl(IMG_FILE_DEL,false);
	        }
	        
	    } else {
	        enableControl(EM_WRITE_DT,false);
	    }
	}
	
} 
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnDblClick(row,colid)>
//그리드 더블클릭시 팝업호출
    if( row < 1) return;
    
    if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REQ_PATH") == "1" &&
    	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REQ_DT") != "" &&
    	DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REQ_SEQ") != ""
    		) {
		var arrArg  = new Array();
		arrArg.push(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REQ_DT"));
		arrArg.push(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REQ_SEQ"));
		
		var returnVal = window.showModalDialog("/mss/mcou105.mu?goTo=listDtl",
		                                       arrArg,
		                                       "dialogWidth:900px;dialogHeight:250px;scroll:no;" +
		                                       "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    }
</script>


<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
//그리드 정렬기능
    if( row < 1) sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=EM_S_WRITE_SDT event=onKillFocus()>
//[조회용]상담일자 FROM
checkDateTypeYMD( EM_S_WRITE_SDT );
</script>
<script language=JavaScript for=EM_S_WRITE_EDT event=onKillFocus()>
//[조회용]상담일자 TO
checkDateTypeYMD( EM_S_WRITE_EDT );
</script>

<script language=JavaScript for=EM_WRITE_DT event=onKillFocus()>
//상담일자
checkDateTypeYMD( EM_WRITE_DT );
</script>

<script language=JavaScript for=LC_REQ_PATH event=OnSelChange()>
//상담신청경로 따라 
//if (DS_IO_MASTER.CountRow > 0) {
    if (LC_REQ_PATH.BindColVal == "1") { // 상담신청경로(온라인)
    	enableControl(IMG_REQ,true);
    } else {
        enableControl(IMG_REQ,false);
    	EM_REQ_DT.Text = "";
    	EM_REQ_SEQ.Text = "";
    }
//}
</script> 

<script language=JavaScript for=EM_BUYER_CD event=OnKillFocus()>
//[조회용]바이어코드  자동완성 및 팝업호출
//if (EM_BUYER_CD.Text.length > 0 ) {
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_BUYER_NM.Text = "";
        return;
    } 
    
    if (LC_SEL_STR_CD.BindColVal == ""|| LC_SEL_STR_CD.BindColVal == "%") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_SEL_STR_CD.Focus();
        return;
    }  

    var strOrgCd = LC_SEL_STR_CD.BindColVal;
    if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
        strOrgCd +=  "00000000";
    } else {
        strOrgCd += LC_SEL_DEPT_CD.BindColVal;
        if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
            strOrgCd +=  "000000";
        } else {
            strOrgCd += LC_SEL_TEAM_CD.BindColVal;
            if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
                strOrgCd +=  "0000";
            } else {
                strOrgCd += LC_SEL_TEAM_CD.BindColVal + "00";
            }
        }
    }
    
    //단일건 체크 
    setBuyerNmWithoutPop("DS_O_RESULT", EM_BUYER_CD, EM_BUYER_NM , 'N', 1, '', '', strOrgCd);
//}
</script>


<script language=JavaScript for=LC_SEL_STR_CD event=OnSelChange()>
//[점]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getDept("DS_LC_DEPT_CD", "N", LC_SEL_STR_CD.BindColVal, "Y");
    if (LC_SEL_STR_CD.BindColVal == "" || LC_SEL_STR_CD.BindColVal == "%") {
        // 팀비활성화   
        enableControl(LC_SEL_DEPT_CD, false);
        LC_SEL_DEPT_CD.Index = 0;
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // 팀활성화   
        enableControl(LC_SEL_DEPT_CD, true);
        LC_SEL_DEPT_CD.Index = 0;
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    }
    EM_BUYER_CD.Text = "";
    EM_BUYER_NM.Text = "";
    
    getBuyer(); //바이어 콤보조회
</script>
<script language=JavaScript for= LC_SEL_DEPT_CD event=OnSelChange()>
//[팀]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getTeam("DS_LC_TEAM_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, "Y");
    if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // 파트활성화   
        enableControl(LC_SEL_TEAM_CD, true);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    }
</script>
<script language=JavaScript for= LC_SEL_TEAM_CD event=OnSelChange()>
//[파트]콤보 변경
    //시스템 코드 공통코드에서 가지고 오기
    getPc("DS_LC_PC_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, LC_SEL_TEAM_CD.BindColVal, "Y");
    if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // PC활성화   
        enableControl(LC_SEL_PC_CD, true);
        LC_SEL_PC_CD.Index = 0;
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_STR_CD"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_STR_CD"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_DEPT_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_TEAM_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PC_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_LC_BUYER"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PATH"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_REQ_PATH"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_TIME_HH"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_TIME_MM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--------------------- 3. Fileupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_FILEUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
    <param name="FileFilterString"  value=16>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝  
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0>
</iframe>
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
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
                    <tr>
                        <th width="80" class="point">점</th>
                        <td ><comment id="_NSID_"> <object
                            id=LC_SEL_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="80">팀</th>
                        <td ><comment id="_NSID_"> <object
                            id=LC_SEL_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="80">파트</th>
                        <td ><comment id="_NSID_"> <object
                            id=LC_SEL_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th width="80">PC</th>
                        <td><comment id="_NSID_"> <object id=LC_SEL_PC_CD
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
					<tr>
                        <th width="80" class="point">협력사</th>
						<td width="135"><comment id="_NSID_"> <object id=EM_S_VAN_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">취급품목</th>
                        <td width="135"><comment id="_NSID_"> <object
                            id=EM_S_PUMMOK_NM classid=<%=Util.CLSID_EMEDIT%> width=130
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
						<th width="80">상담일자</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_WRITE_SDT classid=<%=Util.CLSID_EMEDIT%> width=90
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_WRITE_SDT)" /> ~ <comment
							id="_NSID_"> <object id=EM_S_WRITE_EDT
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_WRITE_EDT)" /></td>
					</tr>
					<tr>
						<th>장소</th>
						<td><comment id="_NSID_"> <object id=EM_S_PLACE
							classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>

						<th>브랜드명</th>
						<td><comment id="_NSID_"> <object id=EM_S_BRAND_NM
							classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>바이어</th>
						<td colspan="3"><comment id="_NSID_"> <object
                            id=EM_BUYER_CD classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="javascript:callPopup('buyer')" align="absmiddle" /> <comment
                            id="_NSID_"> <object id=EM_BUYER_NM
                            classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></script></td>
					</tr>
					<tr>
                        <th>제목</th>
                        <td colspan="7"><comment id="_NSID_"> <object id=EM_S_TITLE
                            classid=<%=Util.CLSID_EMEDIT%> width=366 tabindex=1
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
                        <th width="70" class="point">점</th>
                        <td width="100"><comment id="_NSID_"> <object
                            id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=80
                            width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        <th width="70" >장소</th>
                        <td width="113"><comment id="_NSID_"> <object id=EM_PLACE
                            classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="70" class="point">상담일자</th>
						<td width="105"><comment id="_NSID_"> <object
							id=EM_WRITE_DT classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" id=IMG_WRITE_DT
							onclick="javascript:openCal('G',EM_WRITE_DT)" /></td>
						<th width="70" class="point">시간</th>
						<td><comment id="_NSID_"> <object id=LC_TIME_HH
							classid=<%=Util.CLSID_LUXECOMBO%> width=50 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> : <comment
							id="_NSID_"> <object id=LC_TIME_MM
							classid=<%=Util.CLSID_LUXECOMBO%> width=50 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
                        <th class="point">제목</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_TITLE classid=<%=Util.CLSID_EMEDIT%> width=301 tabindex=1
                            align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>브랜드명</th>
						<td><comment id="_NSID_"> <object id=EM_BRAND_NM
							classid=<%=Util.CLSID_EMEDIT%> width=101 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>협력사명</th>
						<td><comment id="_NSID_"> <object id=EM_VAN_NM
							classid=<%=Util.CLSID_EMEDIT%> width=133 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>취급품목</th>
						<td colspan="3"><comment id="_NSID_"> <object id=EM_PUMMOK_NM
							classid=<%=Util.CLSID_EMEDIT%> width=301 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>상담경로</th>
						<td><comment id="_NSID_"> <object id=LC_PATH
							classid=<%=Util.CLSID_LUXECOMBO%> width=103 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>협력사 참석자</th>
						<td><comment id="_NSID_"> <object id=EM_VAN_ATNT_NM
							classid=<%=Util.CLSID_EMEDIT%> width=133 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th class="point">상담 바이어</th>
						<td colspan="3"><comment id="_NSID_"> <object id=LC_BUYER
							classid=<%=Util.CLSID_LUXECOMBO%> width=171 tabindex=align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>상담신청경로</th>
						<td><comment id="_NSID_"> <object id=LC_REQ_PATH
							classid=<%=Util.CLSID_LUXECOMBO%> height=80 width=103
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>상담신청조회</th>
						<td><comment id="_NSID_"> <object id=EM_REQ_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <comment
							id="_NSID_"><object id=EM_REQ_SEQ
							classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_REQ" class="PR03"
							onclick="javascript:callPopup('req');" align="absmiddle" /></td>
					</tr>
					<tr>
						<th class="point">상담내역</th>
						<td colspan="7"><comment id="_NSID_"> <object
							id=TXT_CONTENT classid=<%=Util.CLSID_TEXTAREA%> height=100
                            onkeyup="javascript:textAreaMaxlength(TXT_CONTENT, 4000);"
                            onkeyDown="javascript:textAreaMaxlength(TXT_CONTENT, 4000);"
                            onkeyPress ="javascript:textAreaMaxlength(TXT_CONTENT, 4001);"
							width=726 tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="7"><comment id="_NSID_"> <object
							id=EM_FILE_NM classid=<%=Util.CLSID_EMEDIT%> width=530 tabindex=1>
						</object> </comment><script>_ws_(_NSID_);</script> <img id="IMG_FILE_SELECT"
							src="/<%=dir%>/imgs/btn/file_search.gif" class="PR03"
							onclick="javascript:openFile();" align="absmiddle" /> <img
							id="IMG_FILE_LINK" style="vertical-align: middle;"
							onclick="javascript:saveAsFiles();"
							src="/<%=dir%>/imgs/btn/file_down.gif" /> <img id="IMG_FILE_DEL"
							style="vertical-align: middle;"
							onclick="javascript:deleteFile();"
							src="/<%=dir%>/imgs/btn/file_del.gif" /></td>
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td width="100%"><comment id="_NSID_"><OBJECT
							id=GD_MASTER width=100% height=194 tabindex=1 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=STR_CD       Ctrl=LC_STR_CD          param=BindColVal</c>
        <c>Col=TITLE        Ctrl=EM_TITLE           param=Text</c>
        <c>Col=WRITE_DT     Ctrl=EM_WRITE_DT        param=Text</c>
        <c>Col=TIME_HH      Ctrl=LC_TIME_HH         param=BindColVal</c>
        <c>Col=TIME_MM      Ctrl=LC_TIME_MM         param=BindColVal</c>
        <c>Col=PLACE        Ctrl=EM_PLACE           param=Text</c>
        <c>Col=BRAND_NM     Ctrl=EM_BRAND_NM        param=Text</c>
        <c>Col=VAN_NM       Ctrl=EM_VAN_NM          param=Text</c>
        <c>Col=PUMMOK_NM    Ctrl=EM_PUMMOK_NM       param=Text</c>
        <c>Col=PATH         Ctrl=LC_PATH            param=BindColVal</c>
        <c>Col=VAN_ATNT_NM  Ctrl=EM_VAN_ATNT_NM     param=Text</c>
        <c>Col=BUYER_CD     Ctrl=LC_BUYER           param=BindColVal</c>
        <c>Col=REQ_PATH     Ctrl=LC_REQ_PATH        param=BindColVal</c>
        <c>Col=FILE_NM      Ctrl=EM_FILE_NM         param=Text</c>
        <c>Col=CONTENT      Ctrl=TXT_CONTENT        param=Text</c>
        <c>Col=REQ_DT       Ctrl=EM_REQ_DT          param=Text</c>
        <c>Col=REQ_SEQ      Ctrl=EM_REQ_SEQ         param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

