<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Temperature Converter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<div class="container my-4">
    <div class="row">
        <div class="col-6">
            <h1>Convert Temperature</h1>
            <p class="lead">Select the type of conversion you would like to perform and enter the temperature.
                <br />Press enter to see the result.</p>
            <form method="POST" action="convert-temp">
                <div class="btn-group mb-2" role="group" aria-label="Basic radio toggle button group">
                    <input checked="${results.conversion == 'FtoC' ? 'checked' : ''}" value="FtoC" type="radio" class="btn-check" name="conversion" id="FtoC" autocomplete="off">
                    <label class="btn btn-outline-primary" for="FtoC">Fahrenheit to Celsius</label>

                    <input checked="${results.conversion == 'CtoF' ? 'checked' : ''}" value="CtoF" type="radio" class="btn-check" name="conversion" id="CtoF" autocomplete="off">
                    <label class="btn btn-outline-primary" for="CtoF">Celsius to Fahrenheit</label>
                </div> <!-- end button group -->

                <div class="form-group mb-2">
                    <label for="temperature">Temperature:</label>
                    <input value="${results.temperature}" type="text" class="form-control" id="temperature" name="temperature">
                </div>

                <button type="submit" class="btn btn-primary">Submit</button>
            </form>

            <c:if test="${results.tempConverted != ''}">
                <p>${results.tempConverted}</p>
            </c:if>
            <c:if test="${results.conversionError != ''}">
                <p>${results.conversionError}</p>
            </c:if>
            <c:if test="${results.temperatureError != ''}">
                <p>${results.temperatureError}</p>
            </c:if>

        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>
