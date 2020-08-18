<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="/resources/admin/js/bootstrap-datetimepicker.min.js"></script>
<link rel="stylesheet" href="/resources/admin/css/bootstrap-datetimepicker.css" type="text/css">

<!-- main -->
<div id="main">
    <div class="group">
        <div class="header">
            <h3>교육일정</h3>
        </div>
        <div class="body" style="min-height: auto; overflow: inherit;">
           <table class="board_list_write">
                <tbody>
				<c:forEach var="item" begin="1" end="5" step="1">
                    <tr>
                        <th>
                            <div class="switch" style="right: 180px;">
                                <label>
                                    <input type="checkbox" checked="">
                                    <span class="lever"></span>
                                </label>
                            </div>
                        </th>
                        <td>
                            <div>
                                <input type="text" name="" class="ipt" style="width: 300px;" value="국립소록도병원 출장교육">
                                <input type="text" name="" class="ipt" style="width: 300px;" value="정상교 책임 , 황준희 주임">
                            </div>
                            <div style="margin-top: 10px;">
                                <div class="dataSearch">
                                    <div class="ipt_group datepicker">
                                        <input type="text" name="" class="ipt w100p" id="tst${item}_s" value="" placeholder="시작일시">
                                        <label for="tst${item}_s" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                    </div>
                                    <div class="div">~</div>
                                    <div class="ipt_group datepicker">
                                        <input type="text" name="" class="ipt w100p" id="tst${item}_e" value="" placeholder="종료일시">
                                        <label for="tst${item}_e" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                    </div>
                                    <select class="ipt" style="width: 200px; margin-left: 20px;">
                                       <option>소속기관</option>
                                       <option>산하기관</option>
                                   </select>
                                </div>
                                <script type="text/javascript">
                                    $(function () {
                                        $('#tst${item}_s').datetimepicker({
                                            format: 'YYYY.MM.DD A hh:mm'
                                        });
                                        $('#tst${item}_e').datetimepicker({
                                            format: 'YYYY.MM.DD A hh:mm',
                                            useCurrent: false
                                        });
                                        $("#tst${item}_s").on("dp.change", function (e) {
                                            $('#cst1_e').data("DateTimePicker").minDate(e.date);
                                        });
                                        $("#tst${item}_e").on("dp.change", function (e) {
                                            $('#cst1_s').data("DateTimePicker").maxDate(e.date);
                                        });
                                    });
                                </script>
                            </div>
                        </td>
                    </tr>
</c:forEach>
                </tbody>
           </table>
        </div>
        <div class="group">
        <div class="header">
            <h3>컨설팅일정</h3>
        </div>
        <div class="body" style="min-height: auto; overflow: inherit;">
           <table class="board_list_write">
                <tbody>
<c:forEach var="item" begin="1" end="5" step="1">
                    <tr>
                        <th>
                            <div class="switch" style="right: 180px;">
                                <label>
                                    <input type="checkbox" checked="">
                                    <span class="lever"></span>
                                </label>
                            </div>
                        </th>
                        <td>
                            <div>
                                <input type="text" name="" class="ipt" style="width: 300px;" value="국립소록도병원 출장교육">
                                <input type="text" name="" class="ipt" style="width: 300px;" value="정상교 책임 , 황준희 주임">
                            </div>
                            <div style="margin-top: 10px;">
                                <div class="dataSearch">
                                    <div class="ipt_group datepicker">
                                        <input type="text" name="" class="ipt w100p" id="cst${item}_s" value="" placeholder="시작일시">
                                        <label for="cst${item}_s" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                    </div>
                                    <div class="div">~</div>
                                    <div class="ipt_group datepicker">
                                        <input type="text" name="" class="ipt w100p" id="cst${item}_e" value="" placeholder="종료일시">
                                        <label for="cst${item}_e" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                    </div>
                                    <select class="ipt" style="width: 200px; margin-left: 20px;">
                                       <option>소속기관</option>
                                       <option>산하기관</option>
                                   </select>
                                </div>
                                <script type="text/javascript">
                                    $(function () {
                                        $('#cst${item}_s').datetimepicker({
                                            format: 'YYYY.MM.DD A hh:mm'
                                        });
                                        $('#cst${item}_e').datetimepicker({
                                            format: 'YYYY.MM.DD A hh:mm',
                                            useCurrent: false
                                        });
                                        $("#cst${item}_s").on("dp.change", function (e) {
                                            $('#cst1_e').data("DateTimePicker").minDate(e.date);
                                        });
                                        $("#cst${item}_e").on("dp.change", function (e) {
                                            $('#cst1_s').data("DateTimePicker").maxDate(e.date);
                                        });
                                    });
                                </script>
                            </div>
                        </td>
                    </tr>
</c:forEach>
                </tbody>
           </table>
        </div>
    </div>
    <div class="group">
        <div class="body" style="min-height: auto;">
           <div class="board_list_btn right" style="margin-top: 0;">
                <a href="/admin/contact/dashboardSchedule.do" class="btn black">목록으로</a>
                <a href="#" class="btn blue">저장</a>
            </div>
        </div>
    </div>
</div>
<!-- main -->
<script type="text/javascript">
    $(function(){
        $('.switch input[type=checkbox]').change(function(e) {
            if($(this).prop('checked')){
                $(this).closest('tr').find('td input, td select').attr('disabled', false);
            }else{
                $(this).closest('tr').find('td input, td select').attr('disabled', true);
            }
        });
    });
</script>