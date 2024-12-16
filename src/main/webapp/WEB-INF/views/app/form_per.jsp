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
              
              .content-footer{
						   	position: relative;
						    top: 525px;
					   	}
            </style>

            <div style="display: flex;" class="app_buttons">



              
              <a type="button" data-bs-toggle="modal" data-bs-target="#exLargeModal_list" class="app_buttons" style="">
                <span class="ti ti-edit"></span>
                <span>결재요청</span>
              </a>
            

              <a type="button" data-bs-toggle="modal" data-bs-target="#exLargeModal" class="app_buttons" id="treeView_list">
                <span class="ti ti-checkbox"></span>
                <span>결재정보</span>
              </a>

              <a type="button" data-bs-toggle="modal" data-bs-target="#exLargeModal2" class="app_buttons">
                <span class="ti ti-eye check"></span>
                <span>미리보기</span>
              </a>

              <a type="button" class="app_buttons" id="close_btn_a">
                <span class="ti ti-circle-minus"></span>
                <span>취소</span>
              </a>
              
              
              
              <script>
              
              $(document).ready(function(){
            	  
            	  
          	 	$('#move_button').hover(function(){        
          					$(this).css('backgroundColor','skyblue');    
          				},function() {       
          					$(this).css('backgroundColor','#d3d3d39c'); 
          				});
          		 
          		
          		$('#move_button2').hover(function(){        
          					$(this).css('backgroundColor','skyblue');    
          				},function() {       
          					$(this).css('backgroundColor','#d3d3d39c'); 
          				});
          		
          		
          	  })
              
              
              
              
              	$(document).ready(function(){
              		$('#close_btn_a').on('click',function(){
              			location.href="${contextPath}/app/app_main.do";
              		})
              		
              		var today = new Date();
            	    var year = today.getFullYear();
            	    var month = today.getMonth() + 1; // 월은 0부터 시작하므로 +1
            	    var day = today.getDate();
            	    var count = 0;

            	    month = month < 10 ? '0' + month : month;
            	    day = day < 10 ? '0' + day : day;

            	    var formatDate = year + '/' + month + '/' + day;
            	    
            	    
            	    
            	    $('.app_no_result').html(formatDate);
              		
              	})
              </script>






            </div>


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
                                  조직도(결재)
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
                                  <th><i class="ti ti-trash"></i></th>
                                </tr>
                              </thead>
                            </table>

                            <div style="background: #d3d3d39c; height: 30px; padding-top: 4px;">
                              <span style="position:relative; left: 15px; "></span>
                            </div>

                            <div style="border: 1px solid; display: flex;">
                              <div
                                style="width:50px; text-align:center; height:40px; border:1px solid #0000003d; padding:8px; background: #e9e7e7;">
                                <span style="font-weight: 800;">/</span>
                              </div>

                              <div style="width: 100%; text-align: center; padding-top: 7px;">
                                <table style="width: 100%;">
                                  <thead>
                                    <!-- 기안자 정보 조회해서 담기 -->
                                    <tr>
                                      <td style="width: 138px;">기안서</td>
                                      <td style="width: 150px;">김영욱</td>
                                      <td style="width: 150px;">영업총괄팀</td>
                                      <td style="padding-left: 42px;">기안자</td>
                                      <td style="width: 153px;"></td>
                                    </tr>
                                  </thead>
                                </table>
                              </div>
                            </div>


                            <div style="background: #d3d3d39c; height: 40px;">
                              <div id="move_button2"
                                style=" width:50px; text-align:center; height:40px;  border:1px solid #0000003d; padding:8px; background: #e9e7e7;cursor: pointer;">
                                <span style="font-weight: 800;">>></span>


                              </div>
                            </div>

                            <!-- 드래그 했을시 결과 화면 -->
                            <div style="display: flex;">


                              <div style="width: 100%; text-align: center; padding-top: 7px;">
                                <table style="width: 100%;border: 1px solid; position: relative; bottom: 8px;">

                                  <!-- 드래그해서 담을 공간 -->
                                  <thead >
                                    <tbody id="drag_line_div" class="aa">
                                      <!-- 드래그전 (결재선 추가 전)-->
                                      <tr style="height: 50px;">
                                        <td><span style="color: #aea9a9;">드래그하여 추가할 수 있습니다.</span></td>
                                      </tr>
                                    </tbody>


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
                                  조직도(참조)
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
                                  <th style="width: 30px; border: 1px solid;">
                                    <div id="move_button"
                                      style="width:50px; text-align:center; height:40px; padding:8px; background-color: lightgray; cursor: pointer;">
                                      <span style="font-weight: 800;">>></span>
                                    </div>
                                  </th>
                                  <th style="width: 141px;">타입</th>
                                  <th style="width: 135px;">이름</th>
                                  <th style="width: 177px;">부서</th>
                                  <th style="width: 140px;">상태</th>
                                  <th><i class="ti ti-trash"></i></th>
                                </tr>
                              </thead>
                              
                              
                            </table>



                            <!-- 드래그 했을시 결과 화면 -->
                            <div style="border: 1px solid; display: flex;">


                              <div
                                style="width: 100%; text-align: center; padding-top: 0px; overflow-y: auto; max-height: 343px;">
                                <table style="width: 100%;">


                                  <thead>


                                    <!-- 드래그전 (참조선 추가 전)-->
                                  </thead>

                                  <tbody id="drag_line_div2" class="aa2">
                                    <tr style="height: 50px;" class="noref">
                                      <td><span style="color: #aea9a9;">드래그하여 추가할 수 있습니다.</span></td>
                                    </tr>
                                  </tbody>

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
                    <button type="button" class="btn btn-label-secondary waves-effect" data-bs-dismiss="modal" id="app_close_btn">
                      취소
                    </button>
                    <button type="button" class="btn btn-primary waves-effect waves-light" data-bs-dismiss="modal"  id="app_success_btn">
                      확인
                    </button>
                  </div>
                </div>
              </div>
            </div>




            <!-- 양식영역 -->


              <form id="enroll-doc" action="${contextPath}/app/appInsert.do" enctype="multipart/form-data" method="post" style="width: 100%; height:700px;">


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
                            
                            
                          </div>
                        </div>
                      </div>
                    </div>
                    
                    
                    
                    
                    
                    
                       <!-- 결재요청 모달창 -->
                            <span>
                              <div class="modal fade" id="exLargeModal_list" tabindex="-1" aria-hidden="true"
                                style="display: none;">
                                <div class="modal-dialog modal-xl" role="document" style="width: 400px;">
                                  <div class="modal-content">
                                    <div class="modal-header">

                                      <div style="width: 100%; padding: 15px;">
                                        <h4 class="modal-title" id="exampleModalLabel4">결재요청</h4>
                                        <span>
                                          <pre style="position: relative; top: 16px; color:red;">최종요청을 하기 전에 다시 한번 확인바랍니다.</pre>
                                        </span>
                                      </div>

                                      <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                      <div class="row">
                                        
                                        <!-- 결재요청 뷰 -->
                                         <div class="card-body" style="position: relative; bottom: 35px;">

                                          <table>
                                            <tr>
                                              <th style="font-weight: 700;">
                                                <span>결재문서명</span>
                                              </th>
                                              <!-- 문서종류 선택 -->
                                              <td style=" width: 145px; text-align: center; font-weight: 700;">
                                                <span name="">지각/불참 사유서</span>
                                              </td>
                                            </tr>

											<!-- 중요도 선택 -->
                                            <table style="position: relative; top: 40px;">
                                              <tr>
                                                <td style="font-weight: 700;">중요도</td>
                                                <td>
                                                  <span style="margin-left: 30px;">
                                                    <input type="checkbox" value="C" id="C" class="checkBox_result" checked>
                                                    <label for="C" style="font-weight: 700;">일반</label>
                                                  </span>
                                                </td>
                                                <td> 
                                                  <span style="margin-left: 30px;">
                                                    <input type="checkbox" value="E" id="E" class="checkBox_result">
                                                    <label for="E" style="font-weight: 700;">긴급</label>
                                                  </span>
                                                </td>
                                                <td>
                                                  <span style="margin-left: 30px;">
                                                    <input type="checkbox" value="I" id="I" class="checkBox_result">
                                                    <label for="I" style="font-weight: 700;">중요</label>
                                                  </span>
                                                </td>
                                              </tr>
                                            </table>
                                            
                                            <input type="hidden" name="docImpo"  id="info_result_div">

                                            <script>
                                              $(document).ready(function() {
                                                  $('input[type="checkbox"]').on('change', function() {
                                                    
                                                    if ($(this).prop('checked')) {
                                                      $('input[type="checkbox"]').not(this).prop('checked', false);
                                                    }
                                                  });
                                                });
                                            </script>


                                          </table>

                                        </div>



                                      </div>
                                    </div>

                                    <div class="modal-footer" style="position: relative; top: 13px;">
                                      <button type="button" class="btn btn-label-secondary waves-effect"
                                        data-bs-dismiss="modal">
                                        취소
                                      </button>
                                      <button type="button" class="btn btn-primary waves-effect waves-light"
                                      data-bs-dismiss="modal" id="last_app_btn">
                                        확인
                                      </button>
                                    </div>
                                  </div>

                                </div>
                              </div>
                            </span>
                            
                            
                            
                            
                            
                            <!-- /결재요청 모달 -->


                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    <style>
                      * {
                        padding: 0px;
                        margin: 0px;
                        box-sizing: border-box;
                      }

                      .app_type {
                        width: 298px;
                        height: 100px;
                        text-align: center;
                        font-size: 30px;
                        font-weight: 800;
                        border: 1px solid black;
                      }

                      .app_line_div {
                        display: flex;
                        justify-content: right;
                        border: 1px solid black;
                        padding-bottom: 2px;


                      }

                      .line_title {
                        position: relative;
                        writing-mode: vertical-rl;
                        height: 147px;
                        text-align: center;
                        border: 1px solid black;

                      }

                      .line_user {

                        display: flex;
                        flex-direction: column;
                        text-align: center;
                        width: 100px;

                      }

                      .line_user span {
                        border: 1px solid black;
                      }

                      .signLine {
                        height: 102px;
                        display: flex;
                        justify-content: center;
                        align-items: center;

                      }

                      .line_div {
                        width: 600px;
                      }

                      .app_table_container {
                        border-spacing: 0;
                        height: 40px;
                      }

                      .dept_td,
                      .app_date,
                      .app_no,
                      .app_title_td {
                        width: 110px;
                        border: 1px solid black;
                      }

                      .dept_td_result,
                      .app_date_result {
                        width: 188px;
                        border: 1px solid black;
                      }

                      .app_no_result {
                        width: 192px;
                        border: 1px solid black;
                      }

                      .app_result_div {
                        text-align: center;
                      }

                      .app_title {
                        border: 1px solid black;
                      }

                      .sign_date {
                        height: 23px;
                      }
                    </style>



                    <table class="app_table_container">
                      <thead>
                        <tr>
                          <td class="app_type"><span id="form_type_result">지&nbsp;&nbsp;각&nbsp;&nbsp;/&nbsp;&nbsp;불&nbsp;&nbsp;참&nbsp;&nbsp;사유서</span></td>
                          <td class="line_div">
                            <span class="app_line_div">

                              
                              <span class="line_title"><b>결재선</b></span>
                              <span class="line_user">
                                <span>부서명</span>
                                <span class="signLine">서명</span>
                                <span class="sign_date">이름</span>
                              </span>


                            </span>
                          </td>
                        </tr>
                      </thead>
                    </table>

                    <!-- db 조회해서 담기 -->
                    <table class="app_table_container">
                      <tr class="app_result_div">
                        <td class="dept_td">기안부서</td>
                        <td class="dept_td_result">${m.deptName}</td>
                        <td class="app_date">직급</td>
                        <td class="app_date_result">${m.posName}</td>
                        <td class="app_no">기안일</td>
                        <td class="app_no_result"></td>
                        
                        <!-- 타입, 기안자 사번 -->
                        <input type="hidden" name="docType" value="지각사유서">
                        <input type="hidden" name="memNo" value="${m.memNo}">
                        
                      </tr>
                    </table>
                    
                    <script>
                    
                    </script>

                    <table style="border-spacing: 0;">
                      <tr>
                        <td class="app_title_td" style="text-align: center; height: 40px;">기안자</td>
                        <td class="app_title_result" style="width: 788px; border: 1px solid black; ">
                          <span style="position: relative; left: 10px;" id="userNo_value" >${m.memName}</span>
                          <span id="ref_list_div"></span>
                        </td>
                      </tr>
                    </table>



                    <table style="border-spacing: 0;">
                      <tr>
                        <td class="app_title_td" style="text-align: center; height: 40px;">제목</td>
                        <td class="app_title_result" style="width: 788px; border: 1px solid black;">
                          <input type="text" class="form-control" id="defaultFormControlInput" placeholder="제목을 입력하세요."
                            aria-describedby="defaultFormControlHelp" name="docTitle" />
                            
                          <!-- 제목글자수 제한 조건을 걸거나 아니면 리스트 조회시 보이는 글자수 제한 걸기 -->
                        </td>
                      </tr>
                    </table>


                <table>
                  <tr>
                   <td style="border: 1px solid black;width: 169px; text-align: center;">사유</td>
                   <td>
                    <div style="border: 1px solid black;">
                      <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                          <div class="row">

                            <!-- Full Editor -->
                            <div class="col-12">
                              <div class="card">

                                <div class="card-body" >
		
								 <!-- 내용부분  -->
                                  <div id="full-editor" style="height: 500px;" name="docContent">
                                  
                                  
                                    
                                  </div>


                                </div>
                              </div>
                            </div>
                            <!-- /Full Editor -->
                          </div>
                        </div>
                      </div>
                    </div>
                    
                  </td>
                 </tr>
           	   </table>

                    <!-- file input -->
                    <div class="card" style="border: 1px solid; border-radius: 0;">
                      <h5 class="card-header"></h5>
                      <div class="card-body">
                        <div class="mb-4">
                        <!-- 파일 -->
                          <input class="form-control" type="file" id="formFileMultiple" name="uploadFile" multiple />
                           <br>&nbsp; * 각 첨부파일 사이즈는 10MB 이하, 총 100MB 이하여야 됩니다.
                        </div>

                      </div>
                    </div>
                    <!-- /file input -->
					<input type="hidden" name="docContent" id="docContentInput" />




          </div>
        </div>
        <!-- /session -->


        <!-- </div> -->
        <!-- /레이아웃 컨테이너 -->


        <!-- </div> -->


        <!-- </div> -->



        
	<!-- 결재요청 확인버튼 클릭시 발생이벤트 -->
				<script>
				
					$('#last_app_btn').on('click', function() {
						
						
						if($('#defaultFormControlInput').val() == ""){
							alert('제목을 입력해주세요')
							return;
						}else if($('.ql-editor').text() == ""){
							alert('내용을 입력해주세요')
							return;
						}else if($('#drag_line_div span').text() == "드래그하여 추가할 수 있습니다."){
							alert('결재정보에서 결재선을 지정해주세요')
							return;
						}
						
						// 내용 보내기
						var appContent = $('.ql-editor').html(); 
						   $('#docContentInput').val(appContent);
						    
						  // 중요도 체크한 결과값 보내기
						var checkResult = $('.checkBox_result:checked').val();
						$('#info_result_div').val(checkResult);
						
						
						    $("#enroll-doc").submit();
						
					

					})
					
				</script>
        
        

        <script>


          $(document).ready(function () {

        	  
            $('.app_buttons').on('click', function () {


              $('#app_title_result_div').html($('#defaultFormControlInput').val());
              $('#full-editor_result').html($('.ql-editor').html()); // 에디터 내용 담을때 클래스 저걸로!
            })
          })


          

          // 미리보기 결재선라인 결과값 대입 함수
          $(document).ready(function () {

            $('#form_type_result_div').html($("#form_type_result").html());
            $('#line_user_result').html($(".line_user").html());




            // 대분류 카테고리 선택시 소분류 카테고리 생성 함수
            $('#select_formType1').change(function () {

              let result = $(this).val(); // 지금 선택한 select 결과값

              console.log(result);


              switch (result) {

                case '일반기안': $('#select_small_type_1').css('display', 'block');
                  $('#select_small_type_2').css('display', 'none');
                  $('#select_small_type_3').css('display', 'none'); break;

                case '인사': $('#select_small_type_2').css('display', 'block');
                  $('#select_small_type_1').css('display', 'none');
                  $('#select_small_type_3').css('display', 'none'); break;


                case '공문': $('#select_small_type_3').css('display', 'block');
                  $('#select_small_type_1').css('display', 'none');
                  $('#select_small_type_2').css('display', 'none'); break;

                default: $('#select_small_type_3').css('display', 'none');
                  $('#select_small_type_1').css('display', 'none');
                  $('#select_small_type_2').css('display', 'none'); break;


              }
            })



          })



        </script>

        <script>

          // 결재선,참조선 이벤트함수
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


        </script>

		</form> <!-- 최종 form 태그 -->
        <!-- Session End -->





















	<!-- 미리보기 모달 -->
        <div class="modal fade" id="exLargeModal2" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel4">미리보기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">


                <table class="app_table_container" style="width: 100%;">
                  <thead>
                    <tr>

                      <td class="app_type">
                        <span id="form_type_result_div"></span>
                      </td>

                      <td class="line_div">
                        <span class="app_line_div">
                          
                           <!-- db에서 결재선 조회 -->
                              <span class="line_title"><b>결재선</b></span>
                              <span class="line_user">
                                <span>부서명</span>
                                <span class="signLine">서명</span>
                                <span class="sign_date">이름</span>
                              </span>
                        </span>
                      </td>
                    </tr>
                  </thead>
                </table>


                <!-- 신청자 정보 조회 대입 -->
                <table class="app_table_container" style="width: 100%;">
                  <tr class="app_result_div">
                    <td class="dept_td">기안부서</td>
                    <td class="dept_td_result">${m.deptName}</td>
                    <td class="app_date">직급</td>
                    <td class="app_date_result">${m.posName}</td>
                    <td class="app_no">기안일</td>
                    <td class="app_no_result"></td>
                  </tr>
                </table>

                <table style="border-spacing: 0; width: 100%;">
                  <tr>
                    <td class="app_title_td" style="text-align: center; height: 40px;">기안자</td>
                    <td class="app_title_result" style="width: 788px; border: 1px solid black; ">
                      <span style="position: relative; left: 10px;">${m.memName}</span>
                    </td>
                  </tr>
                </table>



                <table style="border-spacing: 0; width: 100%;">
                  <tr>
                    <td class="app_title_td" style="height: 40px; text-align: center;">제목</td>
                    <td class="app_title_result" style="width: 788px; border: 1px solid black;">

                      <!-- 양식 제목 대입 -->
                      <span id="app_title_result_div" style="position: relative; left: 15px;">
                        <!-- 밑에 스크립트로 내용 담음 -->
                      </span>

                    </td>
                  </tr>



                </table>


		 <table style="width:100%;">
           <tr>
              <td style="border: 1px solid black;width: 133px; text-align: center;">사유</td>
              <td>
                <div style="border: 1px solid black;">
                  <div class="content-wrapper">
                    <!-- Content -->

                    <div class="container-xxl flex-grow-1 container-p-y">
                      <div class="row">

                        <!-- Full Editor -->
                        <div class="col-12">
                          <div class="card">

                            <div class="card-body">

                              <div style="height: 500px;">
                                <p id="full-editor_result">
                                  <!-- 밑에 스크립트로 내용 담음 -->
                                </p>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!-- /Full Editor -->
                      </div>
                    </div>
                  </div>
                </div>
                </td>
              </tr>
           </table>
                
                
                
                
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">
                  Close
                </button>

              </div>
            </div>
          </div>
        </div>
        
        
           <script>
     // 사이드바 처리
		document.addEventListener("DOMContentLoaded", function () {
	  	
			const element = document.getElementById("app_active");
			
	  	document.getElementById("app_main_active").classList.add("open");
	  	element.style.backgroundColor = "#958CF4";
	  	element.style.color = "white";
	  	element.classList.add("active");
	  	
	  	
		});
        
        
        </script>
          



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