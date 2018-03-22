package com.exem9.lms.web.maintenance.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.maintenance.bean.MatBean;


public interface IMatDao {

	public void insertMatinfo(HashMap params) throws Throwable;

	public List<MatBean> getmatinfo(HashMap params) throws Throwable;

	public int getNCount(HashMap params) throws Throwable;

	public String deleteMatinfo(HashMap params) throws Throwable;

	public String updateMatinfo(HashMap params) throws Throwable;

	public Integer getInsertedMatId(HashMap params)throws Throwable;

	public void insertMatCusinfo(HashMap params) throws Throwable;

}
