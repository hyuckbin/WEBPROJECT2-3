<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO"%>
<%@ page import="org.example.com.crud.bean.BoardVO" %>
<%@ page import="org.example.com.crud.common.FileUpload" %>
<%
    request.setCharacterEncoding("UTF-8");

    FileUpload upload = new FileUpload();
    BoardVO vo = upload.uploadPhoto(request);

    BoardDAO dao = new BoardDAO();
    int i = dao.updateBoard(vo);

    if (i > 0) {
        System.out.println("글 수정 성공!");
        response.sendRedirect("view.jsp?id=" + vo.getSeq());
    } else {
        System.out.println("글 수정 실패");
        response.sendRedirect("list.jsp");
    }
%>
