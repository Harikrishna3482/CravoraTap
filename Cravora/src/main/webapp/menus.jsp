<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map, com.tap.model.Menu, com.tap.model.Cart, com.tap.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cravora | Restaurant Menu</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/navbar.css">
    <link rel="stylesheet"
      href="<%=request.getContextPath()%>/CSS/menu.css">
</head>
<body>

    <jsp:include page="includes/navbar.jsp" />

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        List<Menu> menus = (List<Menu>) request.getAttribute("menu");
        int cartCount = 0;
        if (cart != null && cart.getItems() != null) {
            for (CartItem currentItem : cart.getItems().values()) {
                cartCount += currentItem.getQuantity();
            }
        }
        Boolean showReplaceCart = (Boolean) session.getAttribute("showReplaceCart");
    %>

    <main>
        <section class="restaurant-header">
            <div class="container">
                <a class="back-button" href="<%=request.getContextPath()%>/restaurant">← Back to restaurants</a>
                <div class="restaurant-banner">
                    <div class="restaurant-banner-image">
                        <img src="<%=request.getContextPath()%>/images/Indulge.jpg" alt="Delicious food">
                    </div>
                    <div class="restaurant-details">
                        <div class="section-label">Restaurant Menu</div>
                        <h1 class="restaurant-title">YOUR<br>CRAVINGS.</h1>
                        <p class="restaurant-meta">Explore the dishes available at this restaurant.</p>
                        <div class="restaurant-stats">
                            <span class="stat rating">CRAVORA</span>
                            <span class="stat">Freshly prepared</span>
                            <span class="stat"><span class="server-cart-count"><%=cartCount%></span> items in cart</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="category-wrapper">
            <div class="container">
                <nav class="category-bar" aria-label="Menu navigation">
                    <a class="category-button active" href="#available-menu">All dishes</a>
                </nav>
            </div>
        </div>

        <section class="menu-section" id="available-menu">
            <div class="container">
                <div class="menu-layout">
                    <div class="menu-content">
                        <div class="menu-heading">
                            <div class="section-label">01 / MENU</div>
                            <h2>EAT<br><span style="color:var(--red);">WHAT</span><br>YOU LOVE.</h2>
                            <p>Explore the dishes available at this restaurant.</p>
                        </div>

                        <form class="server-menu-search" id="serverMenuSearchForm" role="search">
                            <input type="search" id="serverMenuSearch" placeholder="Search dishes in this restaurant" aria-label="Search dishes">
                            <button type="submit">SEARCH</button>
                        </form>

                        <div id="menuContainer">
                            <section class="menu-category server-menu-category" id="all-dishes">
                                <div class="category-title">
                                    <h3>ALL DISHES</h3>
                                    <span class="category-count"><%= menus == null ? 0 : menus.size() %> ITEMS</span>
                                </div>
                                <%
                                    if (menus != null && !menus.isEmpty()) {
                                        for (Menu menu : menus) {
                                            int quantity = 0;
                                            if (cart != null && cart.getItems() != null && cart.getItems().containsKey(menu.getMenuId())) {
                                                CartItem cartItem = cart.getItems().get(menu.getMenuId());
                                                quantity = cartItem.getQuantity();
                                            }
                                %>
                                <article id="menu-item-<%=menu.getMenuId()%>" class="menu-item server-menu-item" data-menu-search="<%= (menu.getItemName() + " " + (menu.getDescription() == null ? "" : menu.getDescription())).replace("\"", "&quot;").toLowerCase() %>">
                                    <div class="menu-item-info">
                                        <h4 class="item-name"><%=menu.getItemName()%></h4>
                                        <p class="item-description"><%=menu.getDescription() == null ? "" : menu.getDescription()%></p>
                                        <span class="item-price">₹<%=menu.getPrice()%></span>
                                        <span class="item-type"><span class="veg-dot"></span> MENU ITEM</span>
                                    </div>
                                    <div class="item-image-area">
                                        <img class="item-image" src="<%=menu.getImagePath()%>" alt="<%=menu.getItemName()%>" onerror="this.style.visibility='hidden'">
                                        <% if (quantity == 0) { %>
                                        <form action="<%=request.getContextPath()%>/cart" method="post" class="server-add-form">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="menuId" value="<%=menu.getMenuId()%>">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit" class="add-button">ADD</button>
                                        </form>
                                        <% } else { %>
                                        <div class="quantity-control">
                                            <form action="<%=request.getContextPath()%>/cart" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="source" value="menu">
                                                <input type="hidden" name="menuId" value="<%=menu.getMenuId()%>">
                                                <input type="hidden" name="quantity" value="<%=quantity - 1%>">
                                                <button type="submit" aria-label="Decrease <%=menu.getItemName()%> quantity">−</button>
                                            </form>
                                            <span class="quantity-value"><%=quantity%></span>
                                            <form action="<%=request.getContextPath()%>/cart" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="source" value="menu">
                                                <input type="hidden" name="menuId" value="<%=menu.getMenuId()%>">
                                                <input type="hidden" name="quantity" value="<%=quantity + 1%>">
                                                <button type="submit" aria-label="Increase <%=menu.getItemName()%> quantity">+</button>
                                            </form>
                                        </div>
                                        <% } %>
                                    </div>
                                </article>
                                <%
                                        }
                                    } else {
                                %>
                                <p class="server-empty">No menu items available.</p>
                                <% } %>
                            </section>
                        </div>
                        <p class="search-empty" id="searchEmpty">No dishes found. Try another search.</p>
                    </div>

                    <div class="cart-sidebar">
                        <div class="menu-button-wrapper" id="menuButtonWrapper">
                            <button class="menu-jump-button scroll-hover" id="menuJumpButton" type="button"
                                data-scroll-text="Menu" aria-label="Open menu" aria-expanded="false">Menu</button>
                            <div class="menu-popup" id="menuPopup" aria-label="Menu categories">
                                <div class="menu-popup-header"><span class="menu-popup-title">MENU</span></div>
                                <div class="menu-popup-items" id="menuPopupItems">
                                    <!-- Filled from menu items returned by MenuController for this restaurant -->
                                </div>
                            </div>
                        </div>
                        <aside class="cart server-cart-summary">
                            <div class="cart-header">
                                <div class="cart-label">Your order</div>
                                <h2 class="cart-title">YOUR<br>CRAVING.</h2>
                            </div>
                            <div class="cart-items">
                                <% if (cartCount == 0) { %>
                                    <div class="empty-cart">Your order is empty.<br>Add something delicious.</div>
                                <% } else { %>
                                    <p><span class="server-cart-count"><%=cartCount%></span> item(s) added to your session cart.</p>
                                <% } %>
                            </div>
                            <div class="cart-footer">
                                <div class="cart-total-row">
                                    <span class="cart-total-label">Items in cart</span>
                                    <span class="cart-total"><%=cartCount%></span>
                                </div>
                                <a class="continue-button" href="cart.jsp">CONTINUE</a>
                            </div>
                        </aside>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <section class="similar-section" id="similarSection">
        <div class="container">
            <div class="section-label-red">05 / SIMILAR RESTAURANTS</div>
            <h2 class="section-title-display">YOU MIGHT<br><span style="color:var(--red);">ALSO LIKE.</span></h2>
            <p class="section-desc">More places that match the same vibe, cuisine and experience. Explore what's nearby.</p>
            <div class="similar-grid" id="similarGrid">
                <!-- Filled by JS based on current restaurant -->
            </div>
        </div>
    </section>


    <!-- =========================================================
         NEAR YOU / EXPLORE DIRECTORY SECTION
         ========================================================= -->

    <section class="directory-section-menu" id="directorySectionMenu">
        <div class="container">
            <div class="directory-header-menu">
                <div class="section-label-red">04 / NEAR YOU</div>
                <h2 class="directory-title-menu"><span style="color:var(--red);">EXPLORE</span></h2>
                <p class="directory-subtitle-menu">Open a list and jump straight into cuisines, restaurant types, cities and locations around you.</p>
            </div>
            <div class="directory-list-menu">

                <article class="directory-item-menu">
                    <button class="directory-question-menu" type="button">
                        <span>Explore options near me</span>
                        <span class="directory-icon-menu">+</span>
                    </button>
                    <div class="directory-answer-menu">
                        <div class="directory-links-menu">
                            <button type="button" onclick="menuDirSearch('')">Popular places near me</button>
                            <button type="button" onclick="menuDirSearch('breakfast')">Popular breakfast places</button>
                            <button type="button" onclick="menuDirSearch('lunch')">Popular lunch places</button>
                            <button type="button" onclick="menuDirSearch('dinner')">Popular dinner places</button>
                            <button type="button" onclick="menuDirSearch('cafe')">Cafés near me</button>
                            <button type="button" onclick="menuDirSearch('nightlife')">Nightlife near me</button>
                            <button type="button" onclick="menuDirSearch('delivery')">Delivery restaurants</button>
                            <button type="button" onclick="menuDirSearch('takeaway')">Takeaway restaurants</button>
                            <button type="button" onclick="menuDirSearch('dessert')">Desserts near me</button>
                        </div>
                    </div>
                </article>

                <article class="directory-item-menu">
                    <button class="directory-question-menu" type="button">
                        <span>Popular cuisines near me</span>
                        <span class="directory-icon-menu">+</span>
                    </button>
                    <div class="directory-answer-menu">
                        <div class="directory-links-menu">
                            <button type="button" onclick="menuDirSearch('bakery')">Bakery near me</button>
                            <button type="button" onclick="menuDirSearch('beverages')">Beverages near me</button>
                            <button type="button" onclick="menuDirSearch('biryani')">Biryani near me</button>
                            <button type="button" onclick="menuDirSearch('burger')">Burger near me</button>
                            <button type="button" onclick="menuDirSearch('chinese')">Chinese near me</button>
                            <button type="button" onclick="menuDirSearch('continental')">Continental near me</button>
                            <button type="button" onclick="menuDirSearch('desserts')">Desserts near me</button>
                            <button type="button" onclick="menuDirSearch('ice cream')">Ice cream near me</button>
                            <button type="button" onclick="menuDirSearch('italian')">Italian near me</button>
                            <button type="button" onclick="menuDirSearch('mughlai')">Mughlai near me</button>
                            <button type="button" onclick="menuDirSearch('north indian')">North Indian near me</button>
                            <button type="button" onclick="menuDirSearch('pizza')">Pizza near me</button>
                            <button type="button" onclick="menuDirSearch('south indian')">South Indian near me</button>
                            <button type="button" onclick="menuDirSearch('street food')">Street food near me</button>
                            <button type="button" onclick="menuDirSearch('sweets')">Sweets near me</button>
                        </div>
                    </div>
                </article>

                <article class="directory-item-menu">
                    <button class="directory-question-menu" type="button">
                        <span>Popular restaurant types near me</span>
                        <span class="directory-icon-menu">+</span>
                    </button>
                    <div class="directory-answer-menu">
                        <div class="directory-links-menu">
                            <button type="button" onclick="menuDirSearch('bakery')">Bakeries</button>
                            <button type="button" onclick="menuDirSearch('bar')">Bars</button>
                            <button type="button" onclick="menuDirSearch('cafe')">Cafés</button>
                            <button type="button" onclick="menuDirSearch('casual')">Casual Dining</button>
                            <button type="button" onclick="menuDirSearch('dessert')">Dessert Parlors</button>
                            <button type="button" onclick="menuDirSearch('fine dining')">Fine Dining</button>
                            <button type="button" onclick="menuDirSearch('lounge')">Lounges</button>
                            <button type="button" onclick="menuDirSearch('nightlife')">Microbreweries</button>
                            <button type="button" onclick="menuDirSearch('quick')">Quick Bites</button>
                            <button type="button" onclick="menuDirSearch('sweets')">Sweet Shops</button>
                            <button type="button" onclick="menuDirSearch('pub')">Pubs</button>
                            <button type="button" onclick="menuDirSearch('cocktail')">Cocktail Bars</button>
                        </div>
                    </div>
                </article>

                <article class="directory-item-menu">
                    <button class="directory-question-menu" type="button">
                        <span>Explore Dining Cities at Cravora</span>
                        <span class="directory-icon-menu">+</span>
                    </button>
                    <div class="directory-answer-menu">
                        <div class="directory-links-menu">
                            <button type="button" onclick="menuShowToast('Exploring Delhi NCR')">Delhi NCR</button>
                            <button type="button" onclick="menuShowToast('Exploring Kolkata')">Kolkata</button>
                            <button type="button" onclick="menuShowToast('Exploring Mumbai')">Mumbai</button>
                            <button type="button" onclick="menuShowToast('Exploring Bengaluru')">Bengaluru</button>
                            <button type="button" onclick="menuShowToast('Exploring Pune')">Pune</button>
                            <button type="button" onclick="menuShowToast('Exploring Hyderabad')">Hyderabad</button>
                            <button type="button" onclick="menuShowToast('Exploring Chennai')">Chennai</button>
                            <button type="button" onclick="menuShowToast('Exploring Lucknow')">Lucknow</button>
                            <button type="button" onclick="menuShowToast('Exploring Kochi')">Kochi</button>
                            <button type="button" onclick="menuShowToast('Exploring Jaipur')">Jaipur</button>
                            <button type="button" onclick="menuShowToast('Exploring Ahmedabad')">Ahmedabad</button>
                            <button type="button" onclick="menuShowToast('Exploring Chandigarh')">Chandigarh</button>
                            <button type="button" onclick="menuShowToast('Exploring Goa')">Goa</button>
                            <button type="button" onclick="menuShowToast('Exploring Indore')">Indore</button>
                            <button type="button" onclick="menuShowToast('Exploring Nagpur')">Nagpur</button>
                        </div>
                    </div>
                </article>

                <article class="directory-item-menu">
                    <button class="directory-question-menu" type="button">
                        <span>Restaurants in Popular Locations</span>
                        <span class="directory-icon-menu">+</span>
                    </button>
                    <div class="directory-answer-menu">
                        <div class="directory-links-menu">
                            <button type="button" onclick="menuDirSearch('dharampeth')">Dharampeth</button>
                            <button type="button" onclick="menuDirSearch('sadar')">Sadar</button>
                            <button type="button" onclick="menuDirSearch('civil lines')">Civil Lines</button>
                            <button type="button" onclick="menuDirSearch('sitabuldi')">Sitabuldi</button>
                            <button type="button" onclick="menuDirSearch('ramdaspeth')">Ramdaspeth</button>
                            <button type="button" onclick="menuDirSearch('manish nagar')">Manish Nagar</button>
                            <button type="button" onclick="menuDirSearch('wardha')">Wardha Road</button>
                            <button type="button" onclick="menuDirSearch('pratap')">Pratap Nagar</button>
                            <button type="button" onclick="menuDirSearch('trimurti')">Trimurti Nagar</button>
                            <button type="button" onclick="menuDirSearch('laxmi')">Laxmi Nagar</button>
                            <button type="button" onclick="menuDirSearch('seminary')">Seminary Hills</button>
                            <button type="button" onclick="menuDirSearch('mahal')">Mahal</button>
                        </div>
                    </div>
                </article>

                <article class="directory-item-menu">
                    <button class="directory-question-menu" type="button">
                        <span>Discover More Fun</span>
                        <span class="directory-icon-menu">+</span>
                    </button>
                    <div class="directory-answer-menu">
                        <div class="directory-links-menu">
                            <button type="button" onclick="menuShowToast('Events near me — coming soon')">Events near me</button>
                            <button type="button" onclick="menuShowToast('Outdoor events — coming soon')">Outdoor events</button>
                            <button type="button" onclick="menuShowToast('Nightlife — coming soon')">Nightlife</button>
                            <button type="button" onclick="menuShowToast('Live music — coming soon')">Live music</button>
                            <button type="button" onclick="menuShowToast('Comedy shows — coming soon')">Comedy shows</button>
                            <button type="button" onclick="menuShowToast('Sports screenings — coming soon')">Sports screenings</button>
                            <button type="button" onclick="menuShowToast('Workshops — coming soon')">Workshops</button>
                            <button type="button" onclick="menuShowToast('Exhibitions — coming soon')">Exhibitions</button>
                            <button type="button" onclick="menuShowToast('Trending this week — coming soon')">Trending this week</button>
                        </div>
                    </div>
                </article>

            </div>
        </div>
    </section>


    <!-- =========================================================
         DISCOVER MORE FUN BAR
         ========================================================= -->

    <section class="discover-bar-menu">
        <div class="container">
            <div class="filter-row-menu">
                <button class="filter-pill-menu" type="button" onclick="menuShowToast('Filters cleared.')">Filters</button>
                <button class="filter-pill-menu" type="button" onclick="menuShowToast('Showing restaurants with offers.')">Offers</button>
                <button class="filter-pill-menu" type="button" onclick="menuShowToast('Showing restaurants rated 4.5+.')">Rating: 4.5+</button>
                <button class="filter-pill-menu" type="button" onclick="menuShowToast('Showing pet friendly restaurants.')">Pet friendly</button>
                <button class="filter-pill-menu" type="button" onclick="menuShowToast('Showing outdoor seating restaurants.')">Outdoor seating</button>
                <button class="filter-pill-menu" type="button" onclick="menuShowToast('Showing restaurants that serve alcohol.')">Serves Alcohol</button>
                <button class="filter-pill-menu" type="button" onclick="menuShowToast('Showing restaurants open now.')">Open Now</button>
            </div>
            <div class="discover-dropdown-menu">
                <button class="discover-toggle-menu" id="discoverToggleMenu" type="button">
                    Discover More Fun <span>⌄</span>
                </button>
                <div class="discover-menu-menu" id="discoverMenuMenu">
                    <button type="button" onclick="menuShowToast('District events — coming soon')">District events</button>
                    <button type="button" onclick="menuShowToast('Going out — coming soon')">Going out</button>
                    <button type="button" onclick="menuShowToast('Movies — coming soon')">Movies</button>
                    <button type="button" onclick="menuShowToast('Dining out — coming soon')">Dining out</button>
                    <button type="button" onclick="menuShowToast('Nightlife — coming soon')">Nightlife</button>
                    <button type="button" onclick="menuShowToast('Live shows — coming soon')">Live shows</button>
                    <button type="button" onclick="menuShowToast('Sports — coming soon')">Sports</button>
                    <button type="button" onclick="menuShowToast('Activities — coming soon')">Activities</button>
                    <button type="button" onclick="menuShowToast('Newly opened — coming soon')">Newly opened</button>
                </div>
            </div>
        </div>
    </section>


    <!-- =========================================================
         FOOTER
         ========================================================= -->

    <footer class="site-footer-menu">
        <div class="container">
            <div class="footer-top-menu">
                <div class="footer-logo-menu">CRAV<span>O</span>RA</div>
                <div class="footer-selects-menu">
                    <button class="footer-select-menu" type="button" onclick="menuShowToast('India is the current country.')">IN INDIA⌄</button>
                    <button class="footer-select-menu" type="button" onclick="menuShowToast('English is the current language.')">🌐 ENGLISH⌄</button>
                </div>
            </div>
            <div class="footer-grid-menu">

                <div class="footer-col-menu">
                    <h4>About Cravora</h4>
                    <button type="button" onclick="menuShowToast('Who We Are — coming soon')">Who We Are</button>
                    <button type="button" onclick="menuShowToast('Blog — coming soon')">Blog</button>
                    <button type="button" onclick="menuShowToast('Work With Us — coming soon')">Work With Us</button>
                    <button type="button" onclick="menuShowToast('Investor Relations — coming soon')">Investor Relations</button>
                    <button type="button" onclick="menuShowToast('Report Fraud — coming soon')">Report Fraud</button>
                    <button type="button" onclick="menuShowToast('Press Kit — coming soon')">Press Kit</button>
                    <button type="button" onclick="menuShowToast('Contact Us — coming soon')">Contact Us</button>
                </div>

                <div class="footer-col-menu">
                    <h4>Cravoraverse</h4>
                    <button type="button" onclick="menuShowToast('Cravora — coming soon')">Cravora</button>
                    <button type="button" onclick="menuShowToast('Blinkit — coming soon')">Blinkit</button>
                    <button type="button" onclick="menuShowToast('District — coming soon')">District</button>
                    <button type="button" onclick="menuShowToast('Feeding India — coming soon')">Feeding India</button>
                    <button type="button" onclick="menuShowToast('Hyperpure — coming soon')">Hyperpure</button>
                    <button type="button" onclick="menuShowToast('Cravora Live — coming soon')">Cravora Live</button>
                    <button type="button" onclick="menuShowToast('Zomaland — coming soon')">Zomaland</button>
                    <button type="button" onclick="menuShowToast('Weather Union — coming soon')">Weather Union</button>
                </div>

                <div class="footer-col-menu">
                    <h4>For Restaurants</h4>
                    <button type="button" onclick="menuShowToast('Partner With Us — coming soon')">Partner With Us</button>
                    <button type="button" onclick="menuShowToast('Apps For You — coming soon')">Apps For You</button>
                </div>

                <div class="footer-col-menu">
                    <h4>Learn More</h4>
                    <button type="button" onclick="menuShowToast('Privacy — coming soon')">Privacy</button>
                    <button type="button" onclick="menuShowToast('Security — coming soon')">Security</button>
                    <button type="button" onclick="menuShowToast('Terms — coming soon')">Terms</button>
                </div>

                <div class="footer-col-menu">
                    <h4>Social Links</h4>
                    <div class="social-row-menu">
                        <button class="social-btn-menu" type="button" onclick="menuShowToast('LinkedIn — coming soon')">in</button>
                        <button class="social-btn-menu" type="button" onclick="menuShowToast('Instagram — coming soon')">ig</button>
                        <button class="social-btn-menu" type="button" onclick="menuShowToast('X — coming soon')">x</button>
                        <button class="social-btn-menu" type="button" onclick="menuShowToast('YouTube — coming soon')">yt</button>
                        <button class="social-btn-menu" type="button" onclick="menuShowToast('Facebook — coming soon')">f</button>
                    </div>
                    <button class="footer-store-menu" type="button" onclick="menuShowToast('App Store — coming soon')">Download on the App Store</button>
                    <button class="footer-store-menu" type="button" onclick="menuShowToast('Google Play — coming soon')">Get it on Google Play</button>
                </div>

            </div>
            <p class="footer-legal-menu">By continuing past this page, you agree to our Terms of Service, Cookie Policy, Privacy Policy and Content Policies. All trademarks are properties of their respective owners. 2026 © Cravora Ltd. All rights reserved.</p>
        </div>
    </footer>


    <!-- =========================================================
         FINAL CRAVORA SCREEN
         ========================================================= -->

    <section class="final-screen-menu">
        <img class="burger-image-menu" src="<%=request.getContextPath()%>/images/imageforfinal.png" alt="Burger with hands">
        <div class="final-content-menu">
            <div class="final-small-menu">MADE FOR PEOPLE WHO LOVE TO EAT</div>
            <div class="final-logo-menu">CRAV<span>O</span>RA</div>
            <p class="final-tagline-menu">Find the food worth talking about. Find your next craving.</p>
        </div>
    </section>




    <% if (Boolean.TRUE.equals(showReplaceCart)) { %>
    <div class="replace-overlay" role="dialog" aria-modal="true" aria-labelledby="replaceTitle">
        <div class="replace-cart-box">
            <h2 class="replace-title" id="replaceTitle">Replace your cart?</h2>
            <p class="replace-message">Your cart contains items from another restaurant. If you continue, your existing cart will be cleared and replaced with the new item.</p>
            <div class="button-container">
                <form action="<%=request.getContextPath()%>/cart" method="post">
                    <input type="hidden" name="action" value="keep">
                    <button type="submit" class="cart-button keep-button">KEEP EXISTING CART</button>
                </form>
                <form action="<%=request.getContextPath()%>/cart" method="post">
                    <input type="hidden" name="action" value="replace">
                    <button type="submit" class="cart-button replace-button">REPLACE CART</button>
                </form>
            </div>
        </div>
    </div>
    <% } %>

    <script>
        (function () {
            const form = document.getElementById('serverMenuSearchForm');
            const input = document.getElementById('serverMenuSearch');
            const items = Array.from(document.querySelectorAll('.server-menu-item'));
            const emptyMessage = document.getElementById('searchEmpty');

            function filterItems() {
                const query = input.value.trim().toLowerCase();
                let visibleCount = 0;
                items.forEach(function (item) {
                    const text = (item.getAttribute('data-menu-search') || '').toLowerCase();
                    const visible = text.includes(query);
                    item.style.display = visible ? 'grid' : 'none';
                    if (visible) visibleCount++;
                });
                emptyMessage.classList.toggle('show', items.length > 0 && visibleCount === 0);
            }
            form.addEventListener('submit', function (event) {
                event.preventDefault();
                filterItems();
            });
            input.addEventListener('input', filterItems);
            emptyMessage.classList.remove('show');
        })();
    </script>
    <script>
        (function () {
            const wrapper = document.getElementById('menuButtonWrapper');
            const button = document.getElementById('menuJumpButton');
            const popup = document.getElementById('menuPopup');
            const popupItems = document.getElementById('menuPopupItems');
            const searchInput = document.getElementById('serverMenuSearch');
            const menuCards = Array.from(document.querySelectorAll('.server-menu-item'));

            if (!wrapper || !button || !popup || !popupItems) return;

            // Use only menu cards rendered from the selected restaurant's backend menu list.
            function buildMenuItems() {
                popupItems.innerHTML = '';

                if (menuCards.length === 0) {
                    const empty = document.createElement('p');
                    empty.className = 'server-empty';
                    empty.textContent = 'No menu items available.';
                    popupItems.appendChild(empty);
                    return;
                }

                menuCards.forEach(function (card) {
                    const nameElement = card.querySelector('.item-name');
                    const priceElement = card.querySelector('.item-price');
                    const itemName = nameElement ? nameElement.textContent.trim() : 'Menu item';
                    const itemPrice = priceElement ? priceElement.textContent.trim() : '';

                    const popupItem = document.createElement('button');
                    popupItem.type = 'button';
                    popupItem.className = 'menu-popup-item';
                    popupItem.setAttribute('data-target', card.id);

                    const name = document.createElement('span');
                    name.className = 'menu-popup-item-name';
                    name.textContent = itemName;

                    const price = document.createElement('span');
                    price.className = 'menu-popup-item-count';
                    price.textContent = itemPrice;

                    popupItem.appendChild(name);
                    popupItem.appendChild(price);
                    popupItems.appendChild(popupItem);
                });
            }

            function closeMenu() {
                popup.classList.remove('show');
                button.setAttribute('aria-expanded', 'false');
            }

            button.addEventListener('click', function (event) {
                event.stopPropagation();
                if (popup.classList.contains('show')) {
                    closeMenu();
                } else {
                    buildMenuItems();
                    popup.classList.add('show');
                    button.setAttribute('aria-expanded', 'true');
                }
            });

            popup.addEventListener('click', function (event) {
                event.stopPropagation();
                const targetButton = event.target.closest('[data-target]');
                if (!targetButton) return;

                const target = document.getElementById(targetButton.getAttribute('data-target'));
                if (target) {
                    if (searchInput) {
                        searchInput.value = '';
                        searchInput.dispatchEvent(new Event('input', { bubbles: true }));
                    }
                    target.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    target.classList.add('menu-item-highlight');
                    window.setTimeout(function () {
                        target.classList.remove('menu-item-highlight');
                    }, 1400);
                }
                closeMenu();
            });

            document.addEventListener('click', function (event) {
                if (!wrapper.contains(event.target)) closeMenu();
            });

            document.addEventListener('keydown', function (event) {
                if (event.key === 'Escape') closeMenu();
            });
        })();
    </script>
</body>
</html>
