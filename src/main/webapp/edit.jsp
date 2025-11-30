<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO, org.example.com.crud.bean.BoardVO"%>

<jsp:include page="header.jsp" />

<%
    String id = request.getParameter("id");
    BoardDAO boardDAO = new BoardDAO();
    BoardVO u = boardDAO.getBoard(Integer.parseInt(id));
%>

<div class="container">
    <h3 class="text-center mb-4">📝 게시글 수정</h3>

    <form action="edit_ok.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="seq" value="<%=u.getSeq()%>">
        <input type="hidden" name="old_filename" value="<%=u.getFilename()%>">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" value="<%=u.getTitle()%>" required>
        </div>

        <div class="form-group">
            <label for="writer">작성자</label>
            <input type="text" class="form-control" id="writer" name="writer" value="<%=u.getWriter()%>" required>
        </div>

        <div class="form-group">
            <label for="photo">사진 첨부</label>
            <% if(u.getFilename() != null && !u.getFilename().equals("")) { %>
            <div class="mb-2 text-muted">
                <small>현재 파일: <%= u.getFilename() %></small>
            </div>
            <% } %>
            <input type="file" class="form-control-file" id="photo" name="photo">
        </div>

        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="10"><%=u.getContent()%></textarea>
        </div>

        <div class="text-right">
            <a href="list.jsp" class="btn btn-secondary">취소</a>
            <button type="submit" class="btn btn-warning">수정 완료</button>
        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />