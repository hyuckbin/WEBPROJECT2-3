<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.com.crud.dao.BoardDAO, org.example.com.crud.bean.BoardVO"%>

<%
    // 1. 삭제할 글 번호(id) 받기
    String id = request.getParameter("id");

    // 2. DAO 호출하여 삭제 실행
    // (BoardDAO.deleteBoard 메서드가 BoardVO 객체를 받도록 되어 있으므로 객체를 만들어 담아줍니다)
    if(id != null && !id.isEmpty()){
        BoardDAO boardDAO = new BoardDAO();
        BoardVO vo = new BoardVO();
        vo.setSeq(Integer.parseInt(id));

        boardDAO.deleteBoard(vo);
        System.out.println(id + "번 글 삭제 성공");
    }

    // 3. 삭제 후 목록으로 돌아가기
    response.sendRedirect("list.jsp");
%>