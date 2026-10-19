<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login | Cravora</title>

    <link rel="stylesheet" href="CSS/login.css">
</head>

<body>

    <!-- NAVBAR -->

    <nav class="navbar">

        <a href="#" class="logo">
            Cravora<span>.</span>
        </a>

        <div class="nav-right">
            <span class="nav-text">New to Cravora?</span>

            <a class="signup-btn" href="signup.jsp">
                CREATE ACCOUNT
            </a>
        </div>

    </nav>


    <!-- LOGIN -->

    <main class="login-wrapper">

        <section class="login-card">

            <!-- FORM LEFT -->

            <div class="form-side">

                <div class="form-heading">

                    <div class="eyebrow">
                        WELCOME BACK
                    </div>

                    <h1>
                        LOGIN<br>
                        TO CRAVORA.
                    </h1>

                    <p>
                        Your cravings are waiting.
                        Sign in and get back to good food.
                    </p>

                </div>


                <form action="login" method="post">

                    <!-- EMAIL -->

                    <div class="form-group">

                        <label for="email">
                            EMAIL ADDRESS
                        </label>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="you@example.com"
                            required>

                    </div>


                    <!-- PASSWORD -->

                    <div class="form-group">

                        <label for="password">
                            PASSWORD
                        </label>

                        <div class="input-wrapper">

                            <input
                                type="password"
                                id="password"
                                name="password"
                                class="password-input"
                                placeholder="Enter your password"
                                required>

                            <button
                                type="button"
                                class="show-password"
                                id="showPassword">
                                SHOW
                            </button>

                        </div>

                    </div>


                    <!-- LOGIN BUTTON -->

                    <button
                        type="submit"
                        class="login-submit">
                        LOGIN →
                    </button>


                    <!-- CREATE ACCOUNT -->

                    <div class="create-account">

                        Don't have an account?

                        <a href="signup.jsp">
                            Create account
                        </a>

                    </div>

                </form>

            </div>


            <!-- IMAGE RIGHT -->

            <div class="image-side">

                <img
                    src="images/Nancy's.jpg"
                    alt="Delicious food">

                <div class="image-overlay"></div>

                <div class="image-content">

                    <div class="label">
                        CRAVE IT. ORDER IT.
                    </div>

                    <h2>
                        GOOD FOOD<br>
                        <span>GOOD MOOD.</span>
                    </h2>

                    <p>
                        Discover your next favorite meal,
                        delivered straight to your door.
                    </p>

                </div>

            </div>

        </section>

    </main>


    <!-- SHOW / HIDE PASSWORD -->

    <script>

        const password = document.getElementById("password");
        const showPassword = document.getElementById("showPassword");

        showPassword.addEventListener("click", function () {

            if (password.type === "password") {

                password.type = "text";
                showPassword.textContent = "HIDE";

            } else {

                password.type = "password";
                showPassword.textContent = "SHOW";

            }

        });

    </script>

</body>
</html>