<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO, org.example.com.crud.bean.BoardVO"%>

<jsp:include page="header.jsp" />

<%
    String id = request.getParameter("id");
    BoardDAO boardDAO = new BoardDAO();
    BoardVO u = boardDAO.getBoard(Integer.parseInt(id));
%>

<div class="container">
    <h3 class="text-center mb-4">📖 게시글 상세보기</h3>

    <div class="card">
        <div class="card-header">
            <%= u.getTitle() %>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6 text-muted">
                    작성자: <%= u.getWriter() %>
                </div>
                <div class="col-md-6 text-right text-muted">
                    등록일: <%= u.getRegdate() %> | 조회수: <%= u.getCnt() %>
                </div>
            </div>
            <hr>
            <p class="card-text" style="min-height: 200px;">
                <%= u.getContent() %>
            </p>
        </div>
    </div>

    <div class="text-right mt-3">
        <a href="list.jsp" class="btn btn-secondary">목록보기</a>
        <a href="edit.jsp?id=<%= u.getSeq() %>" class="btn btn-warning">수정</a>
        <a href="javascript:delete_ok('<%= u.getSeq() %>')" class="btn btn-danger">삭제</a>
    </div>
</div>

<script>
    function delete_ok(id) {
        if(confirm("정말로 이 글을 삭제하시겠습니까?")) {
            location.href = "delete_ok.jsp?id=" + id;
        }
    }
</script>

<jsp:include page="footer.jsp" />