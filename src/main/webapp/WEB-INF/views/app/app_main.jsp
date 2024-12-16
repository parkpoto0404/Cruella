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
	#app_active::before {
	  content: ''; /* 가상 요소 필수 */
	  display: inline-block; /* 블록 요소 */
	  width: 10px; /* 동그라미 크기 */
	  height: 10px; /* 동그라미 크기 */
	  border-radius: 50%; /* 완전한 원 */
	  background-color: transparent; /* 배경을 투명으로 설정 */
	  border: 2px solid gray; /* 초기 테두리 색상 */
	}
	#app_active.active::before {
	  border: 2px solid white; /* 테두리만 흰색으로 변경 */
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


        <!-- Session Start -->
        <div class="content-wrapper" style="height: 1500px;">
          <div class="container-xxl flex-grow-1 container-p-y">

            <h2>결재 작성</h2>

            <style>
              .app_buttons {
                margin-left: 15px;
              }
            </style>

            <div style="display: flex;" class="app_buttons">



              <a type="button">
                <span class="ti ti-edit"></span>
                <span class="">결재요청</span>
              </a>

              <a type="button" data-bs-toggle="modal" class="app_buttons">
                <span class="ti ti-checkbox"></span>
                <span>결재정보</span>
              </a>

              <a type="button" data-bs-toggle="modal"  class="app_buttons">
                <span class="ti ti-eye check"></span>
                <span>미리보기</span>
              </a>

              <a type="button" class="app_buttons">
                <span class="ti ti-circle-minus"></span>
                <span>취소</span>
              </a>

            </div>

            <script>
            
            $(document).on('click', '.app_buttons [type="button"]', function() {
              alert('양식을 선택해주세요');
            });
            
           
          </script>



            <div class="modal fade" id="exLargeModal" tabindex="-1" aria-hidden="true" style="display: none;">
              <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                  <div class="modal-header">

                    <div style="width: 100%; padding: 15px;">
                      <h4 class="modal-title" id="exampleModalLabel4">결재정보</h4>
                    </div>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <div class="row">


                      <style>
                        #sign_line_select {
                          display: flex;
                          gap: 40px;
                          list-style-type: none;
                        }


                        #sign_line_select a {
                          text-decoration: none;
                          color: #333;
                          position: relative;
                          padding-bottom: 4px;
                          /* Adds space for the underline effect */
                          transition: color 0.2s ease;
                        }

                        #sign_line_select a::after {
                          content: "";
                          position: absolute;
                          left: 0;
                          right: 0;
                          bottom: 0;
                          height: 2px;
                          background-color: #333;
                          /* Underline color */
                          transform: scaleX(0);
                          transform-origin: center;
                          transition: transform 0.3s ease;
                        }

                        #sign_line_select a:hover {
                          color: #000;
                          /* Slightly darker color on hover */
                        }

                        #sign_line_select a:hover::after {
                          transform: scaleX(1);
                        }
                      </style>

                      <div style="width: 100%; border-bottom: 1px solid #00000036;">
                        <ul id="sign_line_select">
                          <li>
                            <a href="#" id="app_line_result1">결재선</a>
                          </li>
                          <li>
                            <a href="#" id="app_line_result2">참조/열람선</a>
                          </li>
                        </ul>
                      </div>



                      <!-- 결재선 클릭 시 -->
                      <div id="app_line_div1">
                        <div style="display: flex;">
                          <!-- Drag & Drop -->
                          <div class="col-md-6 col-12"
                            style="width: 30%; top: 10px; position: relative; top: 30px; margin-right: 20px;">

                            <div class="card mb-6" style="border:1px solid">
                              <div style="border-bottom: 1px solid #00000036; text-align: center;">
                                <h5 class="card-header">
                                  조직도
                                </h5>
                              </div>

                              <div class="card-body" style="position: relative; bottom: 15px;">

                                <div id="jstree-drag-drop2" class="overflow-auto"
                                  style="border: 1px solid #00000036; padding: 15px; border-radius: 15px; height: 260px;">

                                </div>
                              </div>
                            </div>
                          </div>
                          <!-- /Drag & Drop -->

                          <div
                            style="width: 70%; top: 10px; position: relative; top: 30px; border: 1px solid #0000006b; height: 387px; padding: 0;">



                            <table style="width: 100%; border: 1px solid; text-align-last: center;">
                              <thead>
                                <tr>
                                  <th style="width: 230px;">타입</th>
                                  <th style="width: 70px;">이름</th>
                                  <th style="width: 225px;">부서</th>
                                  <th style="width: 100px;">상태</th>
                                  <th>x</th>
                                </tr>
                              </thead>
                            </table>

                            <div style="background: #d3d3d39c; height: 30px; padding-top: 4px;">
                              <span style="position:relative; left: 15px; ">신청</span>
                            </div>

                            <div style="border: 1px solid; display: flex;">
                              <div
                                style="width:50px; text-align:center; height:40px; border:1px solid #0000003d; padding:8px; background: #e9e7e7;cursor: pointer;">
                                <span style="font-weight: 800;">>></span>
                              </div>

                              <div style="width: 100%; text-align: center; padding-top: 7px;">
                                <table style="width: 100%;">
                                  <thead>
                                    <tr>
                                      <td style="width: 138px;">기안서</td>
                                      <td style="width: 150px;">김영욱</td>
                                      <td style="width: 150px;">영업총괄팀</td>
                                      <td style="padding-left: 42px;"></td>
                                      <td style="width: 153px;"></td>
                                    </tr>
                                  </thead>
                                </table>
                              </div>
                            </div>


                            <div style="background: #d3d3d39c; height: 40px; padding-top: 7px;">
                              <span style="position:relative; left: 15px;">승인</span>
                            </div>

                            <!-- 드래그 했을시 결과 화면 -->
                            <div style="border: 1px solid; display: flex;">
                              <div
                                style="width:50px; text-align:center; height:40px; border:1px solid #0000003d; padding:8px; background: #e9e7e7;cursor: pointer;">
                                <span style="font-weight: 800;">>></span>
                              </div>

                              <div style="width: 100%; text-align: center; padding-top: 7px;">
                                <table style="width: 100%;">
                                  <thead>
                                    <!-- 드래그 후 (결재선 추가 후)-->
                                    <!-- 
                                    <tr>
                                      <td style="width: 138px;">기안서</td>
                                      <td style="width: 150px;">박시우</td>
                                      <td style="width: 150px;">영업총괄팀</td>
                                      <td style="padding-left: 42px;">예정</td>
                                      <td style="width: 153px;">x</td>
                                    </tr> 
                                    -->

                                    <!-- 드래그전 (결재선 추가 전)-->
                                    <tr>
                                      <td><span style="color: #aea9a9;">드래그하여 추가할 수 있습니다.</span></td>
                                    </tr>


                                  </thead>
                                </table>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <!-- /결재선 -->




                      <!-- 참조선 클릭 시 -->
                      <div style="display: none;" id="app_line_div2">
                        <div style="display: flex;">
                          <!-- Drag & Drop -->
                          <div class="col-md-6 col-12"
                            style="width: 30%; top: 10px; position: relative; top: 30px; margin-right: 20px;">

                            <div class="card mb-6" style="border:1px solid">
                              <div style="border-bottom: 1px solid #00000036; text-align: center;">
                                <h5 class="card-header">
                                  조직도
                                </h5>
                              </div>

                              <div class="card-body" style="position: relative; bottom: 15px;">
                                <div id="jstree-drag-drop" class="overflow-auto"
                                  style="border: 1px solid #00000036; padding: 15px; border-radius: 15px; height: 260px;">

                                </div>
                              </div>
                            </div>
                          </div>
                          <!-- /Drag & Drop -->

                          <div
                            style="width: 70%; top: 10px; position: relative; top: 30px; border: 1px solid #0000006b; height: 387px; padding: 0;">



                            <table style="width: 100%; border: 1px solid; text-align-last: center;">
                              <thead>
                                <tr>
                                  <th style="width: 230px;">타입</th>
                                  <th style="width: 70px;">이름</th>
                                  <th style="width: 225px;">부서</th>
                                  <th style="width: 100px;">상태</th>
                                  <th>x</th>
                                </tr>
                              </thead>
                            </table>



                            <!-- 드래그 했을시 결과 화면 -->
                            <div style="border: 1px solid; display: flex;">
                              <div
                                style="width:50px; text-align:center; height:40px; border:1px solid #0000003d; padding:8px; background: #e9e7e7;cursor: pointer;">
                                <span style="font-weight: 800;">>></span>
                              </div>

                              <div style="width: 100%; text-align: center; padding-top: 7px;">
                                <table style="width: 100%;">
                                  <thead>
                                    <!-- 드래그 후 (결재선 추가 후)-->

                                    <tr>
                                      <td style="width: 138px;">기안서</td>
                                      <td style="width: 150px;">박시우</td>
                                      <td style="width: 150px;">영업총괄팀</td>
                                      <td style="padding-left: 42px;">예정</td>
                                      <td style="width: 118px;">x</td>
                                    </tr>


                                  </thead>
                                </table>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <!-- /참조선 -->

                    </div>
                  </div>

                  <div class="modal-footer" style="position: relative; top: 13px;">
                    <button type="button" class="btn btn-label-secondary waves-effect" data-bs-dismiss="modal">
                      취소
                    </button>
                    <button type="button" class="btn btn-primary waves-effect waves-light">
                      확인
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <!-- /모달 -->




            <!-- 양식영역 -->
          
              <div style="width: 100%; height:700px;">


                <div class="col-12" style="margin-top: 20px;">
                  <div class="card mb-6">

                    <div class="card-body" style="height: 100px;">
                      <div class="row">
                        <!-- Basic -->
                        <div class="col-md-6 mb-6">
                          <div class="position-relative" style="display: flex;">


                            <!-- 카테고리 대분류 -->
                            <span id="select_big_type">
                              <select id="select_formType1"
                                class="select form-select form-select-lg select2-hidden-accessible"
                                style="width: 240px;">
                                <option value="선택">선택해주세요.</option>
                                <option value="일반기안">일반기안</option>
                                <option value="인사">인사</option>
                                <option value="공문">공문</option>
                              </select>
                            </span>

                            
                            <!-- 해당 카테고리 소분류 -->
                            <!-- 일반기안 선택시 -->
                            <span id="select_small_type_1" style="display: none;">
                              <select id="select_formType2"
                                class="select form-select form-select-lg select2-hidden-accessible"
                                style="width: 240px;margin-left: 30px;">
                                <option value="선택">선택해주세요.</option>
                                <option value="기안서">
                                  기안서
                                </option>
                                <option value="품의서">
                                  품의서
                                </option>
                              </select>
                            </span>
                            <script>
                            $(document).ready(function() {
                            	
                            	// 일반기안
                                $('#select_formType2').change(function() {
                                    // 선택된 값 가져오기
                                    var selectedValue = $(this).val();
                                    
                                    
                                    
                                    
                                    if (selectedValue === '기안서') {
                                        location.href = '${contextPath}/app/form_draft.do'; 
                                    }else if(selectedValue === '품의서'){
                                    	location.href = '${contextPath}/app/form_robin.do'; 
                                    }
                                });
                                
                                // 인사
                                $('#select_formType3').change(function() {
                                    // 선택된 값 가져오기
                                    var selectedValue = $(this).val();
                                    
                                    
                                    if (selectedValue === '연차') {
                                        location.href = '${contextPath}/app/form_annual.do'; 
                                    }else if(selectedValue === '지각'){
                                    	location.href = '${contextPath}/app/form_per.do'; 
                                    }else if(selectedValue === '증명서'){
                                    	location.href = '${contextPath}/app/form_cer.do'; 
                                    }
                                });
                                
                                // 공문
                                $('#select_formType4').change(function() {
                                    // 선택된 값 가져오기
                                    var selectedValue = $(this).val();
                                    
                                    if (selectedValue === '요청서') {
                                        location.href = '${contextPath}/app/form_request.do'; 
                                    }
                                });
                                
                                
                                
                            });
                            </script>



                            <!-- 인사 선택시 -->
                            <span id="select_small_type_2" style="display: none;">
                              <select id="select_formType3"
                                class="select form-select form-select-lg select2-hidden-accessible"
                                style="width: 240px;margin-left: 30px;">
                                <option value="선택">선택해주세요.</option>
                                <option value="연차">
                                  연차신청서
                                </option>
                                <option value="지각">
                                  지각/불참사유서
                                </option>
                                <option value="증명서">
                                  증명서
                                </option>
                                <!-- <option value="인사발령">
                                  인사발령 요청서
                                </option> -->
                              </select>
                            </span>


                            <!-- 공문 선택시 -->
                            <span id="select_small_type_3" style="display: none;">
                              <select id="select_formType4"
                                class="select form-select form-select-lg select2-hidden-accessible"
                                style="width: 240px;margin-left: 30px;">
                                <option value="선택">선택해주세요.</option>
                                <option value="요청서">
                                  요청서
                                </option>
                              </select>
                            </span>




                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>









          </div>
        </div>
        <!-- /secsion -->

      <!-- </div>
    </div> -->
    <!-- /Layout container -->
 








  <script>
    


    // 미리보기 결재선라인 결과값 대입 함수

      $(document).ready(function () {

        $('#form_type_result_div').html($("#form_type_result").html());
        $('#line_user_result').html($(".line_user").html());




        // 대분류 카테고리 선택시 소분류 카테고리 생성 함수
        $('#select_formType1').change(function(){

          let result = $(this).val(); // 지금 선택한 select 결과값
         
          console.log(result);
  
  
          switch(result){
  
            case'일반기안' : $('#select_small_type_1').css('display','block'); 
                             $('#select_small_type_2').css('display','none'); 
                             $('#select_small_type_3').css('display','none'); break;

            case '인사' : $('#select_small_type_2').css('display','block');
                          $('#select_small_type_1').css('display','none'); 
                          $('#select_small_type_3').css('display','none'); 
                          break;


            case '공문' : $('#select_small_type_3').css('display','block');
                          $('#select_small_type_1').css('display','none'); 
                          $('#select_small_type_2').css('display','none'); break;

            default : $('#select_small_type_3').css('display','none');
                      $('#select_small_type_1').css('display','none'); 
                      $('#select_small_type_2').css('display','none'); break;


          }
        })

        
        
        
        


        


      })
      
      
      
      
      


  </script>
   <script>

    $(document).ready(function () {

      $('#app_line_result2').on('click', function () {

        $('#app_line_div2').css('display', 'block')
        $('#app_line_div1').css('display', 'none')

      })

      $('#app_line_result1').on('click', function () {

        $('#app_line_div1').css('display', 'block')
        $('#app_line_div2').css('display', 'none')

      })


    })
    
    
    
    
     // 사이드바 처리
		document.addEventListener("DOMContentLoaded", function () {
	  	
			const element = document.getElementById("app_active");
			
	  	document.getElementById("app_main_active").classList.add("open");
	  	element.style.backgroundColor = "#958CF4";
	  	element.style.color = "white";
	  	element.classList.add("active");
	  	
	  	
		});


  </script>





  <!-- Session End -->



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
</html>