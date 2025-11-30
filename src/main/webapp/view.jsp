<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO, org.example.com.crud.bean.BoardVO"%>

<jsp:include page="header.jsp" />

<%
    String id = request.getParameter("id");
    BoardDAO boardDAO = new BoardDAO();

    // ] 조회수 1 증가 (상세보기 볼 때마다)
    if(id != null && !id.equals("")) {
        boardDAO.increaseCnt(Integer.parseInt(id));
    }
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
                <label class="text-muted"><small>첨부 파일</small></label>
                <div>
                    <%
                        String filename = u.getFilename();

                        if (filename != null && !filename.equals("")) {
                            String lowerFile = filename.toLowerCase();

                            // 이미지인지 확인
                            if (lowerFile.endsWith(".jpg") || lowerFile.endsWith(".jpeg") ||
                                    lowerFile.endsWith(".png") || lowerFile.endsWith(".gif") ||
                                    lowerFile.endsWith(".bmp") || lowerFile.endsWith(".webp")) {
                    %>
                    <img src="${pageContext.request.contextPath}/upload/<%= filename %>" class="img-fluid rounded border" style="max-width: 100%;" alt="첨부 이미지">
                    <%
                    } else {
                    %>
                    <div class="card bg-light p-3 border-0">
                        <div class="d-flex align-items-center">
                            <span class="mr-3">📄 해당 파일은 미리보기를 지원하지 않습니다.</span>
                            <a href="${pageContext.request.contextPath}/upload/<%= filename %>" class="btn btn-outline-dark btn-sm ml-2" download>
                                📥 <%= filename %> 다운로드
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <span class="text-muted text-small">첨부된 파일이 없습니다.</span>
                    <%
                        }
                    %>
                </div>
            </div>
        </div> </div> <div class="text-right" style="text-align: right;">
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