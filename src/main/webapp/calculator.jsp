<%--
  Created by IntelliJ IDEA.
  User: jared
  Date: 10/18/2023
  Time: 1:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%-- JSP comments will not appear in the browser --%>
<!-- HTML comments will appear in the browser -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calculator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
    <div class="container my-4">
        <div class="row">
            <div class="col-6">
                <h1>Add</h1>
                <p class="lead">Enter two numbers and press submit to calculate the sum.</p>
                <form method="POST" action="calculator">
                    <div class="form-group mb-2">
                        <label for="firstNumber">First Number:</label>
                        <input name="num1" value="${results.num1}" type="text" class="form-control" id="firstNumber">
                    </div>
                    <div class="form-group mb-2">
                        <label for="secondNumber">Second Number:</label>
                        <input name="num2" value="${results.num2}" type="text" class="form-control" id="secondNumber">
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
