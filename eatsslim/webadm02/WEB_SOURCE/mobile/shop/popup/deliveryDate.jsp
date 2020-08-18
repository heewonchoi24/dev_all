<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
    <!-- Calendar -->
    <script type="text/javascript" src="/mobile/common/js/date.js"></script>
    <script type="text/javascript" src="/mobile/common/js/jquery.datePicker.js"></script>
<script type="text/javascript">  
$(function()
{
	$('.date-pick')
		.datePicker({createButton:false})
		.bind('click',
			function()
			{
				$(this).dpDisplay();
				this.blur();
				return false;
			}
		);
	// tl is the default so don't bother setting it's position
	$('#custom-offset').dpSetOffset(10, 300);
});
</script>
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
		    <h2>첫 배송일 확인</h2>
            <div class="clear"></div>
		</div>
	    <div class="contentpop">
		    <div class="row bg-gray">
                <div class="delivguide">
                <img class="thumb-icon" src="/mobile/images/delicar.png" width="33" height="23">
                <p>고객님이 선택하신 배송기간에 공휴일이 있습니다.배송여부를 확인해주십시오.</p> 
                </div>
                <div class="grid-navi">
                    <table class="navi" border="0" cellspacing="10" cellpadding="0">
                       <tr>
                         <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">첫 배송일 확인/공휴일 배송여부 확인</span></span></a></td>
                       </tr>
                   </table>
                </div>
                <p class="guide">* 단, 배송정보 변경은 주문후 배송시작 6일전까지 수정가능 합니다.</p>
            </div> 
            <!-- End row -->
            <div class="row">
                <div class="grid-navi">
                    <table class="navi" cellspacing="10" cellpadding="0">
                       <tr>
                         <td width="55"><a class="monthnavi" href="#"><span class="prev">8월</span></a></td>
                         <td align="center">2013년 9월25일</td>
                         <td width="55"><a class="monthnavi" href="#"><span class="next">10월</span></a></td>
                       </tr>
                   </table>
                </div>
                <span class="square bg-green"></span> 오늘 <span class="square deliday"></span> 첫 배송 가능일

            <div id="calendar" class="fc fc-ltr">
            <div class="fc-content" style="position: relative;">
                  <div class="fc-view fc-view-month fc-grid" style="position: relative; -moz-user-select: none;" unselectable="on">
                    <table class="fc-border-separate" cellspacing="0" style="width:100%">
                      <thead>
                        <tr class="fc-first fc-last">
                          <th class="fc-day-header fc-sun fc-widget-header fc-first">일</th>
                          <th class="fc-day-header fc-mon fc-widget-header">월</th>
                          <th class="fc-day-header fc-tue fc-widget-header">화</th>
                          <th class="fc-day-header fc-wed fc-widget-header">수</th>
                          <th class="fc-day-header fc-thu fc-widget-header">목</th>
                          <th class="fc-day-header fc-fri fc-widget-header">금</th>
                          <th class="fc-day-header fc-sat fc-widget-header fc-last">토</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr class="fc-week fc-first">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-01">
                            <div>
                              <div class="fc-day-number">1</div>
                            </div>
                          </td>
                          <td class="fc-day fc-mon fc-widget-content fc-past" data-date="2013-09-02">
                            <div>
                              <div class="fc-day-number">2</div>
                            </div>
                          </td>
                          <td class="fc-day fc-tue fc-widget-content fc-past" data-date="2013-09-03">
                            <div>
                              <div class="fc-day-number">3</div>
                            </div>
                          </td>
                          <td class="fc-day fc-wed fc-widget-content fc-past" data-date="2013-09-04">
                            <div>
                              <div class="fc-day-number">4</div>
                            </div>
                          </td>
                          <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2013-09-05">
                            <div>
                              <div class="fc-day-number">5</div>
                            </div>
                          </td>
                          <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2013-09-06">
                            <div>
                              <div class="fc-day-number">6</div>
                            </div>
                          </td>
                          <td class="fc-day fc-sat fc-widget-content fc-past fc-last" data-date="2013-09-07">
                            <div>
                              <div class="fc-day-number">7</div>
                            </div>
                        </td>
                        </tr>
                        <tr class="fc-week">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-08">
                            <div>
                              <div class="fc-day-number">8</div>
                            </div>
                          </td>
                          <td class="fc-day fc-mon fc-widget-content fc-past" data-date="2013-09-09">
                             <div>
                              <div class="fc-day-number">9</div>
                            </div>
                          </td>
                          <td class="fc-day fc-tue fc-widget-content fc-past" data-date="2013-09-10">
                             <div>
                              <div class="fc-day-number">10</div>
                            </div>
                          </td>
                          <td class="fc-day fc-wed fc-widget-content fc-past" data-date="2013-09-11">
                             <div>
                              <div class="fc-day-number">11</div>
                            </div>
                          </td>
                          <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2013-09-12">
                             <div>
                              <div class="fc-day-number">12</div>
                            </div>
                          </td>
                          <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2013-09-13">
                             <div>
                              <div class="fc-day-number">13</div>
                            </div>
                          </td>
                          <td class="fc-day fc-sat fc-widget-content fc-past fc-last" data-date="2013-09-14">
                             <div>
                              <div class="fc-day-number">14</div>
                            </div>
                         </td>
                        </tr>
                        <tr class="fc-week">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-15">
                             <div>
                              <div class="fc-day-number">15</div>
                            </div>
                          </td>
                          <td class="fc-day fc-mon fc-widget-content fc-past" data-date="2013-09-16">
                             <div>
                              <div class="fc-day-number">16</div>
                            </div>
                          </td>
                          <td class="fc-day fc-tue fc-widget-content fc-past payday" data-date="2013-09-17">
                            <div>
                              <div class="fc-day-number">17</div>
                            </div>
                          </td>
                          <td class="fc-day fc-wed fc-widget-content fc-past deliday" data-date="2013-09-18">
                            <div>
                              <div class="fc-day-number">18</div>
                            </div>
                          </td>
                          <td class="fc-day fc-thu fc-widget-content fc-past holiday" data-date="2013-09-19">
                            <div>
                              <div class="fc-day-number">19</div>
                            </div>
                          </td>
                          <td class="fc-day fc-fri fc-widget-content fc-past deliday" data-date="2013-09-20">
                            <div>
                              <div class="fc-day-number">20</div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-sat fc-widget-content fc-past fc-last" data-date="2013-09-21">
                            <div>
                              <div class="fc-day-number">21</div>
                            </div>
                         </td>
                        </tr>
                        <tr class="fc-week">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-22">
                            <div>
                              <div class="fc-day-number">22</div>
                            </div>
                          </td>
                          <td class="fc-day fc-mon fc-widget-content fc-past deliday" data-date="2013-09-23">
                            <div>
                              <div class="fc-day-number">23</div>
                            </div>
                          </td>
                          <td class="fc-day fc-tue fc-widget-content fc-past deliday" data-date="2013-09-24">
                            <div>
                              <div class="fc-day-number">24</div>
                            </div>
                          </td>
                          <td class="fc-day fc-wed fc-widget-content fc-today deliday fc-state-highlight" data-date="2013-09-25">
                            <div>
                              <div class="fc-day-number">25</div>
                            </div>
                          </td>
                          <td class="fc-day fc-thu fc-widget-content fc-future deliday" data-date="2013-09-26">
                            <div>
                              <div class="fc-day-number">26</div>
                            </div>
                          </td>
                          <td class="fc-day fc-fri fc-widget-content fc-future deliday" data-date="2013-09-27">
                            <div>
                              <div class="fc-day-number">27</div>
                            </div>
                          </td>
                          <td class="fc-day fc-sat fc-widget-content fc-future fc-last" data-date="2013-09-28">
                            <div>
                              <div class="fc-day-number">28</div>
                            </div>
                         </td>
                        </tr>
                        <tr class="fc-week fc-last">
                          <td class="fc-day fc-sun fc-widget-content fc-future fc-first" data-date="2013-09-29">
                            <div>
                              <div class="fc-day-number">29</div>
                            </div>
                          </td>
                          <td class="fc-day fc-mon fc-widget-content fc-future" data-date="2013-09-30">
                             <div>
                              <div class="fc-day-number">30</div>
                            </div>
                          </td>
                          <td class="fc-day fc-tue fc-widget-content fc-other-month fc-future" data-date="2013-10-01">
                            <div>
                              <div class="fc-day-number">1</div>
                            </div>
                          </td>
                          <td class="fc-day fc-wed fc-widget-content fc-other-month fc-future" data-date="2013-10-02">
                            <div>
                              <div class="fc-day-number">2</div>
                            </div>
                          </td>
                          <td class="fc-day fc-thu fc-widget-content fc-other-month fc-future" data-date="2013-10-03">
                            <div>
                              <div class="fc-day-number">3</div>
                            </div>
                          </td>
                          <td class="fc-day fc-fri fc-widget-content fc-other-month fc-future" data-date="2013-10-04">
                            <div>
                              <div class="fc-day-number">4</div>
                            </div>
                          </td>
                          <td class="fc-day fc-sat fc-widget-content fc-other-month fc-future fc-last" data-date="2013-10-05">
                            <div>
                              <div class="fc-day-number">5</div>
                            </div>
                         </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
               </div>
             </div>
            </div> 
            <!-- End row -->
            <div class="row" style="padding:0 10px;">
                <span>
                <label style="float:left;">첫 배송일 지정</label>
                <input name="date1" id="date1" class="date-pick" />
                </span>
                <div class="clear"></div>
            </div>
            <!-- End row -->
            <div class="row bg-gray">
                <table class="tdbottom" width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th>휴무일</th>
                    <th>휴무명</th>
                    <th>배송여부확인</th>
                  </tr>
                  <tr>
                    <td>2013.09.30</td>
                    <td>광복절</td>
                    <td>
                     <div class="ordernum">
						    <input type="radio" id="radio1" name="radios" value="all" checked="checked">
							<label for="radio1">배송</label>
							<input type="radio" id="radio2" name="radios"value="false">
							<label for="radio2">배송안함</label>
						 <div class="clear"></div>
					   </div>
                    </td>
                  </tr>
                </table>
            </div>
            <!-- End row -->
            <div class="row">
            <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="#" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">확인</span></span></a></td>
               </tr>
           </table>
           </div>
           </div>
           <!-- End row -->
	    </div>
		<!-- End contentpop -->
	</div>
</body>
</html>