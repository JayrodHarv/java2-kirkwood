<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Quote Directory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Quote Directory</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Sort
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="typing-test-json?sort=az&q=${q}&author=${author}">A-Z</a></li>
                        <li><a class="dropdown-item" href="typing-test-json?sort=za&q=${q}&author=${author}">Z-A</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Filter by State
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown2">
                        <li><a class="dropdown-item" href="typing-test-json?sort=${s}&q=${q}">All</a></li>
                        <c:forEach items="${authors}" var="author">
                            <li><a class="dropdown-item" href="typing-test-json?sort=${s}&q=${q}&author=${author}">${author}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </ul>
            <form class="d-flex" action="typing-test-json" method="GET">
                <input name="q" value="${q}" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <input name="sort" value="${s}" type="hidden">
                <input name="state" value="${author}" type="hidden">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>

<div class="container my-4">
    <div class="row">
        <c:forEach items="${quotes}" var="quote">
            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="car-title">${quote.author}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">${quote.content}</h6>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>
