<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO, org.example.com.crud.bean.BoardVO, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />

<%
    // DB에서 리스트 가져오는 로직
    BoardDAO boardDAO = new BoardDAO();
    String key = request.getParameter("key");
    String word = request.getParameter("word");
    List<BoardVO> list = boardDAO.getBoardList(key,word);
    request.setAttribute("list", list);
%>

<div class="container">
    <h2 class="page-title">📋 자유 게시판</h2>

    <div class="row mb-3">
        <div class="col-md-8">
            <form action="list.jsp" method="get" class="form-inline">
                <div class="input-group">
                    <select name="key" class="form-control" style="max-width: 120px;">
                        <option value="title">제목</option>
                        <option value="writer">작성자</option>
                    </select>
                    <input type="text" name="word" class="form-control" placeholder="검색어를 입력하세요">
                    <button type="submit" class="btn btn-outline-primary">검색</button>
                </div>
            </form>
        </div>

    <div class="text-right mb-3">
        <a href="write.jsp" class="btn btn-primary">새 글 작성</a>
    </div>

    <table class="table table-hover table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="u">
            <tr>
                <td>${u.seq}</td>
                <td><a href="view.jsp?id=${u.seq}">${u.title}</a></td>
                <td>${u.writer}</td>
                <td>${u.regdate}</td>
                <td>${u.cnt}</td>
                <td>
                    <a href="edit.jsp?id=${u.seq}" class="btn btn-warning btn-sm">수정</a>
                    <a href="javascript:delete_ok('${u.seq}')" class="btn btn-danger btn-sm">삭제</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function delete_ok(id) {
        if(confirm("정말로 이 글을 삭제하시겠습니까?")) {
            location.href = "delete_ok.jsp?id=" + id;
        }
    }
</script>

<jsp:include page="footer.jsp" />