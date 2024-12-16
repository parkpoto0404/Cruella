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
    
    <style>

      .fc-scrollgrid{
        background-color: white;
      }

      .select2-selection__clear{ /* select 태그에 작게 x표시 뜨는거 안보이게 */
        display:none;
      }
      .select2-search__field{ /* select 태그에 option 창에서 검색창 뜨는거 안보이게 */
        display:none;
      }

      .fc-event-title-container{
        color: rgb(45, 45, 45);
      }

         .select2-selection__rendered{
            display:none;
         }
         
      .fc-event-time{
      	display:none;
      }
      
       #calendarAll::before {
        content: ''; /* 가상 요소 필수 */
        display: inline-block; /* 블록 요소 */
        width: 10px; /* 동그라미 크기 */
        height: 10px; /* 동그라미 크기 */
        border-radius: 50%; /* 완전한 원 */
        background-color: transparent; /* 배경을 투명으로 설정 */
        border: 2px solid gray; /* 초기 테두리 색상 */
      }
      #calendarAll.active::before {
        border: 2px solid white; /* 테두리만 흰색으로 변경 */
      }

    </style>


    <!-- 풀캘린더 블로그 참고 popper, tippy 이게 필요하다는데 왜?
    <script src="js/main.js"></script>
    <script src="js/locales-all.min.js"></script>
    <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
    <script src="https://unpkg.com/tippy.js@6"></script> -->






    <!-- fullcalendar-->

    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    <script type="text/javascript">

      

      document.addEventListener('DOMContentLoaded', function() {
      var calendar;  // global(전역) 변수로 calendar 선언
      var calendarEl = document.getElementById('calendar');
        
        // Fullcalendar 옵션 설정 부분
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth', // 로드 될때 캘린더 화면 기본 설정
          selectable: true, // 달력 셀 부분 클릭, 드래그 선택 가능
          aspectRatio: 2.2,
          contentHeight: 850,
          dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
          editable: true, // default | false 이벤트 드래그 등의 편집여부를 설정함
          selectMirror: true, 
          textColor: 'black',
          displayEventTime: false,
          
          
           
         
         
         
          
          
          
          

          // 블로그
          eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
          //console.log(obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
          //console.log(obj);
        },
        
        eventRemove: function(obj){  // 이벤트가 삭제되면 발생하는 이벤트
          //console.log(obj);
        },
        /*
        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다
           
          var title = prompt('일정 입력');
          if (title) {
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay
            })
          }
          calendar.unselect()
        },
        */
          
        // 이벤트 조회
        events: [ 
               <c:forEach var="list" items="${list}"> // List로 불러오는거는 for문으로!
          {
            
            id: '${list.calNo}',
            title: '${list.calTitle}',
            start: '${list.calStartDt}',
            end: '${list.calEndDt}T23:59',
            backgroundColor: '${list.calRgb}', // backgroundColor 추가
            borderColor: 'white', // borderColor를 빈 문자열로 설정
            color: 'black',
            extendedProps:{
            	rgb: '${list.calRgb}',
              category: '${list.calCategory}',
            },
            
            
            <c:if test="${list.calStartDt eq list.calEndDt}">
                allDay: true
              </c:if>
          },
          
          </c:forEach>
        ],
               
        
        
        
        
        
        
        
        
        
        
        
        
              // 이벤트 수정 (드래그로로 일정 이동시 수정하기)
              
              eventDrop: function(info) {
           
            //console.log("콘솔 나와랏: ", info); 
           
           
           
           
            //console.log(info);
            
              if(confirm("'"+ info.event.title + "' 일정을 수정하시겠습니까? ") ){
                 
                var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                var obj = new Object();
                
               // 수정된 날짜를 obj에 추가
            obj.title = info.event._def.title;

            // 시작일과 종료일을 YYYY-MM-DD 형식으로 변환하여 추가
            obj.start = info.event.startStr.split('T')[0];  // 수정된 시작일 (YYYY-MM-DD)
            obj.end = info.event.endStr.split('T')[0] + "T23:00";      // 수정된 종료일 (YYYY-MM-DD)
                
   
                 obj.title = info.event._def.title;
                 //obj.start = info.event._instance.range.start;
                 //obj.end = info.event._instance.range.end;
                 events.push(obj);
                 
                 	//console.log("================================")
                 	//console.log(info.event.end);
                 	//console.log(info.event.endStr);
                  //console.log(info.event.endStr.split('T')[0]);
                  //console.log(info.event.title);
                  //console.log(info.event.backgroundColor);
                  //console.log(info.event._def.extendedProps.category);     
                  //console.log("================================")

                 	$.ajax({
                       url: '${contextPath}/calendar/updateCalendar.do',
                       type: 'GET',
                       data: {
                          
			                      calStartDt: obj.start,  // 수정된 시작 날짜
			                      calEndDt: info.event.end == null ? obj.start : info.event.endStr.split('T')[0],      // 수정된 종료 날짜
			                      calNo: info.event.id,    // 수정하려는 이벤트의 ID
                          	calTitle: info.event.title,
                          	calRgb: info.event.backgroundColor,
                          	calCategory: info.event._def.extendedProps.category,
                          	
                          	
                          //calStartDt: info.event.start.toISOString().split('T')[0],
		                      //calEndDt: info.event.end.toISOString().split('T')[0],
		                      //calNo: info.event.id
                       },
                       success: function(res) {
                          if(res > 0){
                        	  
                             alert('일정이 수정되었습니다.');
                          }else{
                             alert('일정 수정에 실패했습니다. 다시 시도해주세요.');
                          }
                    },
             })
                 
              }else{
                 
              } 
              

          }, // 콤마 필수!!!
          
        // /이벤트 수정 (드래그로 일정 이동시 수정하기)
          
          
          
          
          
					// 이벤트 선택해서 수정, 삭제하기
          
          eventClick: function(info){
        	  
        	 //console.log(info.event.start);
        	 //console.log(info.event.end);
        	  //console.log(info.event.extendedProps);
        	 //console.log(info.event.extendedProps.rgb);
        	  
        	 //console.log(info.event.id);
        	 
        	 
        	   
        	 
        	 
        	 
        	 // 맨아래 script 문에서 만들어둔 전역변수에 값 담기
        	 selectedId = info.event.id;
        	  
        	 
        	  	// 일정명 적어뒀던거 수정 모달창에 뜨게 하기
        	  	var event = info.event;
        	  	var modal = $('#eventclickmodal');
        	  
        	  
        			// 이벤트 클릭시 모달창 뜨게하는 것 
              var eventclickmodal = new bootstrap.Modal(document.getElementById("eventclickmodal"));
        			
        			
        			// 카테고리를 수정 모달에 뜨게 해주기
        			$("#calCategory2").val(event.extendedProps.category);
        			
        			// 일정명을 수정 모달에 뜨게 해주기
        			
        			$("#title2").val(event.title);
        			
        			
        			 			 //console.log("=========================");
                     //console.log(startDate);
                     //console.log(event.startStr);
                     
                     //console.log("==============")
                     
                     //console.log(event.endStr);
                     //console.log(endDate);              
                     //console.log(endDateString);              
                     //console.log("=========================");
        			
        			
        			
        			
               //var startDate = new Date(event.startStr);  // 종료일을 Date 객체로 변환
               //startDate.setDate(startDate.getDate() + 1); // 시작일을 + 1 로 input에 입력되게 해주기

               
               //(1일 일정) 
								if (event.endStr) {
								    // 종료일이 시작일과 같으면 (1일 일정) +1 하지 않음
								    var startDate = new Date(event.startStr);
								    startDate.setDate(startDate.getDate() + 1);  // 그냥 시작일 그대로
								} else {
								    // 종료일이 시작일과 다르면 (2일 이상 일정) +1 한다
								    var startDate = new Date(event.startStr);
								    startDate.setDate(startDate.getDate());  // 시작일에 +1
								}
               
               
               var startDateString = startDate.toISOString().split('T')[0];  // YYYY-MM-DD 형식으로 변환
        			
              // event 로 부터 도출한 날짜 값을 modal 영역 내의 날짜 input 요소에 출력 
              $("#start2").val(startDateString);  // 시작일을 'start' input에 입력 => String 값 반환됨

              
              if( !event.endStr || event.endStr === "" ){
            	   var endDate = new Date(event.startStr);
            	       endDate.setDate(endDate.getDate());
              }else{
            	   // 종료일이 있다면, 이를 Date 객체로 변환
            	   var endDate = new Date(event.endStr);
            	  
              }

              
              //var endDate = new Date(event.endStr);  // 종료일을 Date 객체로 변환
              //endDate.setDate(endDate.getDate()); 
              
              var endDateString = endDate.toISOString().split('T')[0];  // YYYY-MM-DD 형식으로 변환
              $("#end2").val(endDateString);  // 종료일을 'end' input에 입력
                

              
              
              
              
							
              // RGB를 수정 모달에 뜨게 해주기
              //$("#color2").val(event.extendedProps.rbg);

              
              //
              
                	//var selectedValue = $(this).val();
                    const selectedValue = $("#calCategory2").val(event.extendedProps.category); // 해당 일정의 카테고리를 data 속성으로 가져오는 방식 사용
              			console.log(selectedValue);
										
                   	console.log(info.event.extendedProps.rgb);

                	
                	
                	$('#color2').html("");

                    let a = "";
                    if(selectedValue.val() === '전사 일정'){
                      a = '<option value="rgb(250, 201, 255)" class="optionHover" style="background-color: rgb(250, 201, 255); ">전사 일정</option>'
                          $('#color2').html(a);

                    }else if(selectedValue.val() === '팀 일정'){
                      a = '<option value="rgb(190, 255, 200)" class="optionHover" style="background-color: rgb(190, 255, 200);">팀 일정</option>'
                          $('#color2').html(a);

                    }else{ // '개인 일정'

                    	a += '<option value="rgb(253, 191, 191)" class="optionHover" style="background-color: rgb(253, 191, 191); color:transparent;">연빨강</option>';
                        a += '<option value="rgb(255, 201, 165)" class="optionHover" style="background-color: rgb(255, 201, 165); color:transparent;">연주황</option>';
                        a += '<option value="rgb(255, 245, 191)" class="optionHover" style="background-color: rgb(255, 245, 191); color:transparent;">연노랑</option>'; 
                        a += '<option value="rgb(207, 253, 226)" class="optionHover" style="background-color: rgb(207, 253, 226); color:transparent;">연초록</option>';      
                        a += '<option value="rgb(200, 247, 255)" class="optionHover" style="background-color: rgb(202, 240, 247); color:transparent;">연파랑</option>';     
                        a += '<option value="rgb(201, 206, 255)" class="optionHover" style="background-color: rgb(201, 206, 255); color:transparent;">연남색</option>';     
                        a += '<option value="rgb(238, 212, 255)" class="optionHover" style="background-color: rgb(238, 212, 255); color:transparent;">연보라</option>';    
                	
                        
                        $('#color2').html(a);
                    	
                     // info.event.extendedProps.rgb 값과 일치하는 option을 selected로 설정
                        $('.optionHover').each(function() {
                            // 각 option의 value 값을 가져와서 비교
                            if ($(this).val() === info.event.extendedProps.rgb) {
                                // 일치하는 값이 있으면 해당 option을 selected로 설정
                                $(this).prop('selected', true);
                            }
                            
                            
                        });



                    	//$(info.event.extendedProps.rgb);
                    	
                    	
                    	
                      //a += '<option value="rgb(253, 191, 191)" class="optionHover" style="background-color: rgb(253, 191, 191); color:transparent;" selected>연빨강</option>';
                      //a += '<option value="rgb(255, 201, 165)" class="optionHover" style="background-color: rgb(255, 201, 165); color:transparent;">연주황</option>';
                     // a += '<option value="rgb(255, 245, 191)" class="optionHover" style="background-color: rgb(255, 245, 191); color:transparent;">연노랑</option>'; 
                     // a += '<option value="rgb(207, 253, 226)" class="optionHover" style="background-color: rgb(207, 253, 226); color:transparent;">연초록</option>';      
                     // a += '<option value="rgb(200, 247, 255)" class="optionHover" style="background-color: rgb(202, 240, 247); color:transparent;">연파랑</option>';     
                      //a += '<option value="rgb(201, 206, 255)" class="optionHover" style="background-color: rgb(201, 206, 255); color:transparent;">연남색</option>';     
                     // a += '<option value="rgb(238, 212, 255)" class="optionHover" style="background-color: rgb(238, 212, 255); color:transparent;">연보라</option>';    
                    }

                	

              
              
              
              //
              
              
              
              
              
              
              
              
              eventclickmodal.show();
        	  

              
              
              
        	  
          },
          
          
          // /이벤트 선택해서 수정, 삭제하기
          
          
          
 
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          select: function(evt){ // 날짜 셀 클릭시 실행되는 펑션
             
        	  
        	  // 모달 닫기 및 폼 초기화
              
              $("#exampleModal").modal("hide");
        			 $("#calCategory").val("선택");
              $("#title").val("");
              $("#start").val("");
              $("#end").val("");
              $("#color").html("");
        	  
        	  
        	  
        	  
             
            // console.log("==================등록====================");
                 //console.log(evt.start, "||", new Date(evt.start), "||", new Date(evt.start).toISOString().split('T')[0]);
                 //console.log(evt.startStr, "||", new Date(evt.startStr), "||", new Date(evt.startStr).toISOString().split('T')[0]);
                // console.log()
                // console.log("======================================");
             
             
             
            //console.log(evt); // {startStr:'시작날짜', endStr:'끝날짜'} 가 들어있다. 즉, 셀 드래그로 선택시 첫 날짜는 startStr에, 마지막 날짜는 endStr에 담긴다.

            //alert('sss');
            //$('#modify').modal();
            
            // day 클릭시 모달창 뜨게하는 것 -> 모달 만들어서 바꿔줘야 함
            var dayclickmodal = new bootstrap.Modal(document.getElementById("dayclickmodal"));
            // evt로 부터 도출한 날짜 값을 modal 영역 내의 날짜 input 요소에 출력 
            $("#start").val(evt.startStr);  // 시작일을 'start' input에 입력 => String 값 반환됨

            
             // 종료일에서 하루를 빼는 코드 (String -1 int 는 안되기때문에 Date로 형변환 후 처리하고 다시 String으로 만들어서 #end input에 담아야한다)
            var endDate = new Date(evt.endStr);  // 종료일을 Date 객체로 변환
            endDate.setDate(endDate.getDate() -1);  // 하루를 빼기

            var endDateString = endDate.toISOString().split('T')[0];  // YYYY-MM-DD 형식으로 변환
            $("#end").val(endDateString);  // 종료일 -1일을 'end' input에 입력  
						

            dayclickmodal.show();
          }
        
        
        
        
        
        
        });

        
        
        
        // 일정추가하는 모달창 이벤트
        $("#saveChanges").on("click", function () {
           
           
          var eventData = {
            title: $("#title").val(),
            start: $("#start").val(),
            end: $("#end").val() + 'T23:00',
            color: $("#color").val(),
            category: $("#calCategory").val()
          };
          
          console.log(eventData);
          
          //빈값입력시 오류
          if (
            eventData.title == "" ||
            eventData.start == "" ||
            eventData.end == ""		||
            eventData.category == null ||
            eventData.color == null
          ) {
            alert("입력하지 않은 부분이 있습니다.");
            e.preventDefault(); // 모달을 닫지 않도록 방지
            
            
            //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
          } else if ($("#start").val() > $("#end").val()) {
            alert("날짜를 바르게 입력하세요.");
            e.preventDefault(); // 모달을 닫지 않도록 방지

            return; // 모달 창을 닫지 않고 함수 종료
            
            
          } else if($("#start").val() === $("#end").val()){
      	  	eventData.allDay = true; // allDay true속성 추가
            calendar.addEvent(eventData);
            
            
          }else{
              calendar.addEvent(eventData);
              
          }


        
          
       // db에 일정 insert
       
          
          // DB에 일정 추가 AJAX 요청
             $.ajax({
               url: '${contextPath}/calendar/insertCalendar.do',  // 서버 URL
               type: 'POST',
               contentType: 'application/json',  // JSON 형식으로 보내기
               data: 
            	   JSON.stringify({
            		   
            	   
                  calTitle: $('#title').val(),  // jQuery를 사용하여 실제 값 가져오기
                  calStartDt: $('#start').val(),
                  calEndDt: $('#end').val(),
                  calCategory: $('#calCategory').val(),  // 선택된 카테고리 값을 가져오기
                  calRgb: $('#color').val(),  // 선택된 색상을 가져오기
                  memNo: $('#memNo_result').val()
                  
            	   }),
               success: function(res) {
            	   if (res > 0) {  // 성공적으로 일정이 추가되었을 때
            	        alert('일정이 추가되었습니다.');
            	        $('#dayclickmodal').modal('hide');  // 모달 닫기
            	      } else {
            	        alert('일정 추가에 실패했습니다. 다시 시도해주세요.');
            	      }
            	   
            	   /*
                 if (res > 0) {  // 성공적으로 일정이 추가되었을 때
                   alert('일정이 추가되었습니다.');
                   $('#dayclickmodal').modal('hide');  // 모달 닫기

                 } else {
                   alert('일정 추가에 실패했습니다. 다시 시도해주세요.');
                 }
                 */
                 
                 
               },
              
             });

             // 모달 닫기 및 폼 초기화
                                
                    $("#exampleModal").modal("hide");  // 모달 닫기 (성공적인 경우에만 호출)
									  $("#calCategory").val("선택");
									  $("#title").val("");
									  $("#start").val("");
									  $("#end").val("");
									  $("#color").val("");
           
             
             
             // /db에 일정 insert
             
        
             
             
                   
            
            
          });

        calendar.render();

      });

    </script>




		
















              <!-- fullcalendar cdn 프로그램 -->

              <script src="
              https://cdn.jsdelivr.net/npm/fullcalendar@5.11.5/main.min.js
              "></script>
              <link href="
              https://cdn.jsdelivr.net/npm/fullcalendar@5.11.5/main.min.css
              " rel="stylesheet">
    
    
    
    
    
  
    
    
    
    
    
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


   <div class="content-wrapper" style="height: 1100px;">
   <!-- 세션 시작 -->
    <div class="container-xxl flex-grow-1 container-p-y" style="display:flex; flex-direction: column; ">
     <!-- 이쪽에 세션정보 넣어야합니다 -->
              
                    <!-- Filter -->
                  <div class="middle-all" style="padding-top: 30px; width:200px; height:50px; display:flex; flex-direction: column;">   

                      <div class="form-check form-check-secondary mb-5 ms-2" style="display:flex; flex-direction: row; width: 500px; height: 20px;">
                        <input
                          class="form-check-input select-all"
                          type="checkbox"
                          id="selectAll"
                          data-value="all"
                          value="all"
                          name="filter"
                          checked />
                        <label class="form-check-label" for="selectAll" style=" width:50px;">전체</label>



                        <div class="app-calendar-events-filter text-heading" style="display:flex; flex-direction: row;">
                          <div class="form-check form-check-secondary mb-5 ms-2">
                            <input
                              class="form-check-input input-filter"
                              type="checkbox"
                              id="select_company"
                              data-value="personal"
                              value="company"
                              name="filter"
                              checked />
                            <label class="form-check-label" for="select_company" style=" width:70px;">전사 일정</label>
                          </div>
                          <div class="form-check form-check-secondary mb-5 ms-2">
                            <input
                              class="form-check-input input-filter"
                              type="checkbox"
                              id="select_team"
                              data-value="business"
                              value="team"
                              name="filter"
                              checked />
                            <label class="form-check-label" for="select-team" style=" width:50px;">팀 일정</label>
                          </div>
                          <div class="form-check form-check-secondary mb-5 ms-2">
                            <input
                              class="form-check-input input-filter"
                              type="checkbox"
                              id="select_personal"
                              data-value="family"
                              value="personal"
                              name="filter"
                              checked />
                            <label class="form-check-label" for="select-personal" style=" width:80px;">개인 일정</label>
                          </div>
                          
                        </div>
                      </div>
                    



                  </div>

                   



                  


                <!-- fullcalendar -->
                <div id='calendar' style="padding-top:10px;"></div>
                
                
    
    
    
    
    <!-- day 클릭시 모달 -->
    <div class="modal fade" id="dayclickmodal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered1 modal-simple modal-add-new-cc">
        <div class="modal-content" style="height: 620px;">
          <div class="modal-body">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            <div class="text-center mb-6">
              <h4 class="mb-2">일정 추가</h4>
            </div>

              
              <div class="col-12 text-center" style="height:160px;">

                <label for="calCategory" style="float:left;">일정 종류</label>
                  <select
                    id="calCategory"
                    name="calCategory"
                    class="select2 form-select"
                    data-allow-clear="true" >
                    <option class="optionHover" value="선택" disabled selected style="display: none;">선택</option>
                    <option class="optionHover" value="전사 일정" class="optionHover">전사 일정</option>
                    <option class="optionHover" value="팀 일정" class="optionHover">팀 일정</option>
                    <option class="optionHover" value="개인 일정" class="optionHover">개인 일정</option>
                  </select>
                
                <label for="title" style="float:left; margin-top: 20px;">일정명</label>
                  <input type="hidden" value="${loginUser.memNo }" id="memNo_result" />
                  <input
                    id="title"
                    name="title"
                    class="form-control credit-card-mask"
                    type="text"
                    aria-describedby="title2"
                    style="margin-bottom:20px;" />
                <label for="start" style="float:left;">시작일</label>
                  <input
                    id="start"
                    name="start"
                    class="form-control credit-card-mask"
                    type="date"
                    aria-describedby="title2"
                    style="margin-bottom:20px;" />
                <label for="end" style="float:left;">종료일</label>
                  <input
                    id="end"
                    name="end"
                    class="form-control credit-card-mask"
                    type="date"
                    aria-describedby="title2"
                    style="margin-bottom:20px;" />
    


                    
                  

                  <label for="color" style="float:left;">배경색</label>


                  <select
                    id="color"
                    name="color"
                    class="select2 form-select"
                    data-allow-clear="true">
                    
                    <option value="rgb(250, 201, 255)" class="companyCal" style="background-color: rgb(250, 201, 255);" selected>전사 일정</option>

                    <option value="rgb(190, 255, 200)" class="teamCal" style="background-color: rgb(190, 255, 200);" selected>팀 일정</option>

                    <option class="personalCal" value="선택" disabled selected style="display: none;">선택</option>
                    <option value="rgb(253, 191, 191)" class="personalCal" style="background-color: rgb(253, 191, 191); color:transparent;">연빨강</option>
                    <option value="rgb(255, 201, 165)" class="personalCal" style="background-color: rgb(255, 201, 165); color:transparent;">연주황</option>
                    <option value="rgb(255, 245, 191)" class="personalCal" style="background-color: rgb(255, 245, 191); color:transparent;">연노랑</option>
                    <option value="rgb(207, 253, 226)" class="personalCal" style="background-color: rgb(207, 253, 226); color:transparent;">연초록</option>
                    <option value="rgb(200, 247, 255)" class="personalCal" style="background-color: rgb(202, 240, 247); color:transparent;">연파랑</option>
                    <option value="rgb(201, 206, 255)" class="personalCal" style="background-color: rgb(201, 206, 255); color:transparent;">연남색</option>
                    <option value="rgb(238, 212, 255)" class="personalCal" style="background-color: rgb(238, 212, 255); color:transparent;">연보라</option>
                  </select>




                <button type="submit" class="btn btn-primary me-3" style="margin-top:30px;" id="saveChanges" data-bs-dismiss="modal">일정 추가</button>
                <button
                  type="reset"
                  class="btn btn-label-secondary btn-reset"
                  data-bs-dismiss="modal"
                  aria-label="Close" 
                  style="margin-top:30px;">
                  취소
                </button>
              </div>
              </div>
          </div>
        </div>
      </div>
    </div>
    <!-- /day 클릭시 모달 -->
    
    

    
    
    
    <!-- 이벤트 클릭시 모달 -->
    <div class="modal fade" id="eventclickmodal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered1 modal-simple modal-add-new-cc">
        <div class="modal-content" style="height: 620px;">
          <div class="modal-body">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            <div class="text-center mb-6">
              <h4 class="mb-2">일정 수정</h4>
            </div>

              
              <div class="col-12 text-center" style="height:160px;">

                <label for="calCategory" style="float:left;">일정 종류</label>
                  <select
                    id="calCategory2"
                    name="calCategory2"
                    class="select2 form-select"
                    data-allow-clear="true" >
                    <option class="optionHover" value="선택" disabled selected style="display: none;">선택</option>
                    <option class="optionHover" value="전사 일정" class="optionHover">전사 일정</option>
                    <option class="optionHover" value="팀 일정" class="optionHover">팀 일정</option>
                    <option class="optionHover" value="개인 일정" class="optionHover">개인 일정</option>
                  </select>
                
                <label for="title" style="float:left; margin-top: 20px;">일정명</label>
                  <input
                    id="title2"
                    name="title"
                    class="form-control credit-card-mask"
                    type="text"
                    aria-describedby="title2"
                    style="margin-bottom:20px;" />
                <label for="start" style="float:left;">시작일</label>
                  <input
                    id="start2"
                    name="start"
                    class="form-control credit-card-mask"
                    type="date"
                    aria-describedby="title2"
                    style="margin-bottom:20px;" />
                <label for="end" style="float:left;">종료일</label>
                  <input
                    id="end2"
                    name="end"
                    class="form-control credit-card-mask"
                    type="date"
                    aria-describedby="title2"
                    style="margin-bottom:20px;" />
    


                    
                  

                  <label for="color" style="float:left;">배경색</label>


                  <select
                    id="color2"
                    name="color"
                    class="select2 form-select"
                    data-allow-clear="true">
                    
                    <option value="rgb(250, 201, 255)" class="companyCal" style="background-color: rgb(250, 201, 255);" selected>전사 일정</option>

                    <option value="rgb(190, 255, 200)" class="teamCal" style="background-color: rgb(190, 255, 200);" selected>팀 일정</option>

                    <option class="personalCal" value="선택" disabled selected style="display: none;">선택</option>
                    <option value="rgb(253, 191, 191)" class="personalCal" style="background-color: rgb(253, 191, 191); color:transparent;">연빨강</option>
                    <option value="rgb(255, 201, 165)" class="personalCal" style="background-color: rgb(255, 201, 165); color:transparent;">연주황</option>
                    <option value="rgb(255, 245, 191)" class="personalCal" style="background-color: rgb(255, 245, 191); color:transparent;">연노랑</option>
                    <option value="rgb(207, 253, 226)" class="personalCal" style="background-color: rgb(207, 253, 226); color:transparent;">연초록</option>
                    <option value="rgb(200, 247, 255)" class="personalCal" style="background-color: rgb(202, 240, 247); color:transparent;">연파랑</option>
                    <option value="rgb(201, 206, 255)" class="personalCal" style="background-color: rgb(201, 206, 255); color:transparent;">연남색</option>
                    <option value="rgb(238, 212, 255)" class="personalCal" style="background-color: rgb(238, 212, 255); color:transparent;">연보라</option>
                  </select>




                <button type="submit" class="btn btn-primary me-3" style="margin-top:30px;" id="saveUpdates" data-bs-dismiss="modal">일정 수정</button>
                <button
                	id="deleteBtn"
                  type="button"
                  class="btn btn-label-secondary btn-reset"
                  data-bs-dismiss="modal"
                  aria-label="Delete" 
                  style="margin-top:30px;">
                  삭제
                </button>
              </div>
              </div>
          </div>
        </div>
      </div>
    <!-- /이벤트 클릭시 모달 -->
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    </div>
   <!-- 세션 끝 -->



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
   
   
   
   
   
<script>
  // 상단 필터링 체크박스 스크립트
  // 전체 체크박스가 변경될 때
  document.getElementById('selectAll').addEventListener('change', function() {
    const isChecked = this.checked;

    // 개별 체크박스를 모두 선택하거나 해제
    const checkboxes = document.querySelectorAll('.input-filter');
    checkboxes.forEach(function(checkbox) {
      checkbox.checked = isChecked;
    });
  });

  // 개별 체크박스가 변경될 때
  const checkboxes = document.querySelectorAll('.input-filter');
  checkboxes.forEach(function(checkbox) {
    checkbox.addEventListener('change', function() {
      // 하나라도 체크박스가 해제되면 전체 체크박스를 해제
      const allChecked = Array.from(checkboxes).every(function(checkbox) {
        return checkbox.checked;
      });

      // 전체 체크박스를 업데이트
      if (allChecked) {
        // 모든 체크박스가 체크되었으면 전체 체크박스도 체크
        document.getElementById('selectAll').checked = true;
      } else {
        // 하나라도 체크박스가 해제되면 전체 체크박스를 해제
        document.getElementById('selectAll').checked = false;
      }
    });
  });
</script>


   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   <script>
   
   
   // 삭제 버튼 클릭시 삭제
   
                   $('#deleteBtn').on('click', function(){
                	   
                	   if(confirm("일정을 삭제하시겠습니까?") ){

                 		 
                 			  $.ajax({
                 				  url: '${contextPath}/calendar/deleteCalendar.do',
                 				  type: 'GET',
                 				  data: {
                 						 calNo: selectedId
                 				  },
                 				  success: function(res) {
                 	       				 if(res > 0){
                 	       					location.reload();
                 	       					 alert('일정이 삭제되었습니다.');

                 	       				 }else{
                 	       					 alert('일정 삭제에 실패했습니다. 다시 시도해주세요.');
                 	       				 }
                        			 },
                 			  })
                 		  
                 	  }
                	   
                	   
                	   
                	   
                	   
                	   
                	   
                   })
   
   
   
   
   // /삭제 버튼 클릭시 삭제
   
   
   
   
   
   
   
   
   
   
      
						// 일정 추가시 카테고리 선택에 따른 배경색 설정하는 스크립트문
      
            $(document).ready(function() {
                // #calCategory select에서 change 이벤트 발생 시
                $('#calCategory').change(function() {
                    // id="calCategory"에 들어있는 value 값 가져오기 ( val 은 jquery문 )
                    const selectedValue = $(this).val();

                    $('#color').html("");

                    let a = "";
                    if(selectedValue === '전사 일정'){
                      a = '<option value="rgb(250, 201, 255)" class="optionHover" style="background-color: rgb(250, 201, 255);">전사 일정</option>'
                    }else if(selectedValue === '팀 일정'){
                      a = '<option value="rgb(190, 255, 200)" class="optionHover" style="background-color: rgb(190, 255, 200);">팀 일정</option>'
                    }else{ // '개인 일정'
                      a += '<option value="rgb(253, 191, 191)" class="optionHover" style="background-color: rgb(253, 191, 191); color:transparent;" selected>연빨강</option>';
                      a += '<option value="rgb(255, 201, 165)" class="optionHover" style="background-color: rgb(255, 201, 165); color:transparent;">연주황</option>';
                      a += '<option value="rgb(255, 245, 191)" class="optionHover" style="background-color: rgb(255, 245, 191); color:transparent;">연노랑</option>'; 
                      a += '<option value="rgb(207, 253, 226)" class="optionHover" style="background-color: rgb(207, 253, 226); color:transparent;">연초록</option>';      
                      a += '<option value="rgb(200, 247, 255)" class="optionHover" style="background-color: rgb(202, 240, 247); color:transparent;">연파랑</option>';     
                      a += '<option value="rgb(201, 206, 255)" class="optionHover" style="background-color: rgb(201, 206, 255); color:transparent;">연남색</option>';     
                      a += '<option value="rgb(238, 212, 255)" class="optionHover" style="background-color: rgb(238, 212, 255); color:transparent;">연보라</option>';    
                    }

                    $('#color').html(a); // jQuery문으로 innerHTML에 넣는 구문이 .html이다.



                });
                
                
                
                
                // 일정 수정하기 버튼 클릭시 이미 db에 저장된 카테고리에 맞게끔 배경색도 맞춰 나오게 하기인데..
                // 이게 안되네........
                
                
                $('.fc-event-title-container').on('click', function(){
                	
                	console.log($('#calCategory2').val());
                	//var selectedValue = $(this).val();
                    const selectedValue = $(this).data('category'); // 해당 일정의 카테고리를 data 속성으로 가져오는 방식 사용

                	
                	
                	$('#color2').html("");

                    let a = "";
                    if(selectedValue === '전사 일정'){
                      a = '<option value="rgb(228, 157, 235)" class="optionHover" style="background-color: rgb(228, 157, 235); ">전사 일정</option>'
                    }else if(selectedValue === '팀 일정'){
                      a = '<option value="rgb(190, 255, 200)" class="optionHover" style="background-color: rgb(190, 255, 200);">팀 일정</option>'
                    }else{ // '개인 일정'
                      a += '<option value="rgb(253, 191, 191)" class="optionHover" style="background-color: rgb(253, 191, 191); color:transparent;" selected>연빨강</option>';
                      a += '<option value="rgb(255, 201, 165)" class="optionHover" style="background-color: rgb(255, 201, 165); color:transparent;">연주황</option>';
                      a += '<option value="rgb(255, 245, 191)" class="optionHover" style="background-color: rgb(255, 245, 191); color:transparent;">연노랑</option>'; 
                      a += '<option value="rgb(207, 253, 226)" class="optionHover" style="background-color: rgb(207, 253, 226); color:transparent;">연초록</option>';      
                      a += '<option value="rgb(200, 247, 255)" class="optionHover" style="background-color: rgb(202, 240, 247); color:transparent;">연파랑</option>';     
                      a += '<option value="rgb(201, 206, 255)" class="optionHover" style="background-color: rgb(201, 206, 255); color:transparent;">연남색</option>';     
                      a += '<option value="rgb(238, 212, 255)" class="optionHover" style="background-color: rgb(238, 212, 255); color:transparent;">연보라</option>';    
                    }

                    $('#color2').html(a);
                	
                	
                	
                })
                
                
                
                // 일정 수정시 카테고리 선택에 따른 배경색 바꾸기
                
                 $('#calCategory2').on('click', function(){
                    // id="calCategory2"에 들어있는 value 값 가져오기 ( val 은 jquery문 )
                    const selectedValue = $(this).val();

                    //console.log(selectedValue);
                    
                    
                    
                    $('#color2').html("");

                    let a = "";
                    if(selectedValue === '전사 일정'){
                      a = '<option value="rgb(250, 201, 255)" class="optionHover" style="background-color: rgb(250, 201, 255);">전사 일정</option>'
                    }else if(selectedValue === '팀 일정'){
                      a = '<option value="rgb(190, 255, 200)" class="optionHover" style="background-color: rgb(190, 255, 200);">팀 일정</option>'
                    }else{ // '개인 일정'
                      a += '<option value="rgb(253, 191, 191)" class="optionHover" style="background-color: rgb(253, 191, 191); color:transparent;" selected>연빨강</option>';
                      a += '<option value="rgb(255, 201, 165)" class="optionHover" style="background-color: rgb(255, 201, 165); color:transparent;">연주황</option>';
                      a += '<option value="rgb(255, 245, 191)" class="optionHover" style="background-color: rgb(255, 245, 191); color:transparent;">연노랑</option>'; 
                      a += '<option value="rgb(207, 253, 226)" class="optionHover" style="background-color: rgb(207, 253, 226); color:transparent;">연초록</option>';      
                      a += '<option value="rgb(200, 247, 255)" class="optionHover" style="background-color: rgb(202, 240, 247); color:transparent;">연파랑</option>';     
                      a += '<option value="rgb(201, 206, 255)" class="optionHover" style="background-color: rgb(201, 206, 255); color:transparent;">연남색</option>';     
                      a += '<option value="rgb(238, 212, 255)" class="optionHover" style="background-color: rgb(238, 212, 255); color:transparent;">연보라</option>';    
                    }

                    $('#color2').html(a); // jQuery문으로 innerHTML에 넣는 구문이 .html이다.



                });
                
                
                
                
                
                
                
                
            });




    </script>
    
    
    
    <script>
    
    var selectedId = 0;
    
// 이벤트 수정 버튼 클릭시 db에 update 되게 하는 기능
    
    $("#saveUpdates").on("click", function(){
    	
    	
    	
    	// 시작 날짜가 종료날짜보다 크면 alert 뜨게하기
        
        var eventData = {
                title: $("#title2").val(),
                start: $("#start2").val(),
                end: $("#end2").val() + 'T23:00',
                color: $("#color2").val(),
                category: $("#calCategory2").val()
              };
              
              console.log(eventData);
              
              //빈값입력시 오류
              if (
                eventData.title == "" ||
                eventData.start == "" ||
                eventData.end == ""		||
                eventData.category == null ||
                eventData.color == null
              ) {
                alert("입력하지 않은 부분이 있습니다.");
                e.preventDefault(); // 모달을 닫지 않도록 방지
                
                
                //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
              } else if ($("#start2").val() > $("#end2").val()) {
                alert("날짜를 바르게 입력하세요.");
                e.preventDefault(); // 모달을 닫지 않도록 방지

                return; // 모달 창을 닫지 않고 함수 종료
                
                
              } else if($("#start2").val() === $("#end2").val()){
          	  	eventData.allDay = true; // allDay true속성 추가
                
              }
        
        //
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	if(confirm("일정을 수정하시겠습니까? ") ){
    		
    		var start = $("#start2").val();

    		var end = $("#end2").val();
    		
    		var category = $("#calCategory2").val();
    		
    		var rgb = $("#color2").val();
    		
    		var title = $("#title2").val();
    		
    		//console.log(start);
    		//console.log(end);
    		//console.log(selectedId);
    		//console.log(rgb);
    		
         	$.ajax({
               url: '${contextPath}/calendar/updateCalendar.do',
               type: 'GET',
               data: {
                  
	                      calStartDt: start,  // 수정된 시작 날짜
	                      calEndDt: end == null ? start : end.split('T')[0],      // 수정된 종료 날짜
	                      calNo: selectedId,    // 수정하려는 이벤트의 ID
                  			calTitle: title,
                  			calCategory: category,
                  			calRgb: rgb
               },
               success: function(res) {
                  if(res > 0){
      							 location.reload();
                     alert('일정이 수정되었습니다.');
                     
                  }else{
                     alert('일정 수정에 실패했습니다. 다시 시도해주세요.');
                  }
            },
     })
	}else{
		
	}
    	
    	
    	
    	
    })
    
    
    
    </script>
    
    
    
    
    
    <script>

    
    //console.log('${list}');
    
    
		 
    
    $('input[name="filter"]').change(function() {
    	
    		//alert("잘 되나?");
    	
   			//console.log($('input[name="filter"]:checked'));
    			//console.log($('input[id="select_company"]').is(":checked"));
   			//console.log($("#select_company").val());
   			
   			$.ajax({
				  url: '${contextPath}/calendar/calendar2.do',
				  type: 'GET',
				  data: {
						 company: $('input[id="select_company"]').is(":checked") ? "T" : "F",
						 team: $('input[id="select_team"]').is(":checked") ? "T" : "F",
						 personal: $('input[id="select_personal"]').is(":checked") ? "T" : "F"
								 
								 
				  },
				  success: function(res) {
	       				 
	       					 console.log(res);
	       					 
	       				
	       					 let ttt = [];
	       					 for(let i = 0; i < res.length; i++){
	       						 let obj={
	       									  	id: res[i].calNo,
	       					            title: res[i].calTitle,
	       					            start: res[i].calStartDt,
	       					            end: res[i].calEndDt + "T23:59",
	       					            backgroundColor: res[i].calRgb, // backgroundColor 추가
	       					            borderColor: 'white', // borderColor를 빈 문자열로 설정
	       					            extendedProps:{
	       					            	rgb: res[i].calRgb,
	       					              category: res[i].calCategory,
	       					            },
	       					            
	       					         		allDay: res[i].calStartDt === res[i].calEndDt ? true : false

	       						};
	       					    ttt.push(obj);
	       					  }

	       					 var calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
	       					    events: ttt
	       					  });
	       					 
	       					 
	       					 
	       			        calendar.render();


	       				    
	       				    
	       				    
      			 },
			  })
   			
   			
   		
   			
    });
    
    
    
    
    
    
    
    
    
    
 // 사이드바 처리
	document.addEventListener("DOMContentLoaded", function () {
  	
		const element = document.getElementById("calendarAll");
		
  	document.getElementById("schedule").classList.add("open");
  	element.style.backgroundColor = "#958CF4";
  	element.style.color = "white";
  	element.classList.add("active");
  	
  	
	});
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    </script>
    
   
   
   
</body>
</html>