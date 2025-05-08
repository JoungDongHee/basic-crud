<%@ include file="/WEB-INF/views/common/header.jsp" %> <!-- header.jsp 포함 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 목록 (Bootstrap)</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

<div class="container mt-5">
    <!-- 게시글 목록 화면 -->

    <h1 class="mb-4 text-center">게시판</h1>

    <div class="d-flex justify-content-end mb-3">
        <a href="write" class="btn btn-primary">새 글 작성</a>
    </div>

    <table class="table table-striped table-hover table-bordered">
        <thead class="table-dark">
        <tr>
            <th scope="col">번호</th>
            <th scope="col">카테고리</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>
            <th scope="col">좋아요</th>
            <th scope="col">싫어요</th>
        </tr>
        </thead>
        <tbody>
        <!-- 게시글 데이터가 동적으로 추가될 부분 -->
        <c:forEach var="board" items="${boardList}">
            <tr>
                <th scope="row">${board.postId}</th>
                <td>${board.category}</td>
                <td><a href="view/${board.postId}">${board.title}</a></td>
                <td>${board.userName}</td>
                <td>${board.createdDate}</td>
                <td>
                    <button class="btn btn-outline-primary btn-sm like-button" data-post-id="${board.postId}">
                        <i class="bi bi-hand-thumbs-up"></i> ${board.likeCount}
                    </button>
                </td>
                <td>
                    <button class="btn btn-outline-danger btn-sm dislike-button" data-post-id="${board.postId}">
                        <i class="bi bi-hand-thumbs-down"></i> ${board.dislikeCount}
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Pagination -->
    <div class="d-flex justify-content-end mb-3">
        <span>전체 : ${totalBoardCount}개</span>
    </div>
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${prevPage != null}">
                <li class="page-item">
                    <a class="page-link" href="?page=${prevPage}">Previous</a>
                </li>
            </c:if>
            <c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
                <c:choose>
                    <c:when test="${pageNum == currentPage}">
                        <li class="page-item active" aria-current="page">
                            <a class="page-link" href="?page=${pageNum}">${pageNum}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="?page=${pageNum}">${pageNum}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${nextPage != null}">
                <li class="page-item"><a class="page-link" href="?page=${nextPage}">Next</a></li>
            </c:if>
        </ul>
    </nav>
    <!-- End Pagination -->

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> <!-- footer.jsp 포함 -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="/resources/js/likeDislike.js"></script>

<script>
    // 간단한 삭제 확인 함수 (실제 구현에서는 서버 통신 필요)
    function deletePost(id) {
        if (confirm('정말로 삭제하시겠습니까?')) {
            // 실제로는 서버에 삭제 요청을 보내야 합니다.
            console.log('Deleting post with id:', id);
            // 성공 시 해당 행을 테이블에서 제거하는 로직 추가
            alert('삭제되었습니다.');
            // window.location.reload(); // 페이지 새로고침 또는 DOM 조작
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        // Add event listeners to all like buttons
        document.querySelectorAll('.like-button').forEach(button => {
            button.addEventListener('click', function() {
                const postId = this.getAttribute('data-post-id');
                handleLike(postId); // Assuming handleLike is defined in likeDislike.js
            });
        });

        // Add event listeners to all dislike buttons
        document.querySelectorAll('.dislike-button').forEach(button => {
            button.addEventListener('click', function() {
                const postId = this.getAttribute('data-post-id');
                handleDislike(postId); // Assuming handleDislike is defined in likeDislike.js
            });
        });
    });
</script>
</body>
</html>
