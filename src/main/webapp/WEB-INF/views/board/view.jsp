<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 서버에서 받아온 게시글 제목으로 동적 설정 -->
    <title>${view.title} - 게시글 상세 보기</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

<!-- 게시글 상세 보기 화면 -->


<div class="container mt-5">
    <!-- Alert Placeholder -->
    <div id="alertPlaceholder" class="mb-3"></div>

    <div class="card">
        <div class="card-body">
            <!-- 서버에서 받아온 게시글 제목 -->
            <h1 class="card-title mb-3">${view.title}</h1>

            <div class="card-subtitle text-muted mb-4 border-bottom pb-2">
                <span>
                    <strong>카테고리:</strong> ${view.category} |
                    <strong>작성자:</strong> ${view.author}
                </span>
                <span class="float-end"><strong>작성일:</strong> ${view.createdDate}</span>
            </div>

            <!-- 서버에서 받아온 게시글 내용 -->
            <div class="card-text mb-4" style="min-height: 150px;">
                ${view.content}
                <!-- HTML 태그 렌더링이 필요하다면 서버에서 처리 후 출력 -->
            </div>

            <!-- 첨부 파일 섹션 (파일이 있을 경우) -->
            <!-- 현재 파일 첨부 기능이 구현되어 있지 않아 주석 처리 -->

            <div class="mb-4 border-top pt-3">
                <h5><i class="bi bi-paperclip"></i> 첨부 파일</h5>
                <ul class="list-group list-group-flush">
                    <c:if test="${not empty file}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <!-- 파일 다운로드 링크 추가 -->
                            <a href="/board/download/${file.attachmentId}" download>
                                <i class="bi bi-file-earmark me-2"></i>${file.originalFilename}
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${empty file}">
                        <li class="list-group-item">첨부 파일이 없습니다.</li>
                    </c:if>
                </ul>
            </div>

            <div class="d-flex justify-content-end pt-3 border-top">
                <!-- 로그인 상태 및 작성자 확인 후 수정/삭제 버튼 표시 (서버 로직 필요) -->
                <c:if test="${view.edite}">
                    <a href="/board/edit?id=${param.viewnumber}" class="btn btn-outline-secondary me-2">수정</a>
                </c:if>
                <!-- 삭제 버튼은 id를 동적으로 전달해야 함 -->
                <c:if test="${view.edite}">
                    <button type="button" class="btn btn-outline-danger me-2" onclick="deletePost(${param.viewnumber})">삭제</button>
                </c:if>
                <a href="/board/list" class="btn btn-primary">목록</a>
            </div>

        </div> <!-- End card-body -->
    </div> <!-- End card -->

</div>

<!-- Bootstrap JS Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
    


    // 삭제 확인 함수
    function deletePost(id) {
        if (confirm('정말로 삭제하시겠습니까?')) {
            // 실제로는 서버에 삭제 요청 (POST 또는 DELETE 메서드 사용)
           fetch(`/board/delete?id=${id}`, {
                method: 'DELETE',
           })
           .then(response => {
               if (response.ok) {
                    alert("게시글이 삭제되었습니다.");
                    window.location.href = "/board/list";
               } else {
                    alert("삭제 실패하였습니다.");
               }
           })
           .catch(error => {
               console.error("삭제 요청 실패:", error);
               alert("서버 오류로 삭제에 실패하였습니다.");
           })

        }
    }
</script>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
