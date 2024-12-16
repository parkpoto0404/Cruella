<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.0.272/jspdf.debug.js"></script>
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 스타일은 동일하게 유지 */
.container {
    width: 600px;
    margin: 0 auto;
    border: 1px solid #000;
    padding: 10px 10px;
    padding-bottom: 50px;
}

.title {
    text-align: center;
    font-size: x-large;
    font-weight: bold;
    margin-bottom: 70px;
    margin-top: 70px;
}

.salary-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 10px;
}

.salary-table th, .salary-table td {
    border: 1px solid #000;
    padding: 8px;
    text-align: center;
    font-size: 0.9em;
}

.salary-table .section-title {
    font-weight: bold;
}

.total-row {
    font-weight: bold;
    text-align: right;
}

.total-amount {
    color: blue;
    font-weight: bold;
}

.deduction-amount {
    color: red;
    font-weight: bold;
}

.net-pay {
    text-align: right;
    font-weight: bold;
    margin-top: 50px;
    font-size: 1em;
}

/* Remove bottom border for "지급 항목" and "공제 항목" row */
.no-border th {
    border-bottom: none;
}
</style>
</head>
<body>

<div style="width: 77%; text-align: right;">
    <div style="display: flex; justify-content: left;">
        <span style="position: relative; left: 89%; cursor: pointer;" id="pdfDownloadButton">
            <img src="${contextPath}/resources/assets/img/free-icon-pdf-5453995.png" style="width: 38px;" />
        </span>
    </div>
</div>

<div class="container" id="content_div">
    <div class="title">9월 급여명세서</div>
    <p>지급일: ${list.paymentDate}</p>
    <table class="salary-table">
        <tr>
            <td style="background-color: lightgray;">부서</td>
            <td>${list.deptName}</td>
            <td style="background-color: lightgray;">직급</td>
            <td>${list.posName}</td>
        </tr>
        <tr>
            <td style="background-color: lightgray;">성명</td>
            <td>${list.memName}</td>
            <td style="background-color: lightgray;">입사일</td>
            <td>${list.hireDate}</td>
        </tr>
        <tr class="no-border" style="background-color: lightgray;">
            <th colspan="2" style="height: 40px;">지급 항목</th>
            <th colspan="2">공제 항목</th>
        </tr>
        <tr>
            <td>기본급</td>
            <td class="number-field">
                <c:choose>
                    <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                    <c:otherwise>${list.salary}</c:otherwise>
                </c:choose>
            </td>
            <td>국민연금</td>
            <td class="number-field">
                <c:choose>
                    <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                    <c:otherwise>${list.pension}</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>건강보험</td>
            <td class="number-field">
                <c:choose>
                    <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                    <c:otherwise>${list.health}</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>고용보험</td>
            <td class="number-field">
                <c:choose>
                    <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                    <c:otherwise>${list.employment}</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>장기요양</td>
            <td class="number-field">
                <c:choose>
                    <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                    <c:otherwise>${list.care}</c:otherwise>
                </c:choose>
            </td>
        </tr>

        <!-- 빈 줄 복원 -->
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>

        <tr class="total-row">
            <td class="section-title">지급 총액</td>
            <td class="number-field total-amount">
                <c:choose>
                    <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                    <c:otherwise>${list.salary}</c:otherwise>
                </c:choose>
            </td>
            <td class="section-title">공제 총액</td>
            <td class="number-field deduction-amount">
                <c:choose>
                    <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                    <c:otherwise>
                        <c:set var="deductionTotal" value="${list.pension + list.health + list.employment + list.care}" />
                        ${deductionTotal}
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
    <p class="net-pay">실지급액:
        <span class="number-field" data-unit="원">
            <c:choose>
                <c:when test="${list.paymentDate == 'N/A'}">0</c:when>
                <c:otherwise>${list.totalSalary}</c:otherwise>
            </c:choose>
        </span>
    </p>
</div>

<script>
    $(document).ready(function () {
        function pdf_down() {
            const element = document.getElementById('content_div');
            const userName = '${list.memName}';

            const options = {
                margin: 10,
                filename: '급여명세서_' + userName + '.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 1 },
                jsPDF: { unit: 'mm', format: 'a3', orientation: 'portrait' }
            };

            html2pdf()
                .from(element)
                .set(options)
                .save();
        }

        $('#pdfDownloadButton').on('click', pdf_down);
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 숫자에 콤마를 추가하는 함수
        function formatNumberWithCommas(number) {
            if (!number) return "0"; // 값이 없으면 "0" 반환
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        // .number-field 클래스를 가진 모든 요소에 포맷 적용
        const numberFields = document.querySelectorAll(".number-field");

        numberFields.forEach(field => {
            const rawValue = field.textContent.replace(/,/g, "").replace("원", "").trim(); // 기존 값에서 숫자만 추출
            if (!isNaN(rawValue) && rawValue !== "") {
                const formattedNumber = formatNumberWithCommas(rawValue); // 콤마 추가
                if (field.dataset.unit === "원") {
                    field.textContent = formattedNumber + "원"; // "원" 단위 추가
                } else {
                    field.textContent = formattedNumber;
                }
            } else {
                field.textContent = "0원"; // 값이 없을 경우 기본 값 설정
            }
        });
    });
</script>


</body>
</html>
