<%--
  Created by IntelliJ IDEA.
  User: jared
  Date: 11/27/2023
  Time: 12:43 PM
  To change this template use File | Settings | File Templates.
--%>
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
                            <h2>Nice to meet you!</h2>
                            <p class="lead mb-4">Please sign up for an account.</p>

                            <c:if test="${not empty results.userAddSuccess}">
                                <div class="alert alert-success mb-2" role="alert">
                                        ${results.userAddSuccess}
                                </div>
                            </c:if>
                            <c:if test="${not empty results.userAddFail}">
                                <div class="alert alert-danger mb-2" role="alert">
                                        ${results.userAddFail}
                                </div>
                            </c:if>

                            <!-- Form START -->
                            <form method="POST" action="signup">
                                <!-- Email -->
                                <div class="mb-4">
                                    <label for="inputEmail1" class="form-label">Email address *</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text bg-light rounded-start border-0 text-secondary px-3"><i class="bi bi-envelope-fill"></i></span>
                                        <input value="${results.email}" type="text" class="form-control <c:if test="${not empty results.emailError}">is-invalid</c:if> border-0 bg-light rounded-end ps-1" placeholder="E-mail" name="inputEmail1" id="inputEmail1">
                                        <c:if test="${not empty results.emailError}">
                                            <div class="invalid-feedback">${results.emailError}</div>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- Password -->
                                <div class="mb-4">
                                    <label for="inputPassword1" class="form-label">Password *</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text bg-light rounded-start border-0 text-secondary px-3"><i class="fas fa-lock"></i></span>
                                        <input value="${results.password1}" type="password" class="form-control <c:if test="${not empty results.password1Error}">is-invalid</c:if> border-0 bg-light rounded-end ps-1" placeholder="*********" name="inputPassword1" id="inputPassword1">
                                        <c:if test="${not empty results.password1Error}">
                                            <div class="invalid-feedback">${results.password1Error}</div>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- Confirm Password -->
                                <div class="mb-4">
                                    <label for="inputPassword2" class="form-label">Confirm Password *</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text bg-light rounded-start border-0 text-secondary px-3"><i class="fas fa-lock"></i></span>
                                        <input value="${results.password2}" type="password" class="form-control <c:if test="${not empty results.password2Error}">is-invalid</c:if> border-0 bg-light rounded-end ps-1" placeholder="*********" name="inputPassword2" id="inputPassword2">
                                        <c:if test="${not empty results.password2Error}">
                                            <div class="invalid-feedback">${results.password2Error}</div>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- Check box -->
                                <div class="mb-4">
                                    <div class="form-check">
                                        <input ${results.termsOfService == 'agree' ? 'checked' : ''} type="checkbox" class="form-check-input <c:if test="${not empty results.termsOfServiceError}">is-invalid</c:if>" name="termsOfService" id="checkbox-1" value="agree">
                                        <label class="form-check-label" for="checkbox-1">By signing up, you agree to the <a href="#">terms of service</a></label>
                                        <c:if test="${not empty results.termsOfServiceError}">
                                            <div class="invalid-feedback">${results.termsOfServiceError}</div>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- Button -->
                                <div class="align-items-center mt-0">
                                    <div class="d-grid">
                                        <button class="btn btn-primary mb-0" type="submit">Sign Up</button>
                                    </div>
                                </div>
                            </form>
                            <!-- Form END -->

                            <!-- Sign up link -->
                            <div class="mt-4 text-center">
                                <span>Already have an account?<a href="login"> Sign in here</a></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<!-- **************** MAIN CONTENT END **************** -->
</body>
</html>
