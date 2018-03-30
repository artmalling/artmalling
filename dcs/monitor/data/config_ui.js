/** config.ui.js : Created on 2008. 7. 29.
 * 
 *   Copyright (c) 2000-2008 Shift Information & Communication Co.
 *   5F, Seongsu Venture town, 231-1, Seongsu2-Ga Seongdong-Gu, Seoul, Korea 133-826
 *   All rights reserved.
 *
 *   This software is the confidential and proprietary information of
 *   Shift Information & Communication Co. ("Confidential Information").
 *   You shall not disclose such Confidential Information and shall use 
 *   it only in accordance with the terms of the license agreement you 
 *   entered into with Shift Information & Communication.
 */

	var nCompressed	= "false";
	var nFragment = "100";
	var nDefault = "EUC-KR";
	var nGet = "EUC-KR";
	var nPost = "EUC-KR";
	var nInteger = "6";
	var nDecimal = "7.3";
	var nString = "255";
	var nRound = "F";
	var nSpi = "";
	var nParamName = "";
	var nParamValue = "";
	var nLog = "true";
	var nLogPath = "절대 경로를 입력해 주세요.";
	var nRegClass;
	var nRegClass_true = "false";
	
	var nDBName = "default";
	var nDBCharIn = "euc-kr";
	var nDBCharOut = "euc-kr";
	var nJdbcDriver	= "oracle.jdbc.driver.OracleDriver";
	var nJdbcUrl = "jdbc:oracle:thin:@localhost:1521:ORA9";
	var nJdbcUser = "scott";
	var nJdbcPass = "tiger";
	var nJdbcSchema = "SCOOT";
	
	var nDbCount = 0;
	var nParamCount = 0;

	
	// 선택된 도메인의 default 여부
	var isDefault = false;
	
var CHARTSET = "<option value='EUC-KR'>					EUC-KR       </option>"
						+ "<option value='UTF-8'>          UTF-8         </option>"
						+ "<option value='UTF-16'>         UTF-16        </option>"
//						+ "<option value='UTF-16BE'>       UTF-16BE      </option>"
//						+ "<option value='UTF-16LE'>       UTF-16LE      </option>"
//						+ "<option value='ISO-2022-JP'>    ISO-2022-JP   </option>"
//						+ "<option value='ISO-2022-KR'>    ISO-2022-KR   </option>"
						+ "<option value='ISO-8859-1'>     ISO-8859-1    </option>"
//						+ "<option value='ISO-8859-13'>    ISO-8859-13   </option>"
//						+ "<option value='ISO-8859-15'>    ISO-8859-15   </option>"
//						+ "<option value='ISO-8859-2'>     ISO-8859-2    </option>"
//						+ "<option value='ISO-8859-3'>     ISO-8859-3    </option>"
//						+ "<option value='ISO-8859-4'>     ISO-8859-4    </option>"
//						+ "<option value='ISO-8859-5'>     ISO-8859-5    </option>"
//						+ "<option value='ISO-8859-6'>     ISO-8859-6    </option>"
//						+ "<option value='ISO-8859-7'>     ISO-8859-7    </option>"
//						+ "<option value='ISO-8859-8'>     ISO-8859-8    </option>"
//						+ "<option value='ISO-8859-9'>     ISO-8859-9    </option>"
//						+ "<option value='Big5-HKSCS'>     Big5-HKSCS    </option>"
//						+ "<option value='EUC-JP'>         EUC-JP        </option>"
//						+ "<option value='GB18030'>        GB18030       </option>"
//						+ "<option value='GBK'>            GBK           </option>"
//						+ "<option value='JIS_X0201'>      JIS_X0201     </option>"
//						+ "<option value='JIS_X0212-1990'> JIS_X0212-1990</option>"
//						+ "<option value='KOI8-R'>         KOI8-R        </option>"
//						+ "<option value='Shift_JIS'>      Shift_JIS     </option>"
//						+ "<option value='TIS-620'>        TIS-620       </option>"
//						+ "<option value='US-ASCII'>       US-ASCII      </option>"
//						+ "<option value='windows-1250'>   windows-1250  </option>"
//						+ "<option value='windows-1251'>   windows-1251  </option>"
//						+ "<option value='windows-1252'>   windows-1252  </option>"
//						+ "<option value='windows-1253'>   windows-1253  </option>"
//						+ "<option value='windows-1254'>   windows-1254  </option>"
//						+ "<option value='windows-1255'>   windows-1255  </option>"
//						+ "<option value='windows-1256'>   windows-1256  </option>"
//						+ "<option value='windows-1257'>   windows-1257  </option>"
//						+ "<option value='windows-1258'>   windows-1258  </option>"
//						+ "<option value='windows-31j'>    windows-31j   </option>"
//						+ "<option value='x-EUC-CN'>       x-EUC-CN      </option>"
//						+ "<option value='x-euc-jp-linux'> x-euc-jp-linux</option>"
//						+ "<option value='x-EUC-TW'>       x-EUC-TW      </option>"
//						+ "<option value='x-eucJP-Open'>   x-eucJP-Open  </option>"
//						+ "<option value='x-ISCII91'>      x-ISCII91     </option>"
//						+ "<option value='x-JIS0208'>      x-JIS0208     </option>"
//						+ "<option value='x-Johab'>        x-Johab       </option>"
//						+ "<option value='x-MS950-HKSCS'>  x-MS950-HKSCS </option>"
//						+ "<option value='x-mswin-936'>    x-mswin-936   </option>"
//						+ "<option value='x-windows-949'>  x-windows-949 </option>"
//						+ "<option value='x-windows-950'>  x-windows-950 </option>";
						
	function galobal_table() {
		
		var tGalobal = "<table>"
			+ "	<tr bgcolor='#ebebeb'>"
			+ "		<td align='right'><b>Compressed(압축 여부) :</b></td>"
			+ "		<td> "
			+ "			<input type='radio' name='compressed' value='true'>true</input> &nbsp;"
			+ "			<input type='radio' name='compressed' value='false'>false</input> &nbsp;</td>"
			+ "		<td colspan='3'>Fragment(First Row Size) :"
			+ "		<input name='fragment' type='text' value='" + nFragment + "' size='5' style='vertical-align:middle;'></td>"
			+ "	</tr>"
			+ "	<tr>"
			+ "		<td align='right'><b>Character Set(인코딩) :</b></td>"
//			+ "		<td>default <input type='text' name='enc_default' value='" + nDefault + "' size='10' style='vertical-align:middle;'></td>"
//			+ "		<td>GET <input type='text' name='enc_get' value='" + nGet + "' size='10' style='vertical-align:middle;'></td>"
//			+ "		<td>POST <input type='text' name='enc_post' value='" + nPost + "' size='10' style='vertical-align:middle;'></td>"
			+ "		<td colspan='4'>default <select name='enc_default'>"
			+				CHARTSET
			+ "		</select>"
			+ "		&nbsp;&nbsp; get <select name='enc_get'>"
			+				CHARTSET
			+ "		</select> "
			+ "		&nbsp;&nbsp; post <select name='enc_post'>"
			+				CHARTSET
			+ "		</select>"
			+ "	</tr>"
			+ "	<tr bgcolor='#ebebeb'>"
			+ "		<td width='170' align='right'><b>데이터셋 컬럼 설정값 :</b></td>"
			+ "		<td width='130'>integer <input type='text' name='column_integer' value='" + nInteger + "' size='5' style='vertical-align:middle;'></td>"
			+ "		<td width='130'>decimal <input type='text' name='column_decimal' value='" + nDecimal + "' size='5' style='vertical-align:middle;'></td>"
			+ "		<td width='130'>string <input type='text' name='column_string' value='" + nString + "' size='5' style='vertical-align:middle;'></td>"
			+ "		<td width='130'>round <select name='column_round'>"
			+ "								<option value='R' >ROUND</option>"
			+ "								<option value='F' >FLOOR</option>"
			+ "								<option value='C' >CEIL</option>"
			+ "							</select></td>"
			+ "	</tr>"
			+ "	<tr>"
			+ "		<td align='right'><b>Crypto(암호화) :</b></td>"
			+ "		<td colspan='2'>어뎁터 클래스"
			+ "				<select name='crypto_spi' onchange='javascript:crypto_Change();'>"
			+ "					<option value=''>----선택----</option>"
			+ "					<option value='com.ixync.common.crypto.impl.InisafeNetAdapter'>InisafeNet</option>"
			+ "					<option value='com.ixync.common.crypto.impl.IssacWebAdapter'>IssacWeb</option>"
			+ "					<option value='com.ixync.common.crypto.impl.KICASecuKitAdapter'>KICAsecuKit</option>"
			+ "					<option value='com.ixync.common.crypto.impl.SecuiAdapter'>Secui</option>"
			+ "					<option value='com.ixync.common.crypto.impl.SigngateAdapter'>Signgate</option>"
			+ "					<option value='com.ixync.common.crypto.impl.XecureAdapter'>Xecure</option>"
			+ "					<option value='com.ixync.common.crypto.impl.KSignCASEAdapter'>KSignCASE</option>"
			+ "				<select>"
			+ "		</td>"
			+ "		<td colspan='2'> <div id='crypto_adapter'></div> </td>"
			+ "	</tr>"
			+ "	<tr bgcolor='#ebebeb'>"
			+ "		<td></td> <td colspan='4'><div id='crypto_param'></div></td>"
			+ "	</tr>	"
			+ "</table>";
			
	
		dlobal_commend.innerHTML = tGalobal;
		if(nRound == "R") {
			document.getElementById('column_round').selectedIndex = 0;
		} else if(nRound == "F") {
			document.getElementById('column_round').selectedIndex = 1;
		} else if(nRound == "C") {
			document.getElementById('column_round').selectedIndex = 2;
		}
		
		for(var i = 0; i <document.getElementById('enc_default').length; i++) {
			var value = document.getElementById('enc_default')[i].value;
			if(codeUpperCase(value) == codeUpperCase(nDefault)) {
				document.getElementById('enc_default').selectedIndex = i;
			}
			value = document.getElementById('enc_get')[i].value;
			if(codeUpperCase(value) == codeUpperCase(nGet)) {
				document.getElementById('enc_get').selectedIndex = i;
			}
			value = document.getElementById('enc_post')[i].value;
			if(codeUpperCase(value) == codeUpperCase(nPost)) {
				document.getElementById('enc_post').selectedIndex = i;
			}
		}
			
		if(nCompressed == "true") {
			document.getElementsByName('compressed')[0].checked = true;
		} else  {
			document.getElementsByName('compressed')[1].checked = true;
		}
		
		for(var i = 0; i < document.getElementById('crypto_spi').length; i++) {
			var value = document.getElementById('crypto_spi')[i].value;
			
			if(value == nSpi) {
				document.getElementById('crypto_spi').selectedIndex = i;
				return;
			} else  {
				document.getElementById('crypto_spi').selectedIndex = 0;
			}
		}
		
		crypto_Change();
	}
	
	function default_table() {
		var tDefault = "	<table>"
								+ "			<td align='right'width='170'></td>"
								+ "			<td colspan='4'>&nbsp;&nbsp;*&nbsp;다음은 innoxync-default.xml 을 위한 환경 설정 사항입니다. <br></td>"
								+ "			<tr bgcolor='#ebebeb'>"
								+ "				<td align='right'width='170'><b>Monitoring Log :</b></td>"
								+ "				<td width='130'>"
								+ "					<input type='radio' name='monitor_log' value='false'>미사용</input> &nbsp;"
								+ "					<input type='radio' name='monitor_log' value='true'>사용</input> &nbsp;"
								+ "				</td>"
								+ "				<td colspan='3' width='390'> 로그 위치 : "
								+ "					<input type='text' name='monitor_dir' size='45' value='" + nLogPath + "'> </input>"
								+ "				</td>"
								+ "			</tr>"
								+ "			<tr>"
								+ "				<td align='right'><b>Connector() :</b></td>"
								+ "				<td colspan='4'>"
								//+ "					<input type='radio' name='connector_req' value='com.ixync.filter.HttpIXyncRequestWrapper'>미사용</input> &nbsp;"
								//+ "					<input type='radio' name='connector_req' value='com.ixync.filter.HttpStrutRequestWrapper'>사용 (HttpStrutsRequestWrapper)</input> &nbsp;"
								+ "					<input type='radio' name='connector_req' value='false'>미사용</input> &nbsp;"
								+ "					<input type='radio' name='connector_req' value='true'>사용 (HttpStrutsRequestWrapper)</input> &nbsp;"
								+ "				</td>"          
								+ "			</tr>"          
								+ "		</table>"
								+ "		<table width='100%'>"
								+ "			<tr>"
								+ "				<td></td>"
								+ "			</tr>"
								+ "			<tr>"
								+ "				<td align='center'><b>Resource</b></td>"
								+ "			</tr>"
								+ "		</table>"
								+ "		<table  width='100%'>"	
								+ "			<tr>"
								+ "				<td width='170' align='right'><b>DataSource Name :</b></td>"
								+ "				<td align='left'>"
								+ "					<input type='text' name='dataSource_name' value='default' size='15'></input>"
								+ "					<input type='button' value='추가' onclick=dataSource_table('');></input>"
								+ "				</td>"
								+ "			</tr>"
								+ "		</table>"
								+ "		<table>"
								+ "			<tr>"
								+ "				<td>"
								+ "					<input type='hidden' name='dataSource_names' value=''></input>"
								+ "					<div id='dataSource_value' value=''></div>"
								+ "				</td>"
								+ "			<tr>"
								+ "		</table>";
								
		default_commend.innerHTML = tDefault;
		
		if(nLog == "true") {
			document.getElementsByName('monitor_log')[1].checked = true;
		} else  {
			document.getElementsByName('monitor_log')[0].checked = true;
		}
		
		if(nRegClass_true == "true") {
			document.getElementsByName('connector_req')[1].checked = true;
		} else  {
			document.getElementsByName('connector_req')[0].checked = true;
		}
		
	}

	//DB Resource 추가
	var dataSource_names = "";
	function dataSource_table(temp) {
		var name = "";
		if(temp != "") {
			name = temp;
		} else {
			name = document.getElementById('dataSource_name').value;
		}
		
		dataSource_names += (name + ":");
		window.document.config.dataSource_names.value = dataSource_names;
		
		//추가된 data를 답고 있을 변수 resource_value
		var resource_value = "<table>"
									 + "	<tr bgcolor='#ebebeb'>"
									 + "		<td colspan='4'><center><b>- Data Source Name : " 
									 //+ "<input type='text' name='jdbc_name_" + name + "' value='" + name + "' />"
									 + name + "</b></center>"
									 + "		</td>"
								//	 + "		<td></td>"
									 + "	</tr>"
									 + "	<tr>"
									 + "		<td width='170' align='right'>charsetIn :</td>"
									 + "		<td width='130'><input type='text' name='jdbc_in_" + name + "' size='10' value='" + nDBCharIn + "'> </input></td>"
									 //+ "			<td><select name='jdbc_in_" + name + "'>" + CHARTSET + "</select>"
									 + "		<td width='130' align='right'>charsetOut :</td>"
									 + "		<td width='260'><input type='text' name='jdbc_out_" + name + "' size='10' value='" + nDBCharOut + "'> </input></td>"
									 //+ "			<td><select name='jdbc_out_" + name + "'>" + CHARTSET + "</select>"
									 + "	</tr>"
									 + "	<tr bgcolor='#ebebeb'>"
									 + "		<td width='170' align='right'>jdbc driver :</td>"
									 + "		<td colspan='3'> <input type='text' name='jdbc_driver_" + name + "' size='50' value='" + nJdbcDriver+ "'> </input></td>"
									 + "	</tr>"
									 + "	<tr>"
									 + "		<td width='170' align='right'>jdbc url :</td>"
									 + "		<td colspan='3'> <input type='text' name='jdbc_url_" + name + "' size='50' value='" + nJdbcUrl + "'> </input></td>"
									 + "	</tr>"
									 + "	<tr bgcolor='#ebebeb'>"
									 + "		<td width='170' align='right'>jdbc user :</td>"
									 + "		<td colspan='3'> <input type='text' name='jdbc_user_" + name + "' size='20' value='" + nJdbcUser + "'> </input></td>"
									 + "	</tr>"
									 + "	<tr>"
									 + "		<td width='170' align='right'>jdbc password :</td>"
									 + "		<td colspan='3'> <input type='text' name='jdbc_pass_" + name + "' size='20' value='" + nJdbcPass + "'> </input></td>"
									 //+ "	</tr>"
									 //+ "	<tr bgcolor='#ebebeb'>"
									 //+ "		<td width='170' align='right'>jdbc schema :</td>"
									 //+ "		<td colspan='3'> <input type='text' name='jdbc_schema_" + name + "' size='20' value='" + nJdbcSchema + "'> </input></td>"
									 + "	</tr> </table>";				
		
		//누적된 기존 data를 담고 있을 변수 dataSource
		var dataSouce = document.getElementById('dataSource_value').value;
		dataSource_value.innerHTML += resource_value;
		
//		for(var i = 0; i <document.getElementById('jdbc_in_' + name).length; i++) {
//			var value = document.getElementById('jdbc_in_' + name)[i].value;
//			if(codeUpperCase(value) == codeUpperCase(nDBCharIn)) {
//				document.getElementById('jdbc_in_' + name).selectedIndex = i;
//			}
//			
//			value = document.getElementById('jdbc_out_' + name)[i].value;
//			if(codeUpperCase(value) == codeUpperCase(nDBCharOut)) {
//				document.getElementById('jdbc_out_' + name).selectedIndex = i;
//			}
//		}
				
	}
	
	//암호화 모듈 어뎁터 선택
	function crypto_Change() {
		
		var list = document.getElementById('crypto_spi');
		crypto_number = 0;
		crypto_adapter.innerHTML = "";
			crypto_param.innerHTML = "";
		if(list.selectedIndex != 0) {
			param_Button();
		}
	}
	
	//암호화 모듈 어뎁터 버튼 추가
	function param_Button() {
		
		crypto_adapter.innerHTML = "<input type='button' value='파라미터 추가' onclick=param_Add(); ></input>";
	}
	
	//암호화 모듈의 파라미터 추가
	var crypto_table = "";
	var crypto_number = 0;
	function param_Add() {
		crypto_number++;
		crypto_table = "param <input type='text' name='crypto_name_" + crypto_number + "' value='" + nParamName + "' size='5'></input>"
								 + "value <input type='text' name='crypto_value_" + crypto_number + "' value='" + nParamValue + "' size='60'></input> <br>";
		crypto_param.innerHTML += crypto_table;
	}