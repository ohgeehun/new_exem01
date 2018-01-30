package com.exem9.lms.web.main.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@RemoteProxy(name="IMainService")
@Service(value="IMainService")
public class MainService implements IMainService{

	
}