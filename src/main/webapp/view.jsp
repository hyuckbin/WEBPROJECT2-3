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

    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><%= u.getTitle() %></h5>
            <small class="text-muted">No. <%= u.getSeq() %></small>
        </div>
        <div class="card-body">
            <div class="row mb-3 border-bottom pb-2">
                <div class="col-md-6 text-muted">
                    <span>작성자: <strong><%= u.getWriter() %></strong></span>
                </div>
                <div class="col-md-6 text-right text-muted" style="text-align: right;">
                    <span>등록일: <%= u.getRegdate() %></span>
                    <span class="ml-3">| 조회수: <%= u.getCnt() %></span>
                </div>
            </div>

            <p class="card-text mb-4" style="min-height: 150px; white-space: pre-wrap;"><%= u.getContent() %></p>

            <div class="mb-3">
                <label class="text-muted"><small>첨부 이미지</small></label>
                <div>
                    <%
                        String filename = u.getFilename();
                        if (filename != null && !filename.equals("")) {
                    %>
                    <img src="upload/<%= filename %>" class="img-fluid rounded border" alt="첨부 이미지">
                    <%
                    } else {
                    %>
                    <span class="text-muted text-small">첨부된 이미지가 없습니다.</span>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <div class="text-right" style="text-align: right;">
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