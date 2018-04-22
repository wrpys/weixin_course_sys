package com.shirokumacafe.archetype.entity;

import java.util.Date;

public class CourseExt {

	private Integer cId;

	private String cName;

	private Integer cPid;

	private Date cCreateTime;

	private String cDesc;

	private Integer fId;

	private Integer downloadNum;

	private Integer heatNum;

	// 子课程课件名字查询时候返回
	private String fName;

	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName == null ? null : cName.trim();
	}

	public Integer getcPid() {
		return cPid;
	}

	public void setcPid(Integer cPid) {
		this.cPid = cPid;
	}

	public Date getcCreateTime() {
		return cCreateTime;
	}

	public void setcCreateTime(Date cCreateTime) {
		this.cCreateTime = cCreateTime;
	}

	public String getcDesc() {
		return cDesc;
	}

	public void setcDesc(String cDesc) {
		this.cDesc = cDesc == null ? null : cDesc.trim();
	}

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public Integer getDownloadNum() {
		return downloadNum;
	}

	public void setDownloadNum(Integer downloadNum) {
		this.downloadNum = downloadNum;
	}

	public Integer getHeatNum() {
		return heatNum;
	}

	public void setHeatNum(Integer heatNum) {
		this.heatNum = heatNum;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}
}
