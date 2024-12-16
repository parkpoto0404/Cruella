<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en"
	class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
	dir="ltr" data-theme="theme-default"
	data-assets-path="${ contextPath }/assets/" data-template="views"
	data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ contextPath }/resources/assets/js/config.js"></script>
</head>
<body>
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">


			<!-- 헤더 시작 -->
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
			<!-- 헤더 끝 -->

			<div class="layout-page">

				<!-- nav 시작 -->
				<jsp:include page="/WEB-INF/views/common/nav.jsp" />
				<!-- nav 끗 -->


				<div class="content-wrapper">
					<!-- 세션 시작 -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<!-- 이쪽에 세션정보 넣어야합니다 -->


						<div class="row">
							<div class="col-md-12">
								<div class="nav-align-top">
									<ul
										class="nav nav-pills flex-column flex-sm-row mb-6 gap-2 gap-lg-0">

										<li class="nav-item"><a class="nav-link" href="#"> <i
												class="ti-sm ti ti-user-check me-1_5"></i> 직원등록</a></li>

										<li class="nav-item"><a class="nav-link" href="#"><i
												class="ti-sm ti ti-users me-1_5"></i> 직원조회 </a></li>

										<li class="nav-item"><a class="nav-link" href="#"><i
												class="ti-sm ti ti-users me-1_5"></i> 출근기록조회 </a></li>

										<li class="nav-item"><a class="nav-link" href="#"><i
												class="ti-sm ti ti-users me-1_5"></i> 근무시간조회 </a></li>

										<li class="nav-item"><a class="nav-link" href="#"><i
												class="ti-sm ti ti-users me-1_5"></i> 급여지급 </a></li>

										<li class="nav-item"><a class="nav-link" href="#"><i
												class="ti-sm ti ti-money me-1_5"></i> 급여내역확인 </a></li>

										<li class="nav-item"><a class="nav-link active" href="#"><i
												class="ti-sm ti ti-users me-1_5"></i> 조직도 </a></li>

									</ul>
								</div>
							</div>
						</div>
						<!--세션시작-->

						<div style="display: flex;">
							<!-- 조직도 박스 -->
							<div class="card"
								style="width: 30%; height: 600px; margin-right: 20px;">
								<!-- 제목 영역 -->
								<div
									style="padding: 10px; font-size: 18px; font-weight: bold; border-bottom: 1px solid lightgray;">
									조직도</div>
								<!-- 본문 영역 -->
								<div style="padding: 10px; margin-top: 10px; margin-left: 10px;">
									<h5 style="margin-top: 0; font-size: 16px;">신세계 백화점 크루엘라점</h5>
									<div id="jstree-basic">
										<ul>
											<li data-jstree='{"icon" : "ti ti-folder"}'>대표이사
												<ul>
													<li data-jstree='{"icon" : "ti ti-folder"}'>점장</li>
													<li data-jstree='{"icon" : "ti ti-folder"}'>부점장
														<ul>
															<li data-jstree='{"icon" : "ti ti-folder"}'>인사팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>영업총괄팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>지원팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>남성의류팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>여성의류팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>식품팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>스포츠팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>가전/디지털팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>뷰티팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>명품팀</li>
															<li data-jstree='{"icon" : "ti ti-folder"}'>문화센터팀</li>

														</ul>
													</li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
							</div>

							<!-- 사원 목록 박스 -->
							<div class="card"
								style="width: 30%; height: 600px; margin-right: 20px;">
								<!-- 상단 제목 영역 -->
								<div
									style="padding: 10px; font-size: 18px; font-weight: bold; border-bottom: 1px solid lightgray;">
									사원 목록</div>
								<!-- 본문 내용 영역 -->
								<div id="employeeList" style="padding: 10px; margin-top: 10px; margin-left: 10px;">
									직원 리스트</div>
							</div>

							<!-- 사원 정보 박스 -->
							<div class="card" style="width: 30%; height: 600px;">
								<!-- 상단 제목 영역 -->
								<div
									style="padding: 10px; font-size: 18px; font-weight: bold; border-bottom: 1px solid lightgray;">
									사원 정보</div>
								<!-- 본문 내용 영역 -->
								<div id="employeeInfo" style="padding: 10px; margin-top: 10px; margin-left: 10px;">
									사원 정보 사번 이름 직급 이메일</div>
							</div>
						</div>



					</div>
					<!-- 세션 끝 -->



					<!-- 푸터 시작 -->
					<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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
    $(document).ready(function() {
        $('#jstree-basic').jstree({
            'core': {
                'data': [
                    {
                        "text": "대표이사",
                        "children": [
                            { "text": "점장" },
                            { 
                                "text": "부점장",
                                "children": [
                                    { "text": "인사팀" },
                                    { "text": "영업총괄팀" },
                                    { "text": "지원팀" },
                                    { "text": "남성의류팀" },
                                    { "text": "여성의류팀" },
                                    { "text": "식품팀" },
                                    { "text": "스포츠팀" },
                                    { "text": "가전/디지털팀" },
                                    { "text": "뷰티팀" },
                                    { "text": "명품팀" },
                                    { "text": "문화센터팀" }

                                ]
                            }
                        ]
                    }
                ]
            }
        });
    });
</script>

<script>
    $(document).ready(function () {
        // 조직도 트리 초기화
        $.ajax({
            url: "${contextPath}/member/departments.do", // 부서 데이터를 가져오는 URL
            type: "GET",
            success: function (departments) {
                // JSTree를 초기화
                const treeData = departments.map((dept) => ({
                    id: dept.deptCode, // 부서 코드
                    text: dept.deptName, // 부서 이름
                    icon: "ti ti-folder", // 아이콘 설정
                }));

                $("#jstree-basic").jstree({
                    core: {
                        data: [
                            {
                                text: "신세계 백화점 크루엘라점", // 최상위 노드
                                children: treeData, // 부서 데이터 삽입
                            },
                        ],
                    },
                });
            },
            error: function () {
                alert("부서 데이터를 불러오는 데 실패했습니다.");
            },
        });

        // 부서 클릭 시 사원 목록 가져오기
        $("#jstree-basic").on("select_node.jstree", function (e, data) {
            const deptCode = data.node.id; // 선택한 부서의 ID (부서 코드)

            // 사원 목록 가져오기
            $.ajax({
                url: "${contextPath}/member/employees.do",
                type: "GET",
                data: { deptCode: deptCode },
                success: function (employees) {
                    // 사원 목록을 화면에 출력
                    const employeeList = employees
                        .map((emp) => `<li>${emp.empName}</li>`)
                        .join("");

                    $("#employeeList").html(`<ul>${employeeList}</ul>`);
                },
                error: function () {
                    alert("사원 목록을 불러오는 데 실패했습니다.");
                },
            });
        });
    });
</script>



</body>
</html>