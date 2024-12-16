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
    <title>급여 내역 확인</title>
    <script src="${ contextPath }/resources/assets/js/config.js"></script>
<style>
		#checksalary::before {
		  content: ''; /* 가상 요소 필수 */
		  display: inline-block; /* 블록 요소 */
		  width: 10px; /* 동그라미 크기 */
		  height: 10px; /* 동그라미 크기 */
		  border-radius: 50%; /* 완전한 원 */
		  background-color: transparent; /* 배경을 투명으로 설정 */
		  border: 2px solid gray; /* 초기 테두리 색상 */
		}
		#checksalary.active::before {
		  border: 2px solid white; /* 테두리만 흰색으로 변경 */
		}
</style>    
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
                <!-- nav 끝 -->

                <div class="content-wrapper">
                    <!-- 세션 시작 -->
                    <div class="container-xxl flex-grow-1 container-p-y">

                        <!-- 페이지 타이틀 -->
                        <h4 class="fw-bold py-3 mb-4">급여 내역 확인</h4>

                        <div class="card" style="padding: 30px;">
                            <div class="d-flex">
                                <h5 class="card-header" style="width: 15%;">급여 확인</h5>
                                <div style="width: 75%; align-items: center; justify-content: right;" class="d-flex"></div>
                            </div>
                            <div class="table-responsive text-nowrap">
                                <table class="table" style="text-align: center;">
                                    <thead>
                                        <tr>
                                            <th rowspan="2">사번</th>
                                            <th rowspan="2">사원명</th>
                                            <th rowspan="2">부서</th>
                                            <th rowspan="2">직급</th>
                                            <th rowspan="2" style="text-align: center;">기본급</th>
                                            <th colspan="4" style="text-align: center;">공제항목</th>
                                            <th rowspan="2">지급예정금액</th>
                                            <th rowspan="2">지급날짜</th>
                                            <th rowspan="2">급여명세표</th>
                                        </tr>
                                        <tr>
                                            <th>국민연금</th>
                                            <th>건강보험</th>
                                            <th>고용보험</th>
                                            <th>장기요양</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty cs}">
                                                <tr>
                                                    <td>${cs.memNo}</td>
                                                    <td>${cs.memName}</td>
                                                    <td>${cs.deptName}</td>
                                                    <td>${cs.posName}</td>
                                                    <td class="salary-field">${cs.salary}원</td>
                                                    <td class="salary-field">${cs.pension}원</td>
                                                    <td class="salary-field">${cs.health}원</td>
                                                    <td class="salary-field">${cs.employment}원</td>
                                                    <td class="salary-field">${cs.care}원</td>
                                                    <td class="salary-field">${cs.totalSalary}원</td>
                                                    <td>${cs.paymentDate}</td>
                                                    <td>
                                                        <form action="${contextPath}/member/paystub.do" method="post" id="submit_btn">
                                                            <input type="hidden" value="${cs.memNo}" name="memNo">
                                                            <i class="pay_icon far fa-file-alt"></i>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:when>

                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="11" style="text-align: center; height: 92px;">
                                                        조회된 결과가 없습니다
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 세션 끝 -->

                    <!-- 푸터 시작 -->
                    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
                    <!-- 푸터 끝 -->

                </div>
            </div>
        </div>
    </div>

    <script>
        // 사이드바 처리
        document.addEventListener("DOMContentLoaded", function () {
            const element = document.getElementById("checksalary");
            document.getElementById("member").classList.add("open");
            element.style.backgroundColor = "#958CF4";
            element.style.color = "white";
            element.classList.add("active");
        });

        // 숫자 포맷팅
        document.addEventListener("DOMContentLoaded", function () {
            function formatNumberWithCommas(number) {
                return number ? number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") : "";
            }

            const salaryFields = document.querySelectorAll(".salary-field");
            salaryFields.forEach(field => {
                const rawValue = field.textContent.replace(/,/g, "").replace("원", "").trim();
                if (!isNaN(rawValue)) {
                    field.textContent = formatNumberWithCommas(rawValue) + "원";
                }
            });
        });

        $(document).on('click', '.pay_icon', function () {
            $(this).closest('form').submit();
        });
    </script>
</body>
</html>
