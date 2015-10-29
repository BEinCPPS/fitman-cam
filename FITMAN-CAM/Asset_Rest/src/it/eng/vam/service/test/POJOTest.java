package it.eng.vam.service.test;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class POJOTest {
	
	private Double fldDouble = null;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyyMMdd", timezone="GMT")
	private Date fldDate = null;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyyMMdd HH:mm:ss", timezone="GMT")
	private Date fldTimeStamp = null;
	
	public Date getFldTimeStamp() {
		return fldTimeStamp;
	}
	public void setFldTimeStamp(Date fldTimeStamp) {
		this.fldTimeStamp = fldTimeStamp;
	}
	private BigDecimal fldBigDecimal = null;
	
	public BigDecimal getFldBigDecimal() {
		return fldBigDecimal;
	}
	public void setFldBigDecimal(BigDecimal fldBigDecimal) {
		this.fldBigDecimal = fldBigDecimal;
	}
	public Double getFldDouble() {
		return fldDouble;
	}
	public void setFldDouble(Double fldDouble) {
		this.fldDouble = fldDouble;
	}
	public Date getFldDate() {
		return fldDate;
	}
	public void setFldDate(Date fldDate) {
		this.fldDate = fldDate;
	}
	
}
