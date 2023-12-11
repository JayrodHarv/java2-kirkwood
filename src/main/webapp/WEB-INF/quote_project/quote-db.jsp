<%--
  Created by IntelliJ IDEA.
  User: jared
  Date: 12/8/2023
  Time: 12:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Quote Database</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h1>Quotes</h1>
    <p class="lead">There ${quotes.size() == 1 ? "is" : "are"} ${quotes.size()} quote${quotes.size() != 1 ? "s" : ""}</p>
    <c:if test="${quotes.size() > 0}">
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">id</th>
                    <th scope="col">content</th>
                    <th scope="col">author</th>
                    <th scope="col">date_added</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${quotes}" var="quote">
                    <tr>
                        <th scope="row">${quote.id}</th>
                        <td>${quote.content}</td>
                        <td>${quote.author}</td>
                        <td>${quote.date_added}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>
