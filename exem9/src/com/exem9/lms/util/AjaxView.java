package com.exem9.lms.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

import flexjson.JSONSerializer;


public class AjaxView extends AbstractView{
	
	public AjaxView() {
		setContentType("text/plain; charset=utf-8");
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	protected void renderMergedOutputModel(Map map,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		JSONSerializer serializer = new JSONSerializer();         
		String jsonString = serializer.serialize(map);      
	
		response.getOutputStream().write( jsonString.getBytes() );
	}

}
