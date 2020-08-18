<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<page:applyDecorator name="admTop" />
<page:applyDecorator name="admHeader" />
<page:applyDecorator name="admSidebar" />

<decorator:body />

<page:applyDecorator name="admBot" />

<script>
	function fn_numberInit() {
		$(".onlyNumber").keyup(function() {
			this.value = this.value.replace(/[^0-9]/g,'');
		});
		$(".onlyNumber2").keyup(function() {
			this.value = this.value.replace(/[^0-9.]/g,'');
		});
	}
</script>
