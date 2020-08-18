<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- main -->
<div id="main">
    <div class="group">
        <div class="body">
            <div class="board_list_top">
                <div class="board_list_info">
                    Total. <span id="totalCount">20</span>
                </div>
            </div>
            <table class="board_list_normal">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th style="width: 300px;">년월</th>
                        <th style="width: 150px;">교육</th>
                        <th style="width: 150px;">컨설팅</th>
                        <th style="width: 150px;">보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="num">1</td>
                        <td class="center">2020년 3월</td>
                        <td class="">3건</td>
                        <td class="">5건</td>
                        <td class="center"><a href="/admin/contact/dashboardScheduleWrite.do" class="link">보기</a></td>
                    </tr>
                    
                    <tr>
                        <td class="none" colspan="6">리스트가 없습니다.</td>
                    </tr>
                </tbody>
            </table>
            <div class="pagination">
                <a href="#none" class="first">first</a>
                <a href="#none" class="prev">prev</a>
                <span>1</span>
                <a href="#none">2</a>
                <a href="#none">3</a>
                <a href="#none">4</a>
                <a href="#none">5</a>
                <a href="#none" class="next">next</a>
                <a href="#none" class="last">last</a>
            </div>
            <div class="board_list_btn right">
                <a href="javascript:void(0);" class="btn blue" onclick="modalFn.show($('#addNewDBSchedule'));">신규 등록</a>
            </div>
        </div>
    </div>
</div>
<!-- main -->

<section id="addNewDBSchedule" class="modal" style="max-width: 500px;">
    <div class="inner">
        <div class="modal_header">
            <h2>교육일정 등록</h2>
            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#addNewDBSchedule'))"></i></button>
        </div>
        <div class="modal_content">
            <div class="inner">
                <div style="text-align: center;">
                    <select class="ipt" style="width: 200px;">
                        <option>2020년</option>
                    </select>
                    <select class="ipt" style="width: 200px;">
                        <option>4월</option>
                    </select>
                </div>
                <div class="board_list_btn center">
                    <a href="dashboardScheduleWrite.jsp" class="btn blue">생성</a>
                </div>
            </div>
        </div>
    </div>
</section>