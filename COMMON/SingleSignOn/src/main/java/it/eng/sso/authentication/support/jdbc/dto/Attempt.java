package it.eng.sso.authentication.support.jdbc.dto;

import java.sql.Timestamp;

public class Attempt {
	private String username;
	private Integer attemptNr;
	private Timestamp attemptTs;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getAttemptNr() {
		return attemptNr;
	}

	public void setAttemptNr(Integer attemptNr) {
		this.attemptNr = attemptNr;
	}

	public Timestamp getAttemptTs() {
		return attemptTs;
	}

	public void setAttemptTs(Timestamp attemptTs) {
		this.attemptTs = attemptTs;
	}

}
