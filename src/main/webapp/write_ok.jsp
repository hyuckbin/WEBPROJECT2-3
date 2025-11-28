<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="u" class="org.example.com.crud.bean.BoardVO" />
<jsp:setProperty property="*" name="u" />

<%
    BoardDAO boardDAO = new BoardDAO();
    int result = boardDAO.insertBoard(u);

    if (result == 0) {
        System.out.println("글 추가 실패");
    } else {
        System.out.println("글 추가 성공!");
    }

    // 4. 처리가 끝나면 목록 페이지로 이동
    response.sendRedirect("list.jsp");
%>