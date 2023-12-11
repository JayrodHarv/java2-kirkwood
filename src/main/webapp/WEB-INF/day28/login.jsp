<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>LearnX  - An innovative tutorial site for K-12 students</title>

    <!-- Meta Tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <script src="https://kit.fontawesome.com/ce46e6e2d7.js" crossorigin="anonymous"></script>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Custom Styles -->
    <link rel="stylesheet" href="styles/main.css">
</head>
<body>
<!-- **************** MAIN CONTENT START **************** -->
<main>
    <section class="p-0 d-flex align-items-center position-relative overflow-hidden">

        <div class="container-fluid">
            <div class="row">

                <div class="col-12 col-lg-8 m-auto">
                    <div class="row my-5">
                        <div class="col-sm-10 col-xl-8 m-auto">
                            <!-- Title -->
                            <h1 class="fs-2">Nice to see you! </h1>
                            <p class="lead mb-4">Please log in to your account.</p>

                            <c:if test="${not empty results.loginSuccess}">
                                <div class="alert alert-success mb-2" role="alert">
                                        ${results.loginSuccess}
                                </div>
                            </c:if>
                            <c:if test="${not empty results.loginFail}">
                                <div class="alert alert-danger mb-2" role="alert">
                                        ${results.loginFail}
                                </div>
                            </c:if>

                            <!-- Form START -->
                            <form method="post" action="login">
                                <!-- Email -->
                                <div class="mb-4">
                                    <label for="inputEmail1" class="form-label">Email address *</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text bg-light rounded-start border-0 text-secondary px-3"><i class="bi bi-envelope-fill"></i></span>
                                        <input type="text" value="${results.email}" class="form-control border-0 bg-light rounded-end ps-1" placeholder="E-mail" id="inputEmail1" name="inputEmail1">
                                    </div>
                                </div>
                                <!-- Password -->
                                <div class="mb-4">
                                    <label for="inputPassword1" class="form-label">Password *</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text bg-light rounded-start border-0 text-secondary px-3"><i class="fas fa-lock"></i></span>
                                        <input type="password" value="${results.password}" class="form-control border-0 bg-light rounded-end ps-1" placeholder="*********" id="inputPassword1" name="inputPassword1">
                                    </div>
                                </div>
                                <!-- Check box -->
                                <div class="mb-4 d-flex justify-content-between mb-4">
                                    <div class="form-check">
                                        <input type="checkbox" ${results.rememberMe == "true" ? "checked" : ""} class="form-check-input" id="exampleCheck1" name="rememberMe" value="true">
                                        <label class="form-check-label"  for="exampleCheck1">Remember me</label>
                                    </div>
                                    <div class="text-primary-hover">
                                        <a href="#" class="text-secondary"><u>Forgot password?</u></a>
                                    </div>
                                </div>
                                <!-- Button -->
                                <div class="align-items-center mt-0">
                                    <div class="d-grid">
                                        <button class="btn btn-primary mb-0" type="submit">Login</button>
                                    </div>
                                </div>
                            </form>
                            <!-- Form END -->

                            <!-- Sign up link -->
                            <div class="mt-4 text-center">
                                <span>Don't have an account? <a href="signup">Signup here</a></span>
                            </div>
                        </div>
                    </div> <!-- Row END -->
                </div>
            </div> <!-- Row END -->
        </div>
    </section>
</main>
<!-- **************** MAIN CONTENT END **************** -->
</body>
</html>
