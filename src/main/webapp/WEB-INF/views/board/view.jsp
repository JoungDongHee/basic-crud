<%@ include file="/WEB-INF/views/common/header.jsp" %> <!-- header.jsp 포함 -->
<%@ include file="/WEB-INF/views/common/_taglibs.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${view.title} - 게시글 상세 보기</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

<div class="container mt-5">
    <div id="alertPlaceholder" class="mb-3"></div>

    <div class="card">
        <div class="card-body">
            <!-- 게시글 제목 -->
            <h1 class="card-title mb-3">${view.title}</h1>

            <div class="card-subtitle text-muted mb-4 border-bottom pb-2">
                <span>
                    <strong>카테고리:</strong> ${view.category} |
                    <strong>작성자:</strong> ${view.author}
                </span>
                <span class="float-end"><strong>작성일:</strong> ${view.createdDate}</span>
            </div>

            <!-- 게시글 내용 -->
            <div class="card-text mb-4" style="min-height: 150px;">
                ${view.content}  <!-- 내용 출력 (HTML로 렌더링) -->
            </div>

            <!-- 좋아요/싫어요 버튼 -->
            <div class="mb-4 text-center">
                <button class="btn btn-outline-success btn-sm me-2 like-button" data-post-id="${view.postId}">
                    <i class="bi bi-hand-thumbs-up"></i> 좋아요 (<span id="likeCount_${view.postId}">${view.likeCount}</span>)
                </button>
                <button class="btn btn-outline-danger btn-sm dislike-button" data-post-id="${view.postId}">
                    <i class="bi bi-hand-thumbs-down"></i> 싫어요 (<span id="dislikeCount_${view.postId}">${view.dislikeCount}</span>)
                </button>
            </div>

            <!-- 첨부 파일 섹션 -->
            <div class="mb-4 border-top pt-3">
                <h5><i class="bi bi-paperclip"></i> 첨부 파일</h5>
                <ul class="list-group list-group-flush">
                    <c:if test="${not empty file}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
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

            <!-- 수정/삭제 버튼 (작성자만 가능) -->
            <div class="d-flex justify-content-end pt-3 border-top">
                <c:if test="${view.edite}">
                    <a href="/board/edit?id=${param.viewnumber}" class="btn btn-outline-secondary me-2">수정</a>
                </c:if>
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
<script src="/resources/js/likeDislike.js"></script>

<script>
    // 간단한 삭제 확인 함수
    function deletePost(id) {
        if (confirm('정말로 삭제하시겠습니까?')) {
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

    document.addEventListener('DOMContentLoaded', function() {
        // Add event listeners to all like buttons
        document.querySelectorAll('.like-button').forEach(button => {
            button.addEventListener('click', function() {
                handleLike(this.dataset.postId);
            });
        });
        // Add event listeners to all dislike buttons
        document.querySelectorAll('.dislike-button').forEach(button => {
            button.addEventListener('click', function() {
                handleDislike(this.dataset.postId);
            });
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> <!-- footer.jsp 포함 -->

</body>
</html>
