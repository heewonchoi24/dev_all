<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<page:applyDecorator name="cjsTop" />
<page:applyDecorator name="cjsHeader" />
<page:applyDecorator name="cjsSpotsub" />

<decorator:body />   
  
<script type="text/javascript">
  $(".wrap_table").tableFixed();
</script>
<page:applyDecorator name="cjsFooter" />
<page:applyDecorator name="frontBot" />
