var initBarChart = function(chartId, statNm, apple, banana){
	var dom = document.getElementById(chartId);
	var myChart = echarts.init(dom);
	this.app = {};
	this.option = null;
	this.app.title = '테스트 차트';

	this.option = {
	    color: ['#3398DB'],
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : { 
	            type : 'shadow'
	        }
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '10%',
	        containLabel: true
	    },
	    xAxis : [
	        {
	            type : 'category',
	            data : apple,
	            axisTick: {
	                alignWithLabel: true,
	            },
	            axisLabel: {
	                rotate: 50,
	            }
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name: statNm,
	            type:'bar',
	            barWidth: '60%',
	            data:banana
	        }
	    ]
	};
	
	if (this.option && typeof this.option === "object") {
	    myChart.setOption(this.option, true);
	}
}

var initRadarChart = function(chartId, chartName, jsonArr1, jsonArr2){
	var dom = document.getElementById(chartId);
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title: {
	        text: ''
	    },
	    tooltip: {},
	    radar: {
	        // shape: 'circle',
	        name: {
	            textStyle: {
	                color: '#000',
	                backgroundColor: '#fff',
	                borderRadius: 3,
	                padding: [3, 5]
	           }
	        },
	        indicator : jsonArr1
	    },
	    series: [{
	        name: chartName,
	        type: 'radar',
			
	        // areaStyle: {normal: {}},
	        data : [
	            {
	                value : jsonArr2,
	                name : chartName,
					label: {
	                        normal: {
	                            show: true
	                        }
	                    }
	            }
	        ]
	    }]
	};;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

var initLineChart = function(chartId, statNm, arr1, arr2, arr3, arr4){
	var dom = document.getElementById("chart");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {

	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['관리수준 진단 결과','관리수준 현황 결과']
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '10%',
	        containLabel: true
	    },
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: arr1,
			axisLabel: {
				rotate: 50,
			}
	    },
	    yAxis: {
	        type: 'value'
	    },
	    series: [
	        {
	            name:'관리수준 진단 결과',
	            type:'line',
				symbolSize:10,
	            data:arr2
	        },
	        {
	            name:'관리수준 현황 결과',
	            type:'line',
				symbolSize:10,
	            data:arr4
	        }
	    ]
	};
	;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

var initLineOneChart = function(chartId, chartName, jsonArr1, jsonArr2){
	var dom = document.getElementById(chartId);
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {

	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:chartName
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '10%',
	        containLabel: true
	    },
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: jsonArr1
	    },
	    yAxis: {
	        type: 'value'
	    },
	    series: [
	        {
	            name:chartName,
	            type:'line',
				symbolSize:10,
	            data:jsonArr2
	        }
	    ]
	};
	;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}