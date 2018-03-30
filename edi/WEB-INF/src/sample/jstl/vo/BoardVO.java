package sample.jstl.vo;

public class BoardVO {
	private String NO = "";
	private String TITLE = "";
	private String WRITER = "";
	private String CONTENTS = "";
	private String WDATE = "";
	
	public String getCONTENTS() {
		return CONTENTS;
	}
	public void setCONTENTS(String CONTENTS) {
		this.CONTENTS = CONTENTS;
	}
	public String getNO() {
		return NO;
	}
	public void setNO(String NO) {
		this.NO = NO;
	}
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String TITLE) {
		this.TITLE = TITLE;
	}
	public String getWDATE() {
		return WDATE;
	}
	public void setWDATE(String WDATE) {
		this.WDATE = WDATE;
	}
	public String getWRITER() {
		return WRITER;
	}
	public void setWRITER(String WRITER) {
		this.WRITER = WRITER;
	}
	
	
}
