<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSP CRUD 게시판</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>
        /* 내용이 네비게이션 바에 가리지 않도록 여백 추가 */
        body { padding-top: 70px; }

        /* 페이지별 메인 컨테이너 스타일 */
        .container { max-width: 900px; }

        /* 페이지 제목 스타일 */
        .page-title { margin-bottom: 30px; text-align: center; font-weight: bold; color: #343a40; }

        /* 푸터가 바닥에 붙도록 설정 */
        html, body { height: 100%; }
        body { display: flex; flex-direction: column; }
        .content-wrapper { flex: 1; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" href="list.jsp">📋 JSP Board</a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarMenu">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarMenu">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="list.jsp">목록보기</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="write.jsp">글쓰기</a>
            </li>
        </ul>
        <span class="navbar-text text-light">
                User: 22200029
            </span>
    </div>
</nav>

<div class="content-wrapper">