<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="${ contextPath }/assets/"
  data-template="views"
  data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ contextPath }/resources/assets/js/config.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
<!-- flatpickr CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<!-- flatpickr 한글 설정 CSS -->
<link rel="stylesheet" href="https://npmcdn.com/flatpickr/dist/l10n/ko.css">
<style>
canvas#doughnutChart {
  display: block;
  width: 100%; /* 부모 컨테이너의 너비에 맞추기 */
  max-height: 400px; /* 차트의 최대 높이 */
}

#salesChart::before {
  content: ''; /* 가상 요소 필수 */
  display: inline-block; /* 블록 요소 */
  width: 10px; /* 동그라미 크기 */
  height: 10px; /* 동그라미 크기 */
  border-radius: 50%; /* 완전한 원 */
  background-color: transparent; /* 배경을 투명으로 설정 */
  border: 2px solid gray; /* 초기 테두리 색상 */
}
#salesChart.active::before {
  border: 2px solid white; /* 테두리만 흰색으로 변경 */
}

/* 중앙 정렬을 위한 CSS */
.flatpickr-current-month {
    display: flex;
    justify-content: center;
    align-items: center;
}

.flatpickr-current-month .flatpickr-monthDropdown-months,
.flatpickr-current-month .numInputWrapper {
    justify-content: center;
}
.select1 {
    height: 48px;
}
.form-control {
    height: 48px;
}

</style>
  
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
<div class="layout-container">


 <!-- 헤더 시작 -->
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- 헤더 끝 -->
 
   <div class="layout-page">

 <!-- nav 시작 -->
   <jsp:include page="/WEB-INF/views/common/nav.jsp" />
   <!-- nav 끗 -->


<div class="content-wrapper">
<!-- 세션 시작 -->
<div class="container-xxl flex-grow-1 container-p-y">
<!-- 이쪽에 세션정보 넣어야합니다 ----------------------------------------------------------------------- -->
    	
<div class="container card py-5">
<!-- 여기부터 -->

<!-- 총매출 차트 -->
<div style="display: none; margin: 20px;" id="totalSalesChart">
  <div style="display: flex; justify-content: space-between; align-items: center;">
    <!-- 차트 제목 -->
    <div>
      <span>
        <span style="font-size: 20px;">매출차트</span>
      </span>
    </div>

    <!-- 차트 유형 선택 -->
    <div style="flex: 1; margin-left: 60px;">
      <select class="select1 form-select form-select-lg chartSelect" data-allow-clear="true" style="width: 300px;">
        <option value="총매출차트" selected>총매출차트</option>
        <option value="팀별 매출 점유율 차트">팀별 매출 점유율 차트</option>
        <option value="매장 매출차트">매장 매출차트</option>
      </select>
    </div>

    <!-- 현재 날짜 표시 -->
    <div>
      <span>${currentDate}</span>
    </div>
  </div>

  <br><br>

  <!-- 연도 입력 및 버튼 -->
  <div class="justify-content-between" style="display: flex; align-items: center;">
    <!-- 차트 중앙 텍스트 -->
    <div id="lineChartCenterText" style="font-size: 20px;"></div>

    <!-- 연도 선택 -->
    <div class="d-flex justify-content-end">
      <div>
        <select id="lineChart_yearSelect" class="select1 form-select form-select-lg" data-allow-clear="true" style="width: 150px;">
          <option value="2023">2023</option>
          <option value="2024" selected>2024</option>
        </select>
      </div>
    </div>
  </div>

  <br>

  <!-- 라인 차트 캔버스 -->
  <div>
    <div class="lineChart-container" style="position: relative; width: 100%;">
      <canvas id="lineChart" style="width: 100%; height: 600px;"></canvas>
    </div>
  </div>
</div>

<script>
$(function () {
    const lineCtx = document.getElementById('lineChart').getContext('2d');
    const lineChart = new Chart(lineCtx, {
        type: 'line',
        data: {
            labels: [], // x축: 월
            datasets: [{
                label: '매출',
                data: [], // y축: 매출 데이터
                borderColor: 'orange',
                backgroundColor: 'rgba(0, 0, 0, 0)', // 배경색을 투명하게 설정
                fill: true,
                tension: 0, // 둥글게 하지 않음
                pointRadius: 5, // 기본 동그라미 크기
                pointHoverRadius: 10, // 마우스를 올렸을 때 동그라미 크기
                borderWidth: 5 // 선의 두께 설정
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: true, position: 'top' },
                tooltip: {
                    callbacks: {
                        label: (context) => {
                            const value = context.raw;
                            if (value >= 1000000000000) {
                                return (value / 1000000000000).toFixed(2) + "조 원";
                            } else if (value >= 100000000) {
                                return (value / 100000000).toFixed(2) + "억 원";
                            } else if (value >= 10000) {
                                return (value / 10000).toFixed(2) + "만 원";
                            } else {
                                return value.toLocaleString() + "원";
                            }
                        }
                    }
                }
            },
            scales: {
                x: { title: { display: false } }, // 월 표기 부분 제거
                y: {
                    title: { display: false }, // 매출 단위 표기 부분 제거
                    ticks: {
                        callback: function(value) {
                            if (value >= 1000000000000) {
                                return (value / 1000000000000).toFixed(2) + "조";
                            } else if (value >= 100000000) {
                                return (value / 100000000).toFixed(2) + "억";
                            } else if (value >= 10000) {
                                return (value / 10000).toFixed(2) + "만";
                            } else {
                                return value.toLocaleString();
                            }
                        }
                    }
                }
            }
        }
    });

    function updateLineChart(year) {
        $.ajax({
            url: `${contextPath}/chart/monthlySales.do`,
            type: "POST",
            data: JSON.stringify({ year: year }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                const months = [];
                const sales = [];
                data.forEach(item => {
                    if (item.month) { // month 값이 존재하는 경우에만 처리
                        months.push(item.month + "월");
                        sales.push(item.sumValue);
                    } else {
                        console.error("month 값이 null입니다:", item); // 디버깅용으로 출력
                    }
                });

                if (months.length === 0) {
                    $('#lineChartCenterText').text("데이터가 없습니다.");
                    return;
                }

                lineChart.data.labels = months;
                lineChart.data.datasets[0].data = sales;
                lineChart.update();

                const totalSales = sales.reduce((sum, val) => sum + val, 0);
                $('#lineChartCenterText').text("총 매출: " + totalSales.toLocaleString() + "원");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("AJAX 요청 실패:", { textStatus, errorThrown, response: jqXHR.responseText });
                alert("데이터를 가져오는 데 실패했습니다.");
            }
        });
    }

    const initialYear = new Date().getFullYear();
    $('#lineChart_yearSelect').val(initialYear); // 초기 값을 설정
    updateLineChart(initialYear);

    $('#lineChart_yearSelect').change(() => { // 연도 선택이 변경될 때마다 조회
        const year = $('#lineChart_yearSelect').val();
        if (year) updateLineChart(year);
    });

    // 현재 날짜 설정
    const currentDate = new Date().toISOString().slice(0, 10);
    $('#currentDate').text(currentDate);
});
</script>





<!-- 팀별 매출 점유율 차트 -->     
<div style="display: none; margin: 20px;" id="categorySalesChart">
	<div style="display: flex; justify-content: space-between; align-items: center;">
	 <div>
	   <span>
	      <span style="font-size: 20px;">매출차트</span>
	   </span>
	 </div>
	 <div style="flex: 1; margin-left: 60px;">
	   <select class="select1 form-select form-select-lg chartSelect" data-allow-clear="true" style="width: 300px;">
	      <option value="총매출차트">총매출차트</option>
	      <option value="팀별 매출 점유율 차트" selected>팀별 매출 점유율 차트</option>
	      <option value="매장 매출차트">매장 매출차트</option>
	    </select>
	  </div>
	  <div>
	    <span>${currentDate}</span>
	  </div>
	</div>
	<br><br>  
	<div class="justify-content-between" style="display: flex;">
	  <div id="chartCenterText" style="font-size: 20px;"></div>
		<div class="d-flex justify-content-end">
			<div>
			  <select id="doughnutChart_yearSelect" class="select1 form-select form-select-lg" data-allow-clear="true">
			    <option value="2023">2023</option>
			    <option value="2024" selected>2024</option>
			  </select>
			</div>
			<div>
			  <select id="doughnutChart_monthSelect" class="select1 form-select form-select-lg" data-allow-clear="true" style="margin-left: 10px;">
			    <option value="01">1월</option>
			    <option value="02">2월</option>
			    <option value="03">3월</option>
			    <option value="04">4월</option>
			    <option value="05">5월</option>
			    <option value="06">6월</option>
			    <option value="07">7월</option>
			    <option value="08">8월</option>
			    <option value="09">9월</option>
			    <option value="10">10월</option>
			    <option value="11">11월</option>
			    <option value="12">12월</option>
			  </select>
			</div>
		</div>
	</div>
	<div>
		<div class="doughnutChart-container" style="position: relative; width: 100%;">
		  <canvas id="doughnutChart" style="width: 100%; height: 600px;"></canvas>
		</div>
	</div>		
</div>
<script>
$(function() {
  const doughnutCtx = document.getElementById('doughnutChart').getContext('2d');
  const doughnutChart = new Chart(doughnutCtx, {
    type: 'doughnut',
    data: {
      labels: [],
      datasets: [{
        label: '매출',
        data: [],
        backgroundColor: [
          'rgb(102, 110, 232)', 'rgb(40, 208, 148)', 'rgb(253, 172, 52)', 'rgb(253, 233, 52)',
          'rgb(223, 253, 52)', 'rgb(52, 223, 253)', 'rgb(196, 52, 253)', 'rgb(253, 52, 193)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: true,
          position: 'right',
          labels: {
            font: {
              size: 16,
              family: 'Arial',
              style: 'italic',
              weight: 'bold'
            },
            color: 'gray',
            padding: 20,
            usePointStyle: true,
            pointStyle: 'round',
            borderRadius: 10
          },
          onClick: function() {}
        },
        tooltip: {
          callbacks: {
            label: (context) => {
              let label = context.label || '';
              if (label) label += ': ';           

              // 전체 매출 계산하기 전에 총 매출을 계산
              const totalSales = context.chart.data.datasets[0].data.reduce((a, b) => a + (b || 0), 0);

              if (context.raw !== null && context.raw !== undefined) {
                // 퍼센트 계산
                const percentage = totalSales > 0 ? ((context.raw / totalSales) * 100).toFixed(2) : 0;
                
                // 매출과 퍼센트 표시
                label += percentage + "% (" + context.raw.toLocaleString() + "원)";
              }
              
              return label;
            }
          }
        },
        datalabels: {
           color: '#444050',
           anchor: 'center', // 캔버스 내에서 중심을 기준으로 배치
           align: 'center',  // 라벨 정렬을 중심으로 설정
           formatter: (value, context) => {
             const totalSales = context.chart.data.datasets[0].data.reduce((a, b) => a + (b || 0), 0);
             const percentage = totalSales > 0 ? ((value / totalSales) * 100).toFixed(2) : 0;
             const label = context.chart.data.labels[context.dataIndex];
             // 반환된 라벨과 퍼센트를 한 줄씩 표시
             return label + "\n(" + percentage + "%)";
           },
           font: {
             size: 16, // 글씨 크기 설정
             family: 'Arial',
           },
           padding: 0, // 텍스트와 주변 간격 설정
           textAlign: 'center',
         },
      }
    },
    plugins: [ChartDataLabels] // datalabels 플러그인 활성화
  });

  function setInitialDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = ("0" + (today.getMonth() + 1)).slice(-2);
    
    $('#doughnutChart_yearSelect').val(year);
    $('#doughnutChart_monthSelect').val(month);
    
    updateChart(year, month);
  }

  function updateChart(year, month) {
    $.ajax({
      url: `${contextPath}/chart/teamSales.do`,
      type: "POST",
      data: JSON.stringify({ year: year, month: month }),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(data) {

        // 데이터 배열 초기화
        var departments = [];
        var sales = [];

        // deptCode를 매핑하여 레이블 추가
        const deptCodeToLabel = {
          T1: '남성의류',
          T2: '여성의류',
          T3: '식품',
          T4: '스포츠',
          T5: '뷰티',
          T6: '명품',
          T7: '문화센터',
          T8: '디지털 및 가전'
        };

        let totalSales = 0; // 총 매출 변수

        // 데이터 처리
        $.each(data, function(index, item) {
          const deptLabel = deptCodeToLabel[item["deptCode"]] || item["deptCode"];
          departments.push(deptLabel);
          sales.push(item["sale"]);
          totalSales += item["sale"]; // 총 매출 계산
        });

        // 차트 데이터 업데이트
        doughnutChart.data.labels = departments;
        doughnutChart.data.datasets[0].data = sales;

        // 차트 갱신
        doughnutChart.update();
        
        // 차트 중앙 텍스트 업데이트
        $('#chartCenterText').text(year + "년 " + month + "월 매출: " + totalSales.toLocaleString() + "원");
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.error("AJAX 요청 실패:", {
          status: textStatus,
          error: errorThrown,
          response: jqXHR.responseText,
        });
        alert("데이터를 가져오는 데 실패했습니다.");
      },
    });
  }

  $('#doughnutChart_yearSelect, #doughnutChart_monthSelect').change(function() {
    const year = $('#doughnutChart_yearSelect').val();
    const month = $('#doughnutChart_monthSelect').val();
    updateChart(year, month);
  });
  
  setInitialDate();
});
</script>

<!-- 매장 매출 차트 -->
<div style="display: none; margin: 20px;" id="storeSalesChart">
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <div>
            <span style="font-size: 20px;">매출차트</span>
        </div>
        <div style="flex: 1; margin-left: 60px;">
            <select class="select1 form-select form-select-lg chartSelect" data-allow-clear="true" style="width: 300px;">
                <option value="총매출차트">총매출차트</option>
                <option value="팀별 매출 점유율 차트">팀별 매출 점유율 차트</option>
                <option value="매장 매출차트" selected>매장 매출차트</option>
            </select>
        </div>
        <div>
            <span>${currentDate}</span>
        </div>
    </div>
    <br><br>

    <!-- Dept_code 및 날짜 선택 박스 추가 -->
    <div style="display: flex; justify-content: right; align-items: center; gap: 20px; width: 100%">
        <div>
            <label for="deptCodeSelect" class="form-label">부서 코드</label>
            <select id="deptCodeSelect" class="form-select custom-select" data-allow-clear="true" style="width: 200px; height: 48px;">
                <option value="T1">남성의류</option>
                <option value="T2">여성의류</option>
                <option value="T3">식품</option>
                <option value="T4">스포츠</option>
                <option value="T5">뷰티</option>
                <option value="T6">명품</option>
                <option value="T7">문화센터</option>
                <option value="T8">디지털 및 가전</option>
            </select>
        </div>
        <div>
            <label for="flatpickr-range" class="form-label">기간 선택</label>
            <input
                type="text"
                class="form-control custom-select"
                placeholder="날짜를 선택해주세요"               
                id="flatpickr-range" />
        </div>
    </div>
    <br>

    <div class="barChart-container" style="display: flex; justify-content: center; position: relative; width: 100%;">
        <canvas id="barChart" style="width: 80%;"></canvas>
    </div>
</div>

<script>
const storeOptions = {
    "T1": ["레노마셔츠", "라코스테"],
    "T2": ["샤넬", "구찌"],
    "T3": ["롯데마트", "홈플러스"],
    "T4": ["나이키", "아디다스"],
    "T5": ["아모레퍼시픽", "LG생활건강"],
    "T6": ["루이비통", "에르메스"],
    "T7": ["CGV", "롯데시네마"],
    "T8": ["삼성전자", "LG전자"]
};

$(function () {
    const barCtx = document.getElementById('barChart').getContext('2d');
    const barChart = new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: [], // 매장 이름
            datasets: [{
                label: '매출',
                data: [], // 매출 데이터
                borderColor: '#4BC0C0',
                backgroundColor: '#DBF2F2',
                borderWidth: 1,
                barThickness: 100
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            if (value >= 1000000000000) {
                                return (value / 1000000000000).toFixed(2) + "조";
                            } else if (value >= 100000000) {
                                return (value / 100000000).toFixed(2) + "억";
                            } else if (value >= 10000) {
                                return (value / 10000).toFixed(2) + "만";
                            } else {
                                return value.toLocaleString();
                            }
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const value = context.raw;
                            if (value >= 1000000000000) {
                                return (value / 1000000000000).toFixed(2) + "조 원";
                            } else if (value >= 100000000) {
                                return (value / 100000000).toFixed(2) + "억 원";
                            } else if (value >= 10000) {
                                return (value / 10000).toFixed(2) + "만 원";
                            } else {
                                return value.toLocaleString() + "원";
                            }
                        }
                    }
                }
            }
        }
    });

    // 날짜 상태를 전역 변수로 관리
    let selectedStartDate = null;
    let selectedEndDate = null;

    function updateBarChart(deptCode, startDate, endDate) {
        $.ajax({
            url: `${contextPath}/chart/storeSales.do`,
            type: "POST",
            data: JSON.stringify({ deptCode: deptCode, startDate: startDate, endDate: endDate }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                console.log("data:", data); // 디버깅용으로 전체 데이터를 출력
                const stores = storeOptions[deptCode];
                const sales = stores.map(store => data.find(item => item.rvStore === store)?.sumStore || 0); // 매출 데이터 추출

                barChart.data.labels = stores;
                barChart.data.datasets[0].data = sales;
                barChart.update();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("AJAX 요청 실패:", { textStatus, errorThrown, response: jqXHR.responseText });
                alert("데이터를 가져오는 데 실패했습니다.");
            }
        });
    }

 		// 초기 설정: 어제 날짜로 차트 초기화
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    selectedStartDate = yesterday.toISOString().slice(0, 10); // 초기값: 어제 날짜
    selectedEndDate = today.toISOString().slice(0, 10); // 오늘 날짜

    flatpickr("#flatpickr-range", {
        mode: "range",
        dateFormat: "Y-m-d",
        locale: "ko",
        defaultDate: [yesterday, yesterday], // 기본값을 어제로 설정
        maxDate: yesterday, // 어제 이후 날짜 선택 불가
        onClose: function(selectedDates) {
            if (selectedDates.length === 2) {
                selectedStartDate = selectedDates[0].toISOString().slice(0, 10);
                selectedEndDate = selectedDates[1].toISOString().slice(0, 10);
                const deptCode = $('#deptCodeSelect').val();
                updateBarChart(deptCode, selectedStartDate, selectedEndDate);
            }
        }
    });

    // Dept_code 선택이 변경될 때마다 차트 업데이트
    $('#deptCodeSelect').change(() => {
        const deptCode = $('#deptCodeSelect').val();
        // 변경된 부서 코드와 유지된 날짜로 차트를 업데이트
        updateBarChart(deptCode, selectedStartDate, selectedEndDate);
    });

    // 초기 설정: 오늘 날짜로 차트 초기화
    const initialDeptCode = $('#deptCodeSelect').val();
    updateBarChart(initialDeptCode, selectedStartDate, selectedEndDate);
});
</script>




<!-- 차트셀렉트 -->
<script>
document.addEventListener('DOMContentLoaded', () => {
  const chartSelectElements = document.querySelectorAll('.chartSelect');
  const totalSalesChart = document.getElementById('totalSalesChart');
  const categorySalesChart = document.getElementById('categorySalesChart');
  const storeSalesChart = document.getElementById('storeSalesChart');

  const showChart = (chartId) => {
    totalSalesChart.style.display = 'none';
    categorySalesChart.style.display = 'none';
    storeSalesChart.style.display = 'none';

    if (chartId === '총매출차트') {
      totalSalesChart.style.display = 'block';
    } else if (chartId === '팀별 매출 점유율 차트') {
      categorySalesChart.style.display = 'block';
    } else if (chartId === '매장 매출차트') {
      storeSalesChart.style.display = 'block';
    }
  };

  chartSelectElements.forEach(selectElement => {
    selectElement.addEventListener('change', (event) => {
      const selectedChart = event.target.value;
      
      // Update all select elements to show the selected chart option
      chartSelectElements.forEach(elem => {
        elem.value = selectedChart;
      });
      
      showChart(selectedChart);
    });
  });

  // 초기화 시 첫 번째 차트를 표시
  showChart(chartSelectElements[0].value);
});

//사이드바 처리
document.addEventListener("DOMContentLoaded", function () {
	
	const element = document.getElementById("salesChart");
	
	document.getElementById("sales").classList.add("open");
	element.style.backgroundColor = "#958CF4";
	element.style.color = "white";
	element.classList.add("active");
	
	
});
</script>
<!-- /차트셀렉트 -->

     
<!-- 여기까지 -->
<!-- 세션정보 끝 ---------------------------------------------------------------------------------------- -->
</div>
<!-- 세션 끝 -->
</div>


<!-- 푸터 시작 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- 푸터 끝 -->

<div class="content-backdrop fade"></div>
<!-- wrapper 닫기 -->
</div>

<!-- nav layout page 닫기 -->
</div>

<!-- layout-container 닫기 -->
</div>
  <!-- Overlay -->
 <div class="layout-overlay layout-menu-toggle"></div>

 <!-- Drag Target Area To SlideIn Menu On Small Screens -->
 <div class="drag-target"></div>


<!-- layout wrapper 닫기 -->
</div> 
</body>
<!-- flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<!-- flatpickr 한글 설정 JS -->
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
</html>