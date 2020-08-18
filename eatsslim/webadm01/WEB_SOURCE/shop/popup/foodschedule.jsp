<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>첫 배송일 확인</title>
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/fullcalendar.css" />
	<link rel="stylesheet" type="text/css" media="print" href="/common/css/fullcalendar.print.css" />
	<script type="text/javascript" src='/common/js/fullcalendar.js'></script>
	<style>
	#calendar {
		width: 800px;
		margin: 0 auto;
	}
	</style>
	</head>
	<body>
    <div class="pop-wrap">
      <div class="headpop">
        <h2>식단  자세히보기</h2>
        <p>고객님께서 주문하신 일일 식단 안내입니다.</p>
      </div>
      <div class="contentpop">
        <div class="popup columns offset-by-one">
          <div class="row">
            <div class="one last col">
             <div class="graytitbox orderSearch center">
                <label>주문</label>
                <label>
					<select name="select" id="select" style="width:130px;">
						<option>감량프로그램(2주)</option>
						<option>감량프로그램(4주)</option>
					</select>
				</label>
                <label>기간: 2013.08.14~2013.08.28</label>
              <div class="clear"></div>
            </div>
          </div>
          <!-- End row -->
          <div class="row">
            <div class="one last col">
              <div id="calendar" class="fc fc-ltr">
                <table class="fc-header" style="width:100%">
                  <tbody>
                    <tr>
                      <td class="fc-header-left"></td>
                      <td class="fc-header-center"><span class="fc-button fc-button-prev fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;"> <span class="fc-text-arrow"></span> </span> <span class="fc-header-title">
                        <h2> 2013 <b>09</b> </h2>
                        </span> <span class="fc-button fc-button-next fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;"> <span class="fn-text-arrow"></span> </span></td>
                      <td class="fc-header-right"></td>
                    </tr>
                  </tbody>
                </table>
                <div class="fc-content" style="position: relative;">
                  <div class="fc-view fc-view-month fc-grid" style="position: relative; -moz-user-select: none;" unselectable="on">
                    <table class="fc-border-separate" cellspacing="0" style="width:100%">
                      <thead>
                        <tr class="fc-first fc-last">
                          <th class="fc-day-header fc-sun fc-widget-header fc-first" style="width: 100px;">일(Sun)</th>
                          <th class="fc-day-header fc-mon fc-widget-header" style="width: 100px;">월(Mon)</th>
                          <th class="fc-day-header fc-tue fc-widget-header" style="width: 100px;">화(Tue)</th>
                          <th class="fc-day-header fc-wed fc-widget-header" style="width: 100px;">수(Wed)</th>
                          <th class="fc-day-header fc-thu fc-widget-header" style="width: 100px;">목(Thu)</th>
                          <th class="fc-day-header fc-fri fc-widget-header" style="width: 100px;">금(Fri)</th>
                          <th class="fc-day-header fc-sat fc-widget-header fc-last">토(Sat)</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr class="fc-week fc-first">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-01"><div>
                              <div class="fc-day-number">1</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-mon fc-widget-content fc-past" data-date="2013-09-02"><div>
                              <div class="fc-day-number">2</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-tue fc-widget-content fc-past" data-date="2013-09-03"><div>
                              <div class="fc-day-number">3</div>
                              <div class="fc-day-content"> </div>
                            </div></td>
                          <td class="fc-day fc-wed fc-widget-content fc-past" data-date="2013-09-04"><div>
                              <div class="fc-day-number">4</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2013-09-05"><div>
                              <div class="fc-day-number">5</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2013-09-06"><div>
                              <div class="fc-day-number">6</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-sat fc-widget-content fc-past fc-last" data-date="2013-09-07"><div>
                              <div class="fc-day-number">7</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                        </tr>
                        <tr class="fc-week">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-08"><div>
                              <div class="fc-day-number">8</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-mon fc-widget-content fc-past" data-date="2013-09-09"><div>
                              <div class="fc-day-number">9</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-tue fc-widget-content fc-past" data-date="2013-09-10"><div>
                              <div class="fc-day-number">10</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-wed fc-widget-content fc-past" data-date="2013-09-11"><div>
                              <div class="fc-day-number">11</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-thu fc-widget-content fc-past" data-date="2013-09-12"><div>
                              <div class="fc-day-number">12</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-fri fc-widget-content fc-past" data-date="2013-09-13"><div>
                              <div class="fc-day-number">13</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-sat fc-widget-content fc-past fc-last" data-date="2013-09-14"><div>
                              <div class="fc-day-number">14</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                        </tr>
                        <tr class="fc-week">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-15"><div>
                              <div class="fc-day-number">15</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-mon fc-widget-content fc-past" data-date="2013-09-16"><div>
                              <div class="fc-day-number">16</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-tue fc-widget-content fc-past payday" data-date="2013-09-17"><div>
                              <div class="fc-day-number">17<span class="memo">결제일</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-wed fc-widget-content fc-past deliday" data-date="2013-09-18"><a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740">
                            <div>
                              <div class="fc-day-number">18<span class="memo">잇슬림 오는날</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-thu fc-widget-content fc-past holiday" data-date="2013-09-19"><div>
                              <div class="fc-day-number">19<span class="memo">추석</span></div>
                              <div class="fc-day-content">
                                <div class="button light small"><a href="#">배송거부해제</a></div>
                              </div>
                            </div></td>
                          <td class="fc-day fc-fri fc-widget-content fc-past deliday" data-date="2013-09-20"><a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740">
                            <div>
                              <div class="fc-day-number">20<span class="memo">잇슬림 오는날</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-sat fc-widget-content fc-past fc-last" data-date="2013-09-21"><div>
                              <div class="fc-day-number">21</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                        </tr>
                        <tr class="fc-week">
                          <td class="fc-day fc-sun fc-widget-content fc-past fc-first" data-date="2013-09-22"><div>
                              <div class="fc-day-number">22</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-mon fc-widget-content fc-past deliday" data-date="2013-09-23"><a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740">
                            <div>
                              <div class="fc-day-number">23<span class="memo">잇슬림 오는날</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-tue fc-widget-content fc-past deliday" data-date="2013-09-24"><a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740">
                            <div>
                              <div class="fc-day-number">24<span class="memo">잇슬림 오는날</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-wed fc-widget-content fc-today deliday fc-state-highlight" data-date="2013-09-25"><a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740">
                            <div>
                              <div class="fc-day-number">25<span class="memo">잇슬림 오는날</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-thu fc-widget-content fc-future deliday" data-date="2013-09-26"><a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740">
                            <div>
                              <div class="fc-day-number">26<span class="memo">잇슬림 오는날</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-fri fc-widget-content fc-future deliday" data-date="2013-09-27"><a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740">
                            <div>
                              <div class="fc-day-number">27<span class="memo">잇슬림 오는날</span></div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div>
                            </a></td>
                          <td class="fc-day fc-sat fc-widget-content fc-future fc-last" data-date="2013-09-28"><div>
                              <div class="fc-day-number">28</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                        </tr>
                        <tr class="fc-week">
                          <td class="fc-day fc-sun fc-widget-content fc-future fc-first" data-date="2013-09-29"><div>
                              <div class="fc-day-number">29</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-mon fc-widget-content fc-future" data-date="2013-09-30"><div>
                              <div class="fc-day-number">30</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-tue fc-widget-content fc-other-month fc-future" data-date="2013-10-01"><div>
                              <div class="fc-day-number">1</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-wed fc-widget-content fc-other-month fc-future" data-date="2013-10-02"><div>
                              <div class="fc-day-number">2</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-thu fc-widget-content fc-other-month fc-future" data-date="2013-10-03"><div>
                              <div class="fc-day-number">3</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-fri fc-widget-content fc-other-month fc-future" data-date="2013-10-04"><div>
                              <div class="fc-day-number">4</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-sat fc-widget-content fc-other-month fc-future fc-last" data-date="2013-10-05"><div>
                              <div class="fc-day-number">5</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                        </tr>
                        <tr class="fc-week fc-last">
                          <td class="fc-day fc-sun fc-widget-content fc-other-month fc-future fc-first" data-date="2013-10-06"><div>
                              <div class="fc-day-number">6</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-mon fc-widget-content fc-other-month fc-future" data-date="2013-10-07"><div>
                              <div class="fc-day-number">7</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-tue fc-widget-content fc-other-month fc-future" data-date="2013-10-08"><div>
                              <div class="fc-day-number">8</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-wed fc-widget-content fc-other-month fc-future" data-date="2013-10-09"><div>
                              <div class="fc-day-number">9</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-thu fc-widget-content fc-other-month fc-future" data-date="2013-10-10"><div>
                              <div class="fc-day-number">10</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-fri fc-widget-content fc-other-month fc-future" data-date="2013-10-11"><div>
                              <div class="fc-day-number">11</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                          <td class="fc-day fc-sat fc-widget-content fc-other-month fc-future fc-last" data-date="2013-10-12"><div>
                              <div class="fc-day-number">12</div>
                              <div class="fc-day-content">
                                <p>수프2</p>
                                <p>파우더1</p>
                                <p>알라1</p>
                              </div>
                            </div></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- End row --> 
        </div>
        <!-- End popup columns offset-by-one --> 
      </div>
      <!-- End contentpop --> 
    </div>
</body>
</html>