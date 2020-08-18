<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


	<%@ include file="../include/inc-cal-script.jsp" %>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>

</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>이벤트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post" action="event_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="ins" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>웹/모바일 구분</span></th>
								<td>
									<input type="radio" name="gubun" value="0" checked="checked" />
									모두
									<input type="radio" name="gubun" value="1" />
									웹
									<input type="radio" name="gubun" value="2" />
									모바일
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 구분</span></th>
								<td>
									<input type="radio" name="event_type" value="01" checked="checked" />
									EVENT
									<input type="radio" name="event_type" value="02" />
									SALE
									<input type="radio" name="event_type" value="03" />
									브랜드위크
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>공개여부</span></th>
								<td>
									<input type="radio" name="open_yn" value="Y" checked="checked" />
									공개
									<input type="radio" name="open_yn" value="N" />
									미공개
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 기간</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="8" readonly="readonly" required label="시작일자" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="8" readonly="readonly" required label="마감일자" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 대상</span></th>
								<td>
									<input type="text" name="event_target" id="event_target" class="input1" style="width:200px;" maxlength="50" value="잇슬림 전회원" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>당첨자발표일</span></th>
								<td>
									<input type="text" name="anc_date" id="anc_date" class="input1" maxlength="8" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>쿠폰 발급 방식</span></th>
								<td>
									<input type="radio" id="dw_yn" name="dw_yn" value="DW" checked="checked" />
									맵 버튼 클릭 시 발급
									<input type="radio" id="dw_yn" name="dw_yn" value="RDW"/>
									댓글 등록 시 발급
								</td>
							</tr>
							<tr>
								<th scope="row"><span>PC<br/> 이벤트 이미지</span></th>
								<td>
									<div class="imgUpload">
										<input type="file" id="content" name="content" value=""> (최적화 사이즈: 1000 x auto | BOS에서 PC버전은 50%로 축소되어 보입니다.)
									</div>
									<div class="imgArea" id="imgArea_p" style=" max-width: 500px; min-height: 300px;">
										<img id="image_section_p" name="image_section_p" border="0" usemap="#tabMap">
									</div>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>쿠폰넘버</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 1
													<button type="button" onclick="addImageMap('p',1);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p1" id="imgMapLocal_p1" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="coupon_num_p1" id="coupon_num_p1" class="input1" style="width:100px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 2
													<button type="button" onclick="addImageMap('p',2);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p2" id="imgMapLocal_p2" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="coupon_num_p2" id="coupon_num_p2" class="input1" style="width:100px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 3
													<button type="button" onclick="addImageMap('p',3);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p3" id="imgMapLocal_p3" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="coupon_num_p3" id="coupon_num_p3" class="input1" style="width:100px;"/>
												</td>
											</tr>
										</tbody>
									</table>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>하이퍼링크</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 4
													<button type="button" onclick="addImageMap('p',4);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p4" id="imgMapLocal_p4" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p4" id="link_num_p4" class="input1" style="width:300px"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 5
													<button type="button" onclick="addImageMap('p',5);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p5" id="imgMapLocal_p5" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p5" id="link_num_p5" class="input1" style="width:300px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 6
													<button type="button" onclick="addImageMap('p',6);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p6" id="imgMapLocal_p6" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p6" id="link_num_p6" class="input1" style="width:300px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 7
													<button type="button" onclick="addImageMap('p',7);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p7" id="imgMapLocal_p7" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p7" id="link_num_p7" class="input1" style="width:300px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 8
													<button type="button" onclick="addImageMap('p',8);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p8" id="imgMapLocal_p8" class="input1" style="width:400px;" />
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p8" id="link_num_p8" class="input1" style="width:300px;"/>
												</td>
											</tr>
											</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>MOBILE<br/> 이벤트 이미지</span></th>
								<td>
									<div class="imgUpload">
										<input type="file" id="mcontent" name="mcontent" value=""> (최적화 사이즈: 320 x auto)
									</div>
									<div class="imgArea" id="imgArea_m" style="max-width: 320px; min-height: 600px;">
										<img id="image_section_m" name="image_section_m" border="0">
									</div>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>쿠폰넘버</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 1
													<button type="button" onclick="addImageMap('m',1);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m1" id="imgMapLocal_m1" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="coupon_num_m1" id="coupon_num_m1" class="input1" style="width:100px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 2
													<button type="button" onclick="addImageMap('m',2);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m2" id="imgMapLocal_m2" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="coupon_num_m2" id="coupon_num_m2" class="input1" style="width:100px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 3
													<button type="button" onclick="addImageMap('m',3);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m3" id="imgMapLocal_m3" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="coupon_num_m3" id="coupon_num_m3" class="input1" style="width:100px;"/>
												</td>
											</tr>
										</tbody>
									</table>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>하이퍼링크</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 4
													<button type="button" onclick="addImageMap('m',4);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m4" id="imgMapLocal_m4" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="link_num_m4" id="link_num_m4" class="input1" style="width:300px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 5
													<button type="button" onclick="addImageMap('m',5);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m5" id="imgMapLocal_m5" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="link_num_m5" id="link_num_m5" class="input1" style="width:300px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 6
													<button type="button" onclick="addImageMap('m',6);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m6" id="imgMapLocal_m6" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="link_num_m6" id="link_num_m6" class="input1" style="width:300px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 7
													<button type="button" onclick="addImageMap('m',7);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m7" id="imgMapLocal_m7" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="link_num_m7" id="link_num_m7" class="input1" style="width:300px;"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 8
													<button type="button" onclick="addImageMap('m',8);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m8" id="imgMapLocal_m8" class="input1" style="width:400px;" />
												</td>
												<td>
													<input type="text" name="link_num_m8" id="link_num_m8
													" class="input1" style="width:300px;"/>
												</td>
											</tr>
											</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="" />
									(최적화 사이즈: 608 x 203)
								</td>
							</tr>				
							<tr>
								<th scope="row"><span>URL</span></th>
								<td>
									<input type="text" name="event_url" id="event_url" class="input1" style="width:400px;" maxlength="100" />
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table id="goodsTable" class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="80px" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" colspan="5" style="text-align:center">
									<span>체험단 제품등록(옵션)</span>
									<a href="javascript:;" id="addGoodsBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">추가</span></a>
								</th>
							</tr>
							<tr class="goods_item0 hidden">
								<th scope="row"><span>제품명</span></th>
								<td>
									<input type="text" name="goods_name" class="input1" style="width:400px;" maxlength="50" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="chkForm(document.frm_write)" class="function_btn"><span>저장</span></a>
						<a href="event_list.jsp" class="function_btn"><span>목록</span></a>
					</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$("#title").focus();
	$('#stdate,#ltdate').datepick({
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$("#anc_date").datepick({
	    dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$("#addGoodsBtn").click(function(){
		var lastItemNo = $("#goodsTable tr:last").attr("class").replace("goods_item", "");

		var newitem = $("#goodsTable tr:eq(1)").clone();
		newitem.removeClass();
		newitem.find("td:eq(0)").attr("rowspan", "1");
		newitem.addClass("goods_item"+(parseInt(lastItemNo)+1));
		newitem.removeClass("hidden");

		$("#goodsTable").append(newitem);
	});
});

function setPeriod(dates) {
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function delTr(obj) {
	$(obj).parent().parent().remove();
}

function addImageMap(f,n) {
	var mapID = "imgMap_"+f+n
	if($("#"+mapID).length == 0){
		$("#imgArea_"+f).append('<div id="'+mapID+'" class="ui-widget-content imgMap"><div class="inner">'+n+'<a herf="javascript:void(0);" class="close">X</a></div></div>');
		$("#"+mapID).draggable({
			appendTo: "#imgArea_"+f,
			containment: "#imgArea_"+f,
			scroll: false,
			drag: function( event, ui ) {
				var w = $("#"+mapID).outerWidth(),
					h = $("#"+mapID).outerHeight();
				if(f=="p"){
					$("#imgMapLocal_"+f+n).val((ui.position.left*2)+","+(ui.position.top*2)+","+((ui.position.left+w)*2)+","+((ui.position.top+h)*2));
				}else{
					$("#imgMapLocal_"+f+n).val(ui.position.left+","+ui.position.top+","+(ui.position.left+w)+","+(ui.position.top+h));
				}
			}
		})
		.resizable({
			resize: function( event, ui ) {
				var w = $("#"+mapID).outerWidth(),
					h = $("#"+mapID).outerHeight();
				if(f=="p"){
					$("#imgMapLocal_"+f+n).val((ui.position.left*2)+","+(ui.position.top*2)+","+((ui.position.left+w)*2)+","+((ui.position.top+h)*2));
				}else{
					$("#imgMapLocal_"+f+n).val(ui.position.left+","+ui.position.top+","+(ui.position.left+w)+","+(ui.position.top+h));
				}
			}
		});

		$("#"+mapID).find('.close').off().click(function(event) {
			$("#"+mapID).draggable( "destroy" ).resizable( "destroy" ).remove();
			$("#imgMapLocal_"+f+n).val("");
		});
	}
}

//	PC - 이미지를 올리기전에 선택했을때 미리 보여준다
$(function() {
	$("#content").on('change', function(){
		readURL_pc(this);
	});
});

function readURL_pc(input) {
	if (input.files && input.files[0]) {
	var reader = new FileReader();

	reader.onload = function (e) {
			$('#image_section_p').attr('src', e.target.result);
		}

	  reader.readAsDataURL(input.files[0]);
	}
}

//	모바일 - 이미지를 올리기전에 선택했을때 미리 보여준다
$(function() {
	$("#mcontent").on('change', function(){
		readURL_M(this);
	});
});

function readURL_M(input) {
	if (input.files && input.files[0]) {
	var reader = new FileReader();

	reader.onload = function (e) {
			$('#image_section_m').attr('src', e.target.result);
		}

	  reader.readAsDataURL(input.files[0]);
	}
}
</script>

<style type="text/css">
	.imgArea { position: relative; margin: 20px 0; border: 1px solid #d9d9d9; width: 100%;  overflow: hidden; }
	.imgArea img { max-width: 100%; }
	.imgMap { width: 100px; height: 100px; background-color: rgba(0,255,255,0.5); padding: 5px; box-sizing: border-box; border: 0; color: #fff; position: absolute; left: 1em; bottom: 1em; font-weight: bold; }
	.imgMap > .inner { position: relative; }
	.imgMap .close { position: absolute; top: 0; right: 2px; color: #fff; font-weight: bold; display: block; cursor: pointer; text-decoration: none !important; }
</style>
<!-- 웹에디터 활성화 스크립트 -->
<script src="/editor/editor_board.js"></script>
<script>
	mini_editor('/editor/');
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>