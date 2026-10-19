<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.tap.model.Restaurant" %>
<%!
    private String homeImage(List<Restaurant> restaurants, int index, String fallback) {
        if (restaurants == null || restaurants.isEmpty()) {
            return fallback;
        }
        Restaurant restaurant = restaurants.get(index % restaurants.size());
        String imagePath = restaurant == null ? null : restaurant.getImagePath();
        if (imagePath == null || imagePath.trim().isEmpty()) {
            return fallback;
        }
        imagePath = imagePath.trim();
        if (imagePath.startsWith("http://") || imagePath.startsWith("https://")
                || imagePath.startsWith("/") || imagePath.startsWith("images/")) {
            return imagePath;
        }
        return "images/" + imagePath;
    }
%>
<%
    List<Restaurant> homeRestaurants =
        (List<Restaurant>) request.getAttribute("restaurants");
    String homeHeroImage = homeImage(homeRestaurants, 0, "images/Indulge.jpg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cravora | Your Cravings Start Here</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@600;700;800;900&family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/home.css">
</head>

<body>

    <!-- =========================================================
         HERO
    ========================================================== -->

    <section class="hero" id="top">

        <video class="hero-video" autoplay muted loop playsinline poster="<%= homeHeroImage %>" style="background: url('<%= homeHeroImage %>') center / cover no-repeat;">
            <source src="videos/food-hero.mp4" type="video/mp4">
            <source src="videos/cravora-hero.mp4" type="video/mp4">
        </video>

        <div class="hero-shade" aria-hidden="true"></div>

        <nav class="navbar" aria-label="Main navigation">

            <a href="<%= request.getContextPath() %>/home" class="logo" aria-label="Cravora home">
                CRAV<span>O</span>RA
            </a>

            <div class="nav-right">
                <a href="<%= request.getContextPath() %>/restaurant" class="nav-link">Restaurants</a>
                <a href="<%= request.getContextPath() %>/restaurant" class="nav-link">Menu</a>

                <div class="profile-wrap">

                    <button
                        class="profile-button"
                        id="profileButton"
                        type="button"
                        aria-label="Open profile menu"
                        aria-expanded="false">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <circle cx="12" cy="8" r="3.5"></circle>
                            <path d="M5 20c.8-4.1 3.1-6.2 7-6.2s6.2 2.1 7 6.2"></path>
                        </svg>
                    </button>

                    <div class="profile-menu" id="profileMenu">

                        <p id="profileStatus">
                            Welcome to Cravora.
                        </p>

                        <div id="guestOptions">
                            <a href="signup.jsp">Sign Up</a>
                            <a href="login.jsp">Login</a>
                        </div>

                        <div id="userOptions" hidden>
                            <a href="<%= request.getContextPath() %>/order">My Orders</a>
                            <a href="<%= request.getContextPath() %>/login">My Cart</a>
                            <button type="button" id="changeProfileImage">
                                Change Profile Image
                            </button>
                            <button type="button" id="logoutButton">
                                Logout
                            </button>
                        </div>

                        <input
                            id="profileImageInput"
                            type="file"
                            accept="image/*"
                            hidden>

                    </div>

                </div>
            </div>

        </nav>

        <div class="hero-content">

            <div class="hero-copy">

                <div class="eyebrow">
                    Welcome to Cravora
                </div>

                <h1>
                    YOUR NEXT<br>
                    <span class="red">CRAVING</span><br>
                    STARTS HERE.
                </h1>

                <p>
                    Discover food worth talking about. Explore restaurants,
                    find dishes that match your mood, and make every craving
                    count.
                </p>

                <div class="hero-actions">
                    <a class="primary-button" href="<%= request.getContextPath() %>/restaurant">
                        Explore Menu →
                    </a>

                    <a class="outline-button" href="<%= request.getContextPath() %>/restaurant">
                        Find Restaurants
                    </a>
                </div>

                <div class="hero-note">
                    Fresh choices · Big flavours · Made for your mood
                </div>

            </div>

        </div>

    </section>


    <main>

        <!-- =====================================================
             YOU MIGHT LIKE
        ====================================================== -->

        <section class="section likes-section" id="youMightLike">

            <div class="container">

                <div class="section-heading">

                    <div>
                        <div class="eyebrow">
                            Made for your mood
                        </div>

                        <h2 class="section-title">
                            YOU MIGHT<br>
                            <span class="red">LIKE.</span>
                        </h2>

                        <p class="section-copy">
                            A quick scroll through cravings that deserve a place
                            on your table.
                        </p>
                    </div>

                    <div class="carousel-controls">
                        <button
                            class="carousel-button"
                            id="previousDish"
                            type="button"
                            aria-label="Previous dishes">
                            ←
                        </button>

                        <button
                            class="carousel-button"
                            id="nextDish"
                            type="button"
                            aria-label="Next dishes">
                            →
                        </button>
                    </div>

                </div>

                <div class="dish-track" id="dishTrack">

                    <a class="dish-card dish-card-link" href="<%= request.getContextPath() %>/restaurant" aria-label="Browse restaurants for Royal Biryani">
                        <img src="<%= homeImage(homeRestaurants, 0, "images/restaurant-1.jpg") %>" alt="Biryani dish">
                        <div class="dish-info">
                            <small>Rich and aromatic</small>
                            <h3>Royal Biryani</h3>
                            <p>Fragrant rice, bold spices and comfort in every bite.</p>
                        </div>
                    </a>

                    <a class="dish-card dish-card-link" href="<%= request.getContextPath() %>/restaurant" aria-label="Browse restaurants for Crave Burger">
                        <img src="<%= homeImage(homeRestaurants, 1, "images/restaurant-11.jpg") %>" alt="Burger">
                        <div class="dish-info">
                            <small>Big, messy, perfect</small>
                            <h3>Crave Burger</h3>
                            <p>Juicy, loaded and made for the kind of hunger that means business.</p>
                        </div>
                    </a>

                    <a class="dish-card dish-card-link" href="<%= request.getContextPath() %>/restaurant" aria-label="Browse restaurants for Spicy Noodles">
                        <img src="<%= homeImage(homeRestaurants, 2, "images/restaurant-8.jpg") %>" alt="Noodles">
                        <div class="dish-info">
                            <small>Wok-tossed goodness</small>
                            <h3>Spicy Noodles</h3>
                            <p>Quick, fiery and packed with flavour.</p>
                        </div>
                    </a>

                    <a class="dish-card dish-card-link" href="<%= request.getContextPath() %>/restaurant" aria-label="Browse restaurants for Sweet Treats">
                        <img src="<%= homeImage(homeRestaurants, 3, "images/restaurant-9.jpg") %>" alt="Dessert">
                        <div class="dish-info">
                            <small>Finish sweetly</small>
                            <h3>Sweet Treats</h3>
                            <p>A little something extra for your happy ending.</p>
                        </div>
                    </a>

                    <a class="dish-card dish-card-link" href="<%= request.getContextPath() %>/restaurant" aria-label="Browse restaurants for Pizza Night">
                        <img src="<%= homeImage(homeRestaurants, 4, "images/restaurant-4.jpg") %>" alt="Pizza">
                        <div class="dish-info">
                            <small>Cheesy comfort</small>
                            <h3>Pizza Night</h3>
                            <p>Golden edges, generous toppings and absolutely no regrets.</p>
                        </div>
                    </a>

                    <a class="dish-card dish-card-link" href="<%= request.getContextPath() %>/restaurant" aria-label="Browse restaurants for South Spice">
                        <img src="<%= homeImage(homeRestaurants, 5, "images/restaurant-7.jpg") %>" alt="South Indian food">
                        <div class="dish-info">
                            <small>Simple. Hot. Perfect.</small>
                            <h3>South Spice</h3>
                            <p>Crisp, comforting and full of the flavours you know.</p>
                        </div>
                    </a>

                </div>

            </div>

        </section>


        <!-- =====================================================
             CURATED COLLECTIONS
        ====================================================== -->

        <section class="section collections-section">

            <div class="container">

                <div class="eyebrow">
                    01 / Collections
                </div>

                <h2 class="section-title">
                    CURATED<br>
                    <span class="red">CRAVINGS</span>
                </h2>

                <p class="section-copy">
                    The same Cravora visual language you already use across the
                    restaurant experience — kept as a short home-page discovery
                    section instead of copying the complete restaurant page.
                </p>

                <div class="collection-grid">

    <article class="collection-card" data-search="cafes">
        <img src="<%= homeImage(homeRestaurants, 6, "images/cafes.jpg") %>" alt="Cafes">
        <div class="collection-info">
            <h3>Great Cafés</h3>
            <p>Slow mornings · Coffee · Desserts →</p>
        </div>
    </article>

    <article class="collection-card" data-search="pubs bars">
        <img src="<%= homeImage(homeRestaurants, 7, "images/pubs.jpg") %>" alt="Pubs and bars">
        <div class="collection-info">
            <h3>Best Pubs & Bars</h3>
            <p>Drinks · Dinner · Nightlife →</p>
        </div>
    </article>

    <article class="collection-card" data-search="romantic">
        <img src="<%= homeImage(homeRestaurants, 8, "images/romantic.jpg") %>" alt="Romantic dining">
        <div class="collection-info">
            <h3>Romantic Dining</h3>
            <p>Date night · Fine dining · Ambience →</p>
        </div>
    </article>

    <article class="collection-card" data-search="family">
        <img src="<%= homeImage(homeRestaurants, 9, "images/family.jpg") %>" alt="Family restaurants">
        <div class="collection-info">
            <h3>Family Favourites</h3>
            <p>Big tables · Comfort food · Together →</p>
        </div>
    </article>

</div>

            </div>

        </section>


        <!-- =====================================================
             SHORT RESTAURANT PREVIEW
        ====================================================== -->

        <section class="section restaurant-preview">

            <div class="container">

                <div class="section-heading">

                    <div>
                        <div class="eyebrow">
                            02 / Explore
                        </div>

                        <h2 class="section-title">
                            FIND YOUR<br>
                            <span class="red">PLACE.</span>
                        </h2>
                    </div>

                    <p class="section-copy">
                        A small taste of the restaurant experience. The complete
                        restaurant directory stays on <strong>restaurants.</strong>.
                    </p>

                </div>

                <div class="preview-layout">

                    <article class="preview-feature">

                        <img src="<%= homeImage(homeRestaurants, 10, "images/restaurant-10.jpg") %>" alt="Restaurant dining">

                        <div class="preview-content">

                            <div class="eyebrow">
                                Cravora Picks
                            </div>

                            <h3>
                                Worth<br>
                                The<br>
                                Trip.
                            </h3>

                            <p>
                                Discover places for dinner, celebrations, quick
                                bites, coffee runs and those spontaneous “let's
                                eat” moments.
                            </p>

                            <div class="hero-actions">
                                <a class="primary-button" href="<%= request.getContextPath() %>/restaurant">
                                    Explore Restaurants →
                                </a>
                            </div>

                        </div>

                    </article>

                    <div class="preview-side">

                        <a class="preview-card" href="<%= request.getContextPath() %>/restaurant">
                            <div class="preview-number">01</div>
                            <h3>Near<br>Me</h3>
                            <p>Find restaurants around your selected location.</p>
                        </a>

                        <a class="preview-card" href="<%= request.getContextPath() %>/restaurant">
                            <div class="preview-number">02</div>
                            <h3>Top<br>Rated</h3>
                            <p>Jump into places people are already talking about.</p>
                        </a>

                        <a class="preview-card" href="<%= request.getContextPath() %>/restaurant">
                            <div class="preview-number">03</div>
                            <h3>Late<br>Night</h3>
                            <p>When the clock says late but your craving says now.</p>
                        </a>

                    </div>

                </div>

            </div>

        </section>


        <!-- =====================================================
             FEATURE BAND
        ====================================================== -->

        <section class="section feature-section">

            <div class="container">

                <div class="feature-box">

                    <img src="<%= homeImage(homeRestaurants, 11, "images/feature-food.jpg") %>" alt="Cravora featured food">

                    <div class="feature-content">

                        <div class="eyebrow">
                            Cravora Picks
                        </div>

                        <h2>
                            GOOD FOOD.<br>
                            <span class="red">NO EXCUSES.</span>
                        </h2>

                        <p>
                            From quick bites to long dinners, discover food
                            experiences worth leaving home for.
                        </p>

                    </div>

                </div>

            </div>

        </section>


        <!-- =====================================================
             FAQ
        ====================================================== -->

        <section class="section faq-section" id="faq">

            <div class="container">

                <div class="faq-header">

                    <div class="eyebrow">
                        03 / FAQ
                    </div>

                    <h2 class="section-title">
                        QUESTIONS?<br>
                        <span class="red">WE'RE HERE.</span>
                    </h2>

                    <p class="section-copy" style="margin-left:auto;margin-right:auto;">
                        Quick answers for the things you may want to know before
                        you start exploring Cravora.
                    </p>

                </div>

                <div class="faq-list">

                    <article class="faq-item">
                        <button class="faq-question" type="button">
                            <span>How do I find a restaurant?</span>
                            <span class="faq-icon">+</span>
                        </button>
                        <div class="faq-answer">
                            <p>
                                Use Restaurants in the navigation to open the full
                                restaurant experience, or use the discovery cards
                                on this page to jump directly into it.
                            </p>
                        </div>
                    </article>

                    <article class="faq-item">
                        <button class="faq-question" type="button">
                            <span>How do I order food?</span>
                            <span class="faq-icon">+</span>
                        </button>
                        <div class="faq-answer">
                            <p>
                                Open Menu, choose a restaurant, browse its dishes,
                                add items to your cart and continue through the
                                existing Cravora checkout flow.
                            </p>
                        </div>
                    </article>

                    <article class="faq-item">
                        <button class="faq-question" type="button">
                            <span>Can I save my profile image?</span>
                            <span class="faq-icon">+</span>
                        </button>
                        <div class="faq-answer">
                            <p>
                                Yes. The profile menu supports selecting a local
                                profile image and stores it in your browser for
                                this frontend experience.
                            </p>
                        </div>
                    </article>

                    <article class="faq-item">
                        <button class="faq-question" type="button">
                            <span>Is Cravora connected to a backend?</span>
                            <span class="faq-icon">+</span>
                        </button>
                        <div class="faq-answer">
                            <p>
                                This home page is frontend-only. Profile state,
                                contact submissions and similar demo interactions
                                are handled in the browser with JavaScript and
                                localStorage.
                            </p>
                        </div>
                    </article>

                </div>

            </div>

        </section>


        <!-- =====================================================
             ASK US ANYTHING / CONTACT
        ====================================================== -->

        <section class="section contact-section" id="contact">

            <div class="container">

                <div class="contact-shell">

                    <div class="contact-copy">

                        <div class="eyebrow">
                            Still have questions?
                        </div>

                        <h2>
                            ASK<br>
                            <span class="red">US.</span>
                        </h2>

                        <p>
                            Have an idea, a question, feedback about the experience,
                            or something you want Cravora to know? Type it here.
                        </p>

                    </div>

                    <form class="contact-form" id="contactForm">

                        <div class="form-row">

                            <div class="field">
                                <label for="contactName">Name</label>
                                <input
                                    id="contactName"
                                    name="name"
                                    type="text"
                                    placeholder="Your name"
                                    required>
                            </div>

                            <div class="field">
                                <label for="contactEmail">Email</label>
                                <input
                                    id="contactEmail"
                                    name="email"
                                    type="email"
                                    placeholder="you@example.com"
                                    required>
                            </div>

                        </div>

                        <div class="field">
                            <label for="contactMessage">Your question</label>
                            <textarea
                                id="contactMessage"
                                name="message"
                                placeholder="Type anything you want to ask..."
                                required></textarea>
                        </div>

                        <button class="contact-submit" type="submit">
                            Send Message →
                        </button>

                    </form>

                </div>

            </div>

        </section>


        <!-- =====================================================
             SAME CRAVORA DIRECTORY STYLE
        ====================================================== -->

        <section class="directory-section" id="explore">

            <div class="container">

                <div class="directory-header">

                    <div class="eyebrow">
                        04 / Near You
                    </div>

                    <h2 class="directory-title">
                        <span class="red">EXPLORE</span>
                    </h2>

                    <p class="directory-subtitle">
                        Open a list and jump straight into cuisines, restaurant
                        types and food experiences around you.
                    </p>

                </div>

                <div class="directory-list">

                    <article class="directory-item">

                        <button class="directory-question" type="button">
                            <span>Explore options near me</span>
                            <span class="faq-icon">+</span>
                        </button>

                        <div class="directory-answer">
                            <div class="directory-links">
                                <button type="button" data-jump="restaurants">Popular places near me</button>
                                <button type="button" data-jump="restaurants">Popular breakfast places</button>
                                <button type="button" data-jump="restaurants">Popular lunch places</button>
                                <button type="button" data-jump="restaurants">Popular dinner places</button>
                                <button type="button" data-jump="restaurants">Cafés near me</button>
                                <button type="button" data-jump="restaurants">Nightlife near me</button>
                                <button type="button" data-jump="restaurants">Delivery restaurants</button>
                                <button type="button" data-jump="restaurants">Takeaway restaurants</button>
                                <button type="button" data-jump="restaurants">Desserts near me</button>
                            </div>
                        </div>

                    </article>

                    <article class="directory-item">

                        <button class="directory-question" type="button">
                            <span>Popular cuisines near me</span>
                            <span class="faq-icon">+</span>
                        </button>

                        <div class="directory-answer">
                            <div class="directory-links">
                                <button type="button" data-jump="menu">Bakery</button>
                                <button type="button" data-jump="menu">Beverages</button>
                                <button type="button" data-jump="menu">Biryani</button>
                                <button type="button" data-jump="menu">Burger</button>
                                <button type="button" data-jump="menu">Chinese</button>
                                <button type="button" data-jump="menu">Desserts</button>
                                <button type="button" data-jump="menu">Italian</button>
                                <button type="button" data-jump="menu">North Indian</button>
                                <button type="button" data-jump="menu">South Indian</button>
                            </div>
                        </div>

                    </article>

                </div>

            </div>

        </section>


        <!-- =====================================================
             DISCOVER MORE FUN BAR
        ====================================================== -->

        <section class="discover-bar">

            <div class="container">

                <div class="filter-row">

                    <button class="filter-pill" type="button" data-message="Showing restaurants with offers.">
                        Offers
                    </button>

                    <button class="filter-pill" type="button" data-message="Showing restaurants rated 4.5+.">
                        Rating: 4.5+
                    </button>

                    <button class="filter-pill" type="button" data-message="Showing pet friendly restaurants.">
                        Pet Friendly
                    </button>

                    <button class="filter-pill" type="button" data-message="Showing outdoor seating restaurants.">
                        Outdoor Seating
                    </button>

                    <button class="filter-pill" type="button" data-message="Showing restaurants open now.">
                        Open Now
                    </button>

                </div>

                <div class="discover-dropdown">

                    <button class="discover-toggle" id="discoverToggle" type="button">
                        <span>Discover More Fun</span>
                        <span>⌄</span>
                    </button>

                    <div class="discover-menu" id="discoverMenu">

                        <button type="button" data-message="District events — coming soon">District Events</button>
                        <button type="button" data-message="Going out — coming soon">Going Out</button>
                        <button type="button" data-message="Movies — coming soon">Movies</button>
                        <button type="button" data-message="Dining out — coming soon">Dining Out</button>
                        <button type="button" data-message="Nightlife — coming soon">Nightlife</button>
                        <button type="button" data-message="Live shows — coming soon">Live Shows</button>
                        <button type="button" data-message="Sports — coming soon">Sports</button>
                        <button type="button" data-message="Activities — coming soon">Activities</button>
                        <button type="button" data-message="Newly opened — coming soon">Newly Opened</button>

                    </div>

                </div>

            </div>

        </section>


        <!-- =====================================================
             FOOTER
        ====================================================== -->

        <footer class="site-footer">

            <div class="container">

                <div class="footer-top">

                    <div class="footer-logo">
                        CRAV<span>O</span>RA
                    </div>

                    <div class="footer-selects">
                        <button class="footer-select" type="button" data-message="India selected">
                            IN INDIA ⌄
                        </button>

                        <button class="footer-select" type="button" data-message="English selected">
                            🌐 ENGLISH ⌄
                        </button>
                    </div>

                </div>

                <div class="footer-grid">

                    <div class="footer-col">
                        <h4>About Cravora</h4>
                        <button type="button" data-message="About Cravora — coming soon">About Cravora</button>
                        <button type="button" data-message="Careers — coming soon">Careers</button>
                        <button type="button" data-message="Contact — use the Ask Us section above">Contact</button>
                    </div>

                    <div class="footer-col">
                        <h4>Cravoraverse</h4>
                        <button type="button" data-message="Explore Cravoraverse — coming soon">Cravoraverse</button>
                        <button type="button" data-message="Events — coming soon">Events</button>
                        <button type="button" data-message="Community — coming soon">Community</button>
                    </div>

                    <div class="footer-col">
                        <h4>For Restaurants</h4>
                        <button type="button" data-message="Partner with Cravora — coming soon">Partner with Cravora</button>
                        <button type="button" data-message="Restaurant login — coming soon">Restaurant Login</button>
                    </div>

                    <div class="footer-col">
                        <h4>Learn More</h4>
                        <button type="button" data-message="Privacy — coming soon">Privacy</button>
                        <button type="button" data-message="Security — coming soon">Security</button>
                        <button type="button" data-message="Terms — coming soon">Terms</button>
                    </div>

                    <div class="footer-col">

                        <h4>Social Links</h4>

                        <div class="social-row">
                            <button class="social-button" type="button" data-message="LinkedIn — coming soon">in</button>
                            <button class="social-button" type="button" data-message="Instagram — coming soon">ig</button>
                            <button class="social-button" type="button" data-message="X — coming soon">x</button>
                            <button class="social-button" type="button" data-message="YouTube — coming soon">yt</button>
                            <button class="social-button" type="button" data-message="Facebook — coming soon">f</button>
                        </div>

                        <button class="store-button" type="button" data-message="App Store — coming soon">
                            Download on the App Store
                        </button>

                        <button class="store-button" type="button" data-message="Google Play — coming soon">
                            Get it on Google Play
                        </button>

                    </div>

                </div>

                <p class="footer-legal">
                    By continuing past this page, you agree to our Terms of Service,
                    Cookie Policy, Privacy Policy and Content Policies. All trademarks
                    are properties of their respective owners. 2026 © Cravora Ltd.
                    All rights reserved.
                </p>

            </div>

        </footer>


        <!-- =====================================================
             FINAL CRAVORA SCREEN
        ====================================================== -->

        <section class="final-screen">

            <img
                class="burger-image"
                src="images/imageforfinal.png"
                alt="Cravora burger artwork">

            
        </section>

    </main>


    <div class="toast" id="toast"></div>


    <script>
        "use strict";

        /* =========================================================
           SMALL HELPERS
        ========================================================== */

        const $ = (id) => document.getElementById(id);

        let toastTimer;

        function showToast(message) {
            const toast = $("toast");

            toast.textContent = message;
            toast.classList.add("show");

            clearTimeout(toastTimer);

            toastTimer = setTimeout(() => {
                toast.classList.remove("show");
            }, 2500);
        }


        /* =========================================================
           PROFILE
        ========================================================== */

        const profileButton = $("profileButton");
        const profileMenu = $("profileMenu");
        const guestOptions = $("guestOptions");
        const userOptions = $("userOptions");
        const profileStatus = $("profileStatus");
        const profileImageInput = $("profileImageInput");
        const changeProfileImage = $("changeProfileImage");
        const logoutButton = $("logoutButton");

        function getUser() {
            try {
                return JSON.parse(
                    localStorage.getItem("foodDeliveryUser") || "null"
                );
            } catch (error) {
                return null;
            }
        }

        function updateProfileMenu() {
            const user = getUser();
            const loggedIn = Boolean(user && user.name);

            guestOptions.hidden = loggedIn;
            userOptions.hidden = !loggedIn;

            profileStatus.textContent = loggedIn
                ? `Hi ${user.name}.`
                : "Welcome to Cravora.";

            profileButton.innerHTML = "";

            if (loggedIn && user.profileImage) {
                const image = document.createElement("img");
                image.src = user.profileImage;
                image.alt = "Profile image";
                profileButton.appendChild(image);
            } else {
                profileButton.innerHTML = `
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <circle cx="12" cy="8" r="3.5"></circle>
                        <path d="M5 20c.8-4.1 3.1-6.2 7-6.2s6.2 2.1 7 6.2"></path>
                    </svg>
                `;
            }
        }

        profileButton.addEventListener("click", (event) => {
            event.stopPropagation();

            const open = profileMenu.classList.toggle("show");

            profileButton.setAttribute(
                "aria-expanded",
                String(open)
            );
        });

        changeProfileImage.addEventListener("click", () => {
            profileImageInput.click();
        });

        profileImageInput.addEventListener("change", () => {
            const file = profileImageInput.files[0];

            if (!file) {
                return;
            }

            const reader = new FileReader();

            reader.onload = () => {
                const user = getUser();

                if (!user) {
                    showToast("Please create an account or log in first.");
                    return;
                }

                user.profileImage = reader.result;

                localStorage.setItem(
                    "foodDeliveryUser",
                    JSON.stringify(user)
                );

                updateProfileMenu();

                showToast("Profile image saved.");
            };

            reader.readAsDataURL(file);
        });

        logoutButton.addEventListener("click", () => {
            localStorage.removeItem("foodDeliveryUser");
            updateProfileMenu();
            profileMenu.classList.remove("show");
            showToast("Logged out of Cravora.");
        });

        document.addEventListener("click", (event) => {
            if (!profileMenu.contains(event.target) &&
                !profileButton.contains(event.target)) {
                profileMenu.classList.remove("show");
                profileButton.setAttribute("aria-expanded", "false");
            }
        });

        updateProfileMenu();


        /* =========================================================
           YOU MIGHT LIKE CAROUSEL
        ========================================================== */

        const dishTrack = $("dishTrack");

        $("previousDish").addEventListener("click", () => {
            dishTrack.scrollBy({
                left: -340,
                behavior: "smooth"
            });
        });

        $("nextDish").addEventListener("click", () => {
            dishTrack.scrollBy({
                left: 340,
                behavior: "smooth"
            });
        });


        /* =========================================================
           FAQ ACCORDION
        ========================================================== */

        document.querySelectorAll(".faq-item").forEach((item) => {

            const button = item.querySelector(".faq-question");
            const answer = item.querySelector(".faq-answer");

            button.addEventListener("click", () => {

                const isOpen = item.classList.contains("open");

                document.querySelectorAll(".faq-item").forEach((other) => {
                    other.classList.remove("open");
                    other.querySelector(".faq-answer").style.maxHeight = null;
                });

                if (!isOpen) {
                    item.classList.add("open");
                    answer.style.maxHeight = answer.scrollHeight + "px";
                }
            });
        });


        /* =========================================================
           CONTACT FORM
        ========================================================== */

        $("contactForm").addEventListener("submit", (event) => {
            event.preventDefault();

            const name = $("contactName").value.trim();
            const email = $("contactEmail").value.trim();
            const message = $("contactMessage").value.trim();

            if (!name || !email || !message) {
                showToast("Please complete all fields.");
                return;
            }

            const submission = {
                name,
                email,
                message,
                createdAt: new Date().toISOString()
            };

            try {
                const previous = JSON.parse(
                    localStorage.getItem("cravoraContactMessages") || "[]"
                );

                previous.unshift(submission);

                localStorage.setItem(
                    "cravoraContactMessages",
                    JSON.stringify(previous.slice(0, 20))
                );
            } catch (error) {
                /* Frontend demo can still complete if storage is unavailable. */
            }

            $("contactForm").reset();

            showToast(
                "Message saved. Thanks for contacting Cravora."
            );
        });


        /* =========================================================
           DIRECTORY ACCORDION
        ========================================================== */

        document.querySelectorAll(".directory-item").forEach((item) => {

            const button = item.querySelector(".directory-question");
            const answer = item.querySelector(".directory-answer");

            button.addEventListener("click", () => {

                const isOpen = item.classList.contains("open");

                document.querySelectorAll(".directory-item").forEach((other) => {
                    other.classList.remove("open");
                    other.querySelector(".directory-answer").style.maxHeight = null;
                });

                if (!isOpen) {
                    item.classList.add("open");
                    answer.style.maxHeight = answer.scrollHeight + "px";
                }
            });
        });


        /* =========================================================
           DIRECTORY LINKS
        ========================================================== */

        document.querySelectorAll("[data-jump]").forEach((button) => {

            button.addEventListener("click", () => {

                if (button.dataset.jump === "menu") {
                    window.location.href = "menu10.html";
                } else {
                    window.location.href = "restaurants.html";
                }
            });
        });


        /* =========================================================
           DISCOVER MORE FUN
        ========================================================== */

        $("discoverToggle").addEventListener("click", (event) => {

            event.stopPropagation();

            $("discoverMenu").classList.toggle("show");
        });

        document.querySelectorAll("[data-message]").forEach((button) => {

            button.addEventListener("click", () => {
                showToast(button.dataset.message);
            });
        });

        document.addEventListener("click", (event) => {

            if (!$("discoverMenu").contains(event.target) &&
                !$("discoverToggle").contains(event.target)) {
                $("discoverMenu").classList.remove("show");
            }
        });


        /* =========================================================
           COLLECTION CARDS
        ========================================================== */

        /* =========================================================
        COLLECTION CARDS
     ========================================================== */

     document.querySelectorAll(".collection-card").forEach((card) => {

         card.addEventListener("click", () => {

             const query = card.dataset.search || "";

             window.location.href = 
                 "<%= request.getContextPath() %>/restaurant?category=" + 
                 encodeURIComponent(query);
         });
     });


        /* =========================================================
           UNIVERSAL SCROLL-HOVER INITIALIZER
           ========================================================= */
        (function () {
            function initScrollHover(root) {
                const elements = root.querySelectorAll
                    ? root.querySelectorAll("button, a")
                    : [];

                elements.forEach(function (element) {
                    if (element.dataset.scrollHoverReady) return;

                    // Skip the top section dish cards entirely
                    if (element.classList.contains("dish-card") || 
                        element.classList.contains("dish-card-link")) return;

                    if (element.classList.contains("location-arrow") ||
                        element.classList.contains("modal-close")) return;

                    const text = element.textContent.trim().replace(/\s+/g, " ");
                    if (!text) return;

                    element.dataset.scrollText = element.dataset.scrollText || text;
                    element.dataset.scrollHoverReady = "true";
                    element.classList.add("scroll-hover");

                    if (element.classList.contains("nav-action")) {
                        const inner = element.querySelector(".nav-action-inner");
                        if (inner) inner.classList.add("scroll-hover-content");
                        return;
                    }

                    const content = document.createElement("span");
                    content.className = "scroll-hover-content";

                    while (element.firstChild) {
                        content.appendChild(element.firstChild);
                    }

                    element.appendChild(content);
                });
            }

            initScrollHover(document);

            const observer = new MutationObserver(function (mutations) {
                mutations.forEach(function (mutation) {
                    mutation.addedNodes.forEach(function (node) {
                        if (node.nodeType === 1) {
                            initScrollHover(node);
                        }
                    });
                });
            });

            observer.observe(document.body, {
                childList: true,
                subtree: true
            });
        })();
    </script>

</body>
</html>