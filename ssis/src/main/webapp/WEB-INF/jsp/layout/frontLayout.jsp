<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<page:applyDecorator name="frontTop" />
<page:applyDecorator name="frontHeader" />
<page:applyDecorator name="spot_sub" />

<decorator:body />   
  
<page:applyDecorator name="frontFooter" />
<page:applyDecorator name="frontBot" />
