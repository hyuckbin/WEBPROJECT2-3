<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO"%>
<%@ page import="org.example.com.crud.bean.BoardVO"%>
<%@ page import="org.example.com.crud.common.FileUpload"%>
<%
    request.setCharacterEncoding("UTF-8");

    FileUpload upload = new FileUpload();
    BoardVO u = upload.uploadPhoto(request);

    BoardDAO boardDAO = new BoardDAO();
    int result = boardDAO.insertBoard(u);

    if (result == 0) {
        System.out.println("글 추가 실패");
    } else {
        System.out.println("글 추가 성공!");
    }
    response.sendRedirect("list.jsp");
%>