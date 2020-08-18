<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	pageContext.setAttribute("pageLevel1", "contact");
    pageContext.setAttribute("pageLevel2", "4");
    pageContext.setAttribute("pageName", "메뉴 관리");
%>
<%@include file="../layout/top.jsp"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/sidebar.jsp"%>

<!-- main -->
<div id="main">
    <div class="group">
        <div class="body">
            <table class="board_list_normal">
                <thead>
                    <tr>
                        <th>레벨</th>
                        <th>순서</th>
                        <th>메뉴명</th>
                        <th>URL</th>
                        <th>사용여부</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="num">1</td>
                        <td class="num">1</td>
                        <td class="">관리수준 진단</td>
                        <td class="">/mngLevelRes/mngLevelSummaryList.do</td>
                        <td class="state"><span class="active">사용</span></td>
                        <td class="center"><a href="menuWrite.jsp" class="link">수정</a></td>
                    </tr>
                    <tr>
                        <td class="num">2</td>
                        <td class="num">1</td>
                        <td class="">└ 기초현황</td>
                        <td class="">/mngLevelRes/mngLevelSummaryList.do</td>
                        <td class="state"><span class="active">사용</span></td>
                        <td class="center"><a href="menuWrite.jsp" class="link">수정</a></td>
                    </tr>
                    <tr>
                        <td class="num">2</td>
                        <td class="num">2</td>
                        <td class="">└ 실적등록 및 조회</td>
                        <td class="">/mngLevelRes/mngLevelSummaryList.do</td>
                        <td class="state"><span class="">미사용</span></td>
                        <td class="center"><a href="menuWrite.jsp" class="link">수정</a></td>
                    </tr>
                    <tr>
                        <td class="num">2</td>
                        <td class="num">3</td>
                        <td class="">└ 서면평가</td>
                        <td class="">/mngLevelRes/mngLevelSummaryList.do</td>
                        <td class="state"><span class="active">사용</span></td>
                        <td class="center"><a href="menuWrite.jsp" class="link">수정</a></td>
                    </tr>
                    <tr>
                        <td class="num">2</td>
                        <td class="num">4</td>
                        <td class="">└ 수준진단 결과</td>
                        <td class="">/mngLevelRes/mngLevelSummaryList.do</td>
                        <td class="state"><span class="active">사용</span></td>
                        <td class="center"><a href="menuWrite.jsp" class="link">수정</a></td>
                    </tr>
                    <tr>
                        <td class="num">1</td>
                        <td class="num">2</td>
                        <td class="">관리수준 현황조사</td>
                        <td class="">/mngLevelRes/mngLevelSummaryList.do</td>
                        <td class="state"><span class="active">사용</span></td>
                        <td class="center"><a href="menuWrite.jsp" class="link">수정</a></td>
                    </tr>
                    <tr>
                        <td class="num">2</td>
                        <td class="num">1</td>
                        <td class="">└ 현장점검 등록</td>
                        <td class="">/mngLevelRes/mngLevelSummaryList.do</td>
                        <td class="state"><span class="active">사용</span></td>
                        <td class="center"><a href="menuWrite.jsp" class="link">수정</a></td>
                    </tr>
                    <tr>
                        <td class="none" colspan="9">리스트가 없습니다.</td>
                    </tr>
                </tbody>
            </table>
            <div class="board_list_btn right">
                <a href="menuWrite.jsp" class="btn blue">신규 등록</a>
            </div>
        </div>
    </div>
</div>
<!-- main -->

<script type="text/javascript">

</script>
<style type="text/css">
    
</style>

<%@include file="../layout/bot.jsp"%>