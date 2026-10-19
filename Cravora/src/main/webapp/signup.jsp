
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Sign Up | Cravora</title>

    <link rel="stylesheet" href="CSS/signup.css">
</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar">
        <a href="restaurant" class="logo">CRAVORA<span>.</span></a>

        <div class="nav-right">
            <a href="login.jsp" class="login-btn">LOGIN</a>
        </div>
    </nav>

    <!-- SIGNUP -->
    <main class="signup-wrapper">
        <section class="signup-card">

            <!-- IMAGE SIDE -->
            <div class="image-side">
                <img src="images/Indulge.jpg" alt="Delicious food">

                <div class="image-overlay"></div>

                <div class="image-content">
                    <div class="small-label">GOOD FOOD. GOOD MOOD.</div>

                    <h2>
                        YOUR NEXT<br>
                        <span>CRAVING</span><br>
                        STARTS HERE.
                    </h2>

                    <p>
                        Create your account and discover restaurants,
                        dishes and offers made for your cravings.
                    </p>
                </div>
            </div>

            <!-- FORM SIDE -->
            <div class="form-side">

                <div class="form-heading">
                    <div class="eyebrow">JOIN THE TABLE</div>

                    <h1>
                        CREATE<br>
                        ACCOUNT.
                    </h1>

                    <p>Sign up to order your favorite food faster.</p>
                </div>

                <!-- SIGNUP FORM -->
                <form action="signup" method="post">

                    <!-- USERNAME -->
                    <div class="form-group">
                        <label for="username">USERNAME</label>
                        <input
                            type="text"
                            id="username"
                            name="username"
                            placeholder="Enter your username"
                            autocomplete="username"
                            required>
                    </div>

                    <!-- PHONE -->
                    <div class="form-group">
                        <label for="phone">PHONE NUMBER</label>
                        <input
                            type="text"
                            id="phone"
                            name="phone"
                            placeholder="10-digit phone number"
                            autocomplete="tel"
                            maxlength="10"
                            required>
                    </div>

                    <!-- EMAIL -->
                    <div class="form-group">
                        <label for="email">EMAIL ADDRESS</label>
                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="you@example.com"
                            autocomplete="email"
                            required>
                    </div>

                    <!-- PASSWORD -->
                    <div class="form-group">
                        <label for="password">PASSWORD</label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Create a password"
                            autocomplete="new-password"
                            required>
                    </div>

                    <!-- ADDRESS -->
                    <div class="form-group">
                        <label for="address">DELIVERY ADDRESS</label>
                        <textarea
                            id="address"
                            name="address"
                            placeholder="Enter your delivery address"
                            autocomplete="street-address"
                            required></textarea>
                    </div>

                    <!-- SUBMIT BUTTON -->
                    <button type="submit" class="primary-btn">
                        CREATE ACCOUNT →
                    </button>

                </form>
            </div>
        </section>
    </main>

</body>
</html>
