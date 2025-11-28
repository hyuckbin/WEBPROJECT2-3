<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="u" class="org.example.com.crud.bean.BoardVO" />
<jsp:setProperty property="*" name="u" />

<%
    BoardDAO boardDAO = new BoardDAO();
    // updateBoard 호출 (seq, title, writer, content가 u에 들어있음)
    int result = boardDAO.updateBoard(u);

    if (result == 0) {
        System.out.println("글 수정 실패");
    } else {
        System.out.println("글 수정 성공!");
    }

    response.sendRedirect("list.jsp");
%>