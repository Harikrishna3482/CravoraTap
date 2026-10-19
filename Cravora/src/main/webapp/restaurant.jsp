<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, java.util.ArrayList, com.tap.model.Restaurant"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cravora | Discover Restaurants</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@600;700;800&family=Inter:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/CSS/restaurant.css?v=20261011">
</head>
<body>
	<%
	// All food photography on this page is sourced from imagePath values
	// already returned by the backend restaurants list.
	List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
	List<String> backendImagePaths = new ArrayList<String>();
	if (restaurants != null) {
		for (Restaurant imageRestaurant : restaurants) {
			String imagePath = imageRestaurant.getImagePath() == null ? "" : imageRestaurant.getImagePath().trim();
			if (!imagePath.isEmpty() && !imagePath.startsWith("http://") && !imagePath.startsWith("https://")
			&& !imagePath.startsWith("data:")) {
		if (!imagePath.startsWith("/"))
			imagePath = "/" + imagePath;
		String contextPath = request.getContextPath();
		if (!imagePath.startsWith(contextPath + "/") && !imagePath.equals(contextPath)) {
			imagePath = contextPath + imagePath;
		}
			}
			if (!imagePath.isEmpty())
		backendImagePaths.add(imagePath);
		}
	}
	String heroBackendImage = backendImagePaths.size() > 0 ? backendImagePaths.get(0) : "";
	String collectionImage1 = backendImagePaths.size() > 1 ? backendImagePaths.get(1) : heroBackendImage;
	String collectionImage2 = backendImagePaths.size() > 2 ? backendImagePaths.get(2) : heroBackendImage;
	String collectionImage3 = backendImagePaths.size() > 3 ? backendImagePaths.get(3) : heroBackendImage;
	String collectionImage4 = backendImagePaths.size() > 4 ? backendImagePaths.get(4) : heroBackendImage;
	String featureBackendImage = backendImagePaths.size() > 5 ? backendImagePaths.get(5) : heroBackendImage;
	String finalBackendImage = backendImagePaths.size() > 6 ? backendImagePaths.get(6) : heroBackendImage;
	%>
	<header class="navbar">
		<div class="nav-inner">
			<a href="/restaurant" class="brand" id="homeButton">CRAVORA<span
				class="brand-dot"></span></a>
			<div class="location-wrapper">
				<div class="location-control">
					<div class="location-pin">
						<img src="<%=request.getContextPath()%>/images/location.svg"
							alt="Location">
					</div>
					<input type="text" id="locationInput" class="location-input"
						placeholder="Search your location" autocomplete="off">
					<button type="button" class="location-arrow" id="locationArrow"
						aria-label="Open location options">
						<span><img
							src="<%=request.getContextPath()%>/images/down-arrow-svgrepo-com (2).svg"
							alt="Location"></span>
					</button>
				</div>
				<div class="location-menu" id="locationMenu">
					<button type="button" class="location-option current-location"
						id="useCurrentLocation">
						<img src="<%=request.getContextPath()%>/images/location.svg"
							alt="Location"> Use current location
					</button>
					<button type="button" class="location-option"
						data-location="Nagpur, Maharashtra">Nagpur, Maharashtra</button>
					<button type="button" class="location-option"
						data-location="Mumbai, Maharashtra">Mumbai, Maharashtra</button>
					<button type="button" class="location-option"
						data-location="Pune, Maharashtra">Pune, Maharashtra</button>
					<button type="button" class="location-option"
						data-location="Bengaluru, Karnataka">Bengaluru, Karnataka</button>
					<button type="button" class="location-option"
						data-location="Hyderabad, Telangana">Hyderabad, Telangana</button>
					<button type="button" class="location-option"
						data-location="Delhi, India">Delhi, India</button>
				</div>
			</div>
			<form class="nav-search" id="restaurantSearchForm">
				<div class="search-icon">⌕</div>
				<input type="search" id="restaurantSearch"
					placeholder="Search for restaurant, cuisine or a dish">
				<button type="submit" aria-label="Search">→</button>
			</form>

			<!-- Log In Form -->
			<form action="<%=request.getContextPath()%>/login" method="post"
				style="display: inline;">
				<button type="submit" class="nav-action">
					<span class="nav-action-inner"> <span
						class="nav-action-text original">Log in</span> <span
						class="nav-action-text clone">Log in</span>
					</span>
				</button>
			</form>

			<!-- Sign Up Form (if you want it to be POST as well) -->
			<form action="<%=request.getContextPath()%>/signup" method="post"
				style="display: inline;">
				<button type="submit" class="nav-action nav-signup">
					<span class="nav-action-inner"> <span
						class="nav-action-text original">Sign up</span> <span
						class="nav-action-text clone">Sign up</span>
					</span>
				</button>
			</form>
		</div>
	</header>

	<main>
		<section class="hero">
			<div class="hero-inner">
				<div class="hero-copy">
					<div class="hero-eyebrow">YOUR CITY. YOUR CRAVINGS.</div>
					<h1 class="hero-title">
						FIND<br> <span class="red">GOOD</span><br>FOOD.
					</h1>
					<p class="hero-text">Discover restaurants, cafés, bars and
						unforgettable dishes around you. Search above and let Cravora lead
						you to your next craving.</p>
				</div>
				<div class="hero-art">
					<img src="<%=heroBackendImage%>"
						alt="Food from Cravora restaurants"
						onerror="this.style.display='none'">
				</div>
			</div>
		</section>

		<section class="location-status">
			<div class="container location-status-inner">
				<div class="location-current">
					You're exploring: <strong id="currentLocationText">Nagpur,
						Maharashtra</strong>
				</div>
				<button class="status-button" id="changeLocationButton">Change
					location</button>
			</div>
		</section>

		<section class="section collections-section">
			<div class="container">
				<div class="section-label">01 / COLLECTIONS</div>
				<h2 class="section-title">
					CURATED<br> <span class="red">CRAVINGS</span>
				</h2>
				<p class="section-description">Explore curated restaurant
					collections for every mood, occasion and appetite.</p>
				<div class="collection-grid">
					<article class="collection-card" data-collection="cafes"
						tabindex="0" role="button">
						<img src="<%=collectionImage1%>" alt="Cafes"
							onerror="this.style.display='none'">
						<div class="collection-content">
							<h3>Great Cafés</h3>
							<p>12 places →</p>
						</div>
					</article>
					<article class="collection-card" data-collection="pubs"
						tabindex="0" role="button">
						<img src="<%=collectionImage2%>" alt="Pubs and bars"
							onerror="this.style.display='none'">
						<div class="collection-content">
							<h3>Best Pubs & Bars</h3>
							<p>18 places →</p>
						</div>
					</article>
					<article class="collection-card" data-collection="romantic"
						tabindex="0" role="button">
						<img src="<%=collectionImage3%>" alt="Romantic dining"
							onerror="this.style.display='none'">
						<div class="collection-content">
							<h3>Romantic Dining</h3>
							<p>10 places →</p>
						</div>
					</article>
					<article class="collection-card" data-collection="family"
						tabindex="0" role="button">
						<img src="<%=collectionImage4%>" alt="Family restaurants"
							onerror="this.style.display='none'">
						<div class="collection-content">
							<h3>Family Favourites</h3>
							<p>15 places →</p>
						</div>
					</article>
				</div>
			</div>
		</section>

		<section class="section restaurants-section" id="restaurantsSection">
			<div class="container">
				<div class="section-label">02 / RESTAURANTS</div>
				<h2 class="section-title">
					EAT<br> <span class="red">SOMETHING</span><br>GOOD.
				</h2>
				<p class="section-description">Handpicked places to eat, drink
					and hang out. Search the navbar to filter this list.</p>
				<div class="restaurant-grid" id="restaurantGrid">
					<%
					if (restaurants != null && !restaurants.isEmpty()) {
						for (Restaurant restaurant : restaurants) {
							String restaurantName = restaurant.getName() == null ? "" : restaurant.getName();
							String cuisine = restaurant.getCuisineType() == null ? "" : restaurant.getCuisineType();
							String address = restaurant.getAddress() == null ? "" : restaurant.getAddress();
							String searchText = (restaurantName + " " + cuisine + " " + address).toLowerCase();

							// Use the image path supplied by the restaurants table.
							// Absolute URLs stay unchanged; project-relative paths get the context path.
							String restaurantImagePath = restaurant.getImagePath() == null ? "" : restaurant.getImagePath().trim();
							if (!restaurantImagePath.isEmpty() && !restaurantImagePath.startsWith("http://")
							&& !restaurantImagePath.startsWith("https://") && !restaurantImagePath.startsWith("data:")) {
						if (!restaurantImagePath.startsWith("/")) {
							restaurantImagePath = "/" + restaurantImagePath;
						}
						if (!restaurantImagePath.startsWith(request.getContextPath() + "/")
								&& !restaurantImagePath.equals(request.getContextPath())) {
							restaurantImagePath = request.getContextPath() + restaurantImagePath;
						}
							}
					%>
					<article class="restaurant-card"
						data-search="<%=searchText.replace("\"", "&quot;")%>"
						data-rating="<%=restaurant.getRating()%>" data-tags=""
						data-collection="all">
						<div class="restaurant-image">
							<img src="<%=restaurantImagePath%>"
								alt="<%=restaurantName.replace("\"", "&quot;")%>" loading="lazy"
								onerror="this.onerror=null; this.closest('.restaurant-image').classList.add('image-unavailable'); this.style.display='none';">
						</div>
						<div class="restaurant-info">
							<h3 class="restaurant-name"><%=restaurantName%></h3>
							<p class="restaurant-meta"><%=cuisine%><br><%=address%></p>
							<span class="restaurant-rating"><%=restaurant.getRating()%>
								★</span>
							<div class="restaurant-bottom">
								<span class="restaurant-price"><%=restaurant.getDeliveryTime()%>
									mins delivery</span> <a class="view-button"
									href="<%=request.getContextPath()%>/menu?restaurantId=<%=restaurant.getRestaurantId()%>">View</a>
							</div>
						</div>
					</article>
					<%
					}
					} else {
					%>
					<div class="no-restaurants"
						style="grid-column: 1/-1; text-align: center; padding: 35px 20px;">
						<div class="section-label">CRAVORA</div>
						<h2>
							NO RESTAURANTS <span class="red">AVAILABLE.</span>
						</h2>
						<p>We couldn't find any restaurants right now. Please check
							again shortly.</p>
					</div>
					<%
					}
					%>
				</div>
				<p id="noResults"
					style="display: none; margin-top: 30px; color: #ffc7c6; font-size: 18px;">No
					restaurants found. Try another restaurant, cuisine or dish.</p>
			</div>
		</section>

		<section class="section explore-section">
			<div class="container">
				<div class="section-label">03 / EXPLORE</div>
				<h2 class="section-title">
					FOLLOW<br>THE <span class="red">CRAVING.</span>
				</h2>
				<p class="section-description">Whatever you're hungry for, start
					somewhere.</p>
				<div class="explore-grid">
					<button class="explore-card" data-explore="Nearby">
						<span class="explore-number">01</span>
						<h3>
							Near<br>Me
						</h3>
						<span class="explore-arrow">↗</span>
					</button>
					<button class="explore-card" data-explore="Top Rated">
						<span class="explore-number">02</span>
						<h3>
							Top<br>Rated
						</h3>
						<span class="explore-arrow">↗</span>
					</button>
					<button class="explore-card" data-explore="Late Night">
						<span class="explore-number">03</span>
						<h3>
							Late<br>Night
						</h3>
						<span class="explore-arrow">↗</span>
					</button>
					<button class="explore-card" data-explore="New Places">
						<span class="explore-number">04</span>
						<h3>
							New<br>Places
						</h3>
						<span class="explore-arrow">↗</span>
					</button>
				</div>
			</div>
		</section>

		<section class="feature-section">
			<div class="container">
				<div class="feature-box">
					<img class="feature-image" src="<%=featureBackendImage%>"
						alt="Featured food from Cravora restaurants"
						onerror="this.style.display='none'">
					<div class="feature-content">
						<div class="section-label">CRAVORA PICKS</div>
						<h2 class="feature-title">
							GOOD FOOD.<br> <span class="red">NO EXCUSES.</span>
						</h2>
						<p class="feature-copy">From quick bites to long dinners, find
							places worth leaving home for.</p>
					</div>
				</div>
			</div>
		</section>

		<section class="directory-section" id="directorySection">
			<div class="container">
				<div class="directory-header">
					<div class="section-label">04 / NEAR YOU</div>
					<h2 class="directory-title">
						<span class="red">EXPLORE</span>
					</h2>
					<p class="directory-subtitle">Open a list and jump straight
						into cuisines, restaurant types, cities and locations around you.</p>
				</div>
				<div class="directory-list">
					<article class="directory-item">
						<button class="directory-question" type="button">
							<span>Explore options near me</span><span class="directory-icon">+</span>
						</button>
						<div class="directory-answer">
							<div class="directory-links">
								<button type="button" data-jump="search" data-query="">Popular
									places near me</button>
								<button type="button" data-jump="search" data-query="breakfast">Popular
									breakfast places</button>
								<button type="button" data-jump="search" data-query="lunch">Popular
									lunch places</button>
								<button type="button" data-jump="search" data-query="dinner">Popular
									dinner places</button>
								<button type="button" data-jump="search" data-query="cafe">Cafés
									near me</button>
								<button type="button" data-jump="search" data-query="nightlife">Nightlife
									near me</button>
								<button type="button" data-jump="search" data-query="delivery">Delivery
									restaurants</button>
								<button type="button" data-jump="search" data-query="takeaway">Takeaway
									restaurants</button>
								<button type="button" data-jump="search" data-query="dessert">Desserts
									near me</button>
							</div>
						</div>
					</article>
					<article class="directory-item">
						<button class="directory-question" type="button">
							<span>Popular cuisines near me</span><span class="directory-icon">+</span>
						</button>
						<div class="directory-answer">
							<div class="directory-links">
								<button type="button" data-jump="search" data-query="bakery">Bakery
									near me</button>
								<button type="button" data-jump="search" data-query="beverages">Beverages
									near me</button>
								<button type="button" data-jump="search" data-query="biryani">Biryani
									near me</button>
								<button type="button" data-jump="search" data-query="burger">Burger
									near me</button>
								<button type="button" data-jump="search" data-query="chinese">Chinese
									near me</button>
								<button type="button" data-jump="search"
									data-query="continental">Continental near me</button>
								<button type="button" data-jump="search" data-query="desserts">Desserts
									near me</button>
								<button type="button" data-jump="search" data-query="ice cream">Ice
									cream near me</button>
								<button type="button" data-jump="search" data-query="italian">Italian
									near me</button>
								<button type="button" data-jump="search" data-query="mughlai">Mughlai
									near me</button>
								<button type="button" data-jump="search"
									data-query="north indian">North Indian near me</button>
								<button type="button" data-jump="search" data-query="pizza">Pizza
									near me</button>
								<button type="button" data-jump="search"
									data-query="south indian">South Indian near me</button>
								<button type="button" data-jump="search"
									data-query="street food">Street food near me</button>
								<button type="button" data-jump="search" data-query="sweets">Sweets
									near me</button>
							</div>
						</div>
					</article>
					<article class="directory-item">
						<button class="directory-question" type="button">
							<span>Popular restaurant types near me</span><span
								class="directory-icon">+</span>
						</button>
						<div class="directory-answer">
							<div class="directory-links">
								<button type="button" data-jump="search" data-query="bakery">Bakeries</button>
								<button type="button" data-jump="search" data-query="bar">Bars</button>
								<button type="button" data-jump="search" data-query="cafe">Cafés</button>
								<button type="button" data-jump="search" data-query="casual">Casual
									Dining</button>
								<button type="button" data-jump="search" data-query="dessert">Dessert
									Parlors</button>
								<button type="button" data-jump="search"
									data-query="fine dining">Fine Dining</button>
								<button type="button" data-jump="search" data-query="lounge">Lounges</button>
								<button type="button" data-jump="search" data-query="nightlife">Microbreweries</button>
								<button type="button" data-jump="search" data-query="quick">Quick
									Bites</button>
								<button type="button" data-jump="search" data-query="sweets">Sweet
									Shops</button>
								<button type="button" data-jump="search" data-query="pub">Pubs</button>
								<button type="button" data-jump="search" data-query="cocktail">Cocktail
									Bars</button>
							</div>
						</div>
					</article>
					<article class="directory-item">
						<button class="directory-question" type="button">
							<span>Explore Dining Cities at Cravora</span><span
								class="directory-icon">+</span>
						</button>
						<div class="directory-answer">
							<div class="directory-links">
								<button type="button" data-city="Delhi, India">Delhi
									NCR</button>
								<button type="button" data-city="Kolkata, West Bengal">Kolkata</button>
								<button type="button" data-city="Mumbai, Maharashtra">Mumbai</button>
								<button type="button" data-city="Bengaluru, Karnataka">Bengaluru</button>
								<button type="button" data-city="Pune, Maharashtra">Pune</button>
								<button type="button" data-city="Hyderabad, Telangana">Hyderabad</button>
								<button type="button" data-city="Chennai, Tamil Nadu">Chennai</button>
								<button type="button" data-city="Lucknow, Uttar Pradesh">Lucknow</button>
								<button type="button" data-city="Kochi, Kerala">Kochi</button>
								<button type="button" data-city="Jaipur, Rajasthan">Jaipur</button>
								<button type="button" data-city="Ahmedabad, Gujarat">Ahmedabad</button>
								<button type="button" data-city="Chandigarh, India">Chandigarh</button>
								<button type="button" data-city="Goa, India">Goa</button>
								<button type="button" data-city="Indore, Madhya Pradesh">Indore</button>
								<button type="button" data-city="Nagpur, Maharashtra">Nagpur</button>
							</div>
						</div>
					</article>
					<article class="directory-item">
						<button class="directory-question" type="button">
							<span>Restaurants in Popular Locations</span><span
								class="directory-icon">+</span>
						</button>
						<div class="directory-answer">
							<div class="directory-links">
								<button type="button" data-jump="search" data-query="dharampeth">Dharampeth</button>
								<button type="button" data-jump="search" data-query="sadar">Sadar</button>
								<button type="button" data-jump="search"
									data-query="civil lines">Civil Lines</button>
								<button type="button" data-jump="search" data-query="sitabuldi">Sitabuldi</button>
								<button type="button" data-jump="search" data-query="ramdaspeth">Ramdaspeth</button>
								<button type="button" data-jump="search"
									data-query="manish nagar">Manish Nagar</button>
								<button type="button" data-jump="search" data-query="wardha">Wardha
									Road</button>
								<button type="button" data-jump="search" data-query="pratap">Pratap
									Nagar</button>
								<button type="button" data-jump="search" data-query="trimurti">Trimurti
									Nagar</button>
								<button type="button" data-jump="search" data-query="laxmi">Laxmi
									Nagar</button>
								<button type="button" data-jump="search" data-query="seminary">Seminary
									Hills</button>
								<button type="button" data-jump="search" data-query="mahal">Mahal</button>
							</div>
						</div>
					</article>
					<article class="directory-item">
						<button class="directory-question" type="button">
							<span>Discover More Fun</span><span class="directory-icon">+</span>
						</button>
						<div class="directory-answer">
							<div class="directory-links">
								<button type="button" data-fun="Events near me">Events
									near me</button>
								<button type="button" data-fun="Outdoor events">Outdoor
									events</button>
								<button type="button" data-fun="Nightlife">Nightlife</button>
								<button type="button" data-fun="Live music">Live music</button>
								<button type="button" data-fun="Comedy shows">Comedy
									shows</button>
								<button type="button" data-fun="Sports screenings">Sports
									screenings</button>
								<button type="button" data-fun="Workshops">Workshops</button>
								<button type="button" data-fun="Exhibitions">Exhibitions</button>
								<button type="button" data-fun="Trending this week">Trending
									this week</button>
							</div>
						</div>
					</article>
				</div>
			</div>
		</section>
	</main>

	<section class="discover-bar">
		<div class="container">
			<div class="filter-row">
				<button class="filter-pill" data-filter="all" type="button">Filters</button>
				<button class="filter-pill" data-filter="offers" type="button">Offers</button>
				<button class="filter-pill" data-filter="rating" type="button">Rating:
					4.5+</button>
				<button class="filter-pill" data-filter="pet" type="button">Pet
					friendly</button>
				<button class="filter-pill" data-filter="outdoor" type="button">Outdoor
					seating</button>
				<button class="filter-pill" data-filter="alcohol" type="button">Serves
					Alcohol</button>
				<button class="filter-pill" data-filter="open" type="button">Open
					Now</button>
			</div>
			<div class="discover-dropdown">
				<button class="discover-toggle" id="discoverToggle" type="button">
					Discover More Fun <span>⌄</span>
				</button>
				<div class="discover-menu" id="discoverMenu">
					<button type="button" data-fun="District events">District
						events</button>
					<button type="button" data-fun="Going out">Going out</button>
					<button type="button" data-fun="Movies">Movies</button>
					<button type="button" data-fun="Dining out">Dining out</button>
					<button type="button" data-fun="Nightlife">Nightlife</button>
					<button type="button" data-fun="Live shows">Live shows</button>
					<button type="button" data-fun="Sports">Sports</button>
					<button type="button" data-fun="Activities">Activities</button>
					<button type="button" data-fun="Newly opened">Newly opened</button>
				</div>
			</div>
		</div>
	</section>

	<footer class="site-footer">
		<div class="container">
			<div class="footer-top">
				<div class="footer-logo">
					CRAV<span>O</span>RA
				</div>
				<div class="footer-selects">
					<button class="footer-select" id="countryButton" type="button">🇮🇳
						India ⌄</button>
					<button class="footer-select" id="languageButton" type="button">🌐
						English ⌄</button>
				</div>
			</div>
			<div class="footer-grid">
				<div class="footer-col">
					<h4>About Cravora</h4>
					<button type="button">Who We Are</button>
					<button type="button">Blog</button>
					<button type="button">Work With Us</button>
					<button type="button">Investor Relations</button>
					<button type="button">Report Fraud</button>
					<button type="button">Press Kit</button>
					<button type="button">Contact Us</button>
				</div>
				<div class="footer-col">
					<h4>Cravoraverse</h4>
					<button type="button">Cravora</button>
					<button type="button">Blinkit</button>
					<button type="button">District</button>
					<button type="button">Feeding India</button>
					<button type="button">Hyperpure</button>
					<button type="button">Cravora Live</button>
					<button type="button">Zomaland</button>
					<button type="button">Weather Union</button>
				</div>
				<div class="footer-col">
					<h4>For Restaurants</h4>
					<button type="button">Partner With Us</button>
					<button type="button">Apps For You</button>
				</div>
				<div class="footer-col">
					<h4>Learn More</h4>
					<button type="button">Privacy</button>
					<button type="button">Security</button>
					<button type="button">Terms</button>
				</div>
				<div class="footer-col">
					<h4>Social Links</h4>
					<div class="social-row">
						<button class="social-btn" type="button">in</button>
						<button class="social-btn" type="button">ig</button>
						<button class="social-btn" type="button">x</button>
						<button class="social-btn" type="button">yt</button>
						<button class="social-btn" type="button">f</button>
					</div>
					<button class="footer-store" type="button">Download on the
						App Store</button>
					<button class="footer-store" type="button">Get it on
						Google Play</button>
				</div>
			</div>
			<p class="footer-legal">By continuing past this page, you agree
				to our Terms of Service, Cookie Policy, Privacy Policy and Content
				Policies. All trademarks are properties of their respective owners.
				2026 © Cravora Ltd. All rights reserved.</p>
		</div>
	</footer>

	<section class="final-screen">
		<img class="burger-image" src="images/imageforfinal.png"
			alt="Food from Cravora restaurants"
			onerror="this.style.display='none'">
		<div class="final-content">
			<div class="final-small">MADE FOR PEOPLE WHO LOVE TO EAT</div>
			<div class="final-logo">
				CRAV<span>O</span>RA
			</div>
			<p class="final-tagline">Find the food worth talking about. Find
				your next craving.</p>
		</div>
	</section>

	<div class="modal" id="restaurantModal">
		<div class="modal-box">
			<button class="modal-close" data-close-modal aria-label="Close">×</button>
			<div class="section-label">RESTAURANT</div>
			<h2 class="modal-title" id="restaurantModalTitle">Restaurant</h2>
			<p class="modal-text">Restaurant details can be connected to your
				backend here. This button is already functional and can later open a
				restaurant detail page.</p>
			<button class="primary-fill" data-close-modal>Continue
				Exploring</button>
		</div>
	</div>

	<div class="modal" id="exploreModal">
		<div class="modal-box">
			<button class="modal-close" data-close-modal>×</button>
			<div class="section-label">EXPLORE</div>
			<h2 class="modal-title" id="exploreModalTitle">Explore</h2>
			<p class="modal-text" id="exploreModalText">Discover more places
				around you.</p>
		</div>
	</div>

	<div class="modal" id="loginModal">
		<div class="modal-box">
			<button class="modal-close" data-close-modal>×</button>
			<div class="section-label">WELCOME BACK</div>
			<h2 class="modal-title">LOG IN</h2>
			<p class="modal-text">Log in to continue exploring your favourite
				food spots.</p>
			<form class="modal-form" id="loginForm">
				<input type="email" placeholder="Enter your email" required>
				<button type="submit">Log in</button>
			</form>
		</div>
	</div>

	<div class="modal" id="signupModal">
		<div class="modal-box">
			<button class="modal-close" data-close-modal>×</button>
			<div class="section-label">JOIN CRAVORA</div>
			<h2 class="modal-title">SIGN UP</h2>
			<p class="modal-text">Create your account and start discovering
				your next favourite restaurant.</p>
			<form class="modal-form" id="signupForm">
				<input type="email" placeholder="Enter your email" required>
				<button type="submit">Create account</button>
			</form>
		</div>
	</div>

	<div class="toast" id="toast"></div>

	<script>
        const toast = document.getElementById("toast");
        let toastTimer;

        function showToast(message) {
            toast.textContent = message;
            toast.classList.add("show");
            clearTimeout(toastTimer);
            toastTimer = setTimeout(() => toast.classList.remove("show"), 3000);
        }

        function applyScrollEffectToButtons() {
            document.querySelectorAll("button").forEach((btn) => {
                if (btn.querySelector(":scope > .nav-action-inner")) return;
                const html = btn.innerHTML;
                btn.innerHTML =
                    '<span class="nav-action-inner">' +
                    '<span class="nav-action-text original">' + html + "</span>" +
                    '<span class="nav-action-text clone">' + html + "</span>" +
                    "</span>";
                btn.classList.add("scroll-btn");
            });
        }

        applyScrollEffectToButtons();

        document.getElementById("homeButton").addEventListener("click", function (event) {
            event.preventDefault();
            window.scrollTo({ top: 0, behavior: "smooth" });
        });

        const locationArrow = document.getElementById("locationArrow");
        const locationMenu = document.getElementById("locationMenu");
        const locationInput = document.getElementById("locationInput");
        const currentLocationText = document.getElementById("currentLocationText");

        function openLocationMenu() {
            locationMenu.classList.add("show");
            locationArrow.classList.add("open");
        }

        function closeLocationMenu() {
            locationMenu.classList.remove("show");
            locationArrow.classList.remove("open");
        }

        function setLocation(value) {
            locationInput.value = value;
            currentLocationText.textContent = value;
            closeLocationMenu();
            showToast("Location changed to " + value);
        }

        locationArrow.addEventListener("click", function (event) {
            event.stopPropagation();
            if (locationMenu.classList.contains("show")) closeLocationMenu();
            else openLocationMenu();
        });

        locationInput.addEventListener("focus", openLocationMenu);

        document.querySelectorAll(".location-option[data-location]").forEach((option) => {
            option.addEventListener("click", function () {
                setLocation(this.dataset.location);
            });
        });

        locationInput.addEventListener("keydown", function (event) {
            if (event.key !== "Enter") return;
            event.preventDefault();
            const value = locationInput.value.trim();
            if (!value) {
                showToast("Please enter a location.");
                return;
            }
            currentLocationText.textContent = value;
            closeLocationMenu();
            showToast("Searching restaurants near " + value);
        });

        document.getElementById("useCurrentLocation").addEventListener("click", function () {
            if (!navigator.geolocation) {
                showToast("Location services are not supported by this browser.");
                return;
            }
            showToast("Requesting your current location...");
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    const gpsText =
                        "Current location (" +
                        position.coords.latitude.toFixed(4) +
                        ", " +
                        position.coords.longitude.toFixed(4) +
                        ")";
                    locationInput.value = gpsText;
                    currentLocationText.textContent = gpsText;
                    closeLocationMenu();
                    showToast("Current location detected.");
                },
                function (error) {
                    let message = "Unable to get your location.";
                    if (error.code === 1) message = "Location permission was denied.";
                    if (error.code === 2) message = "Your location could not be determined.";
                    if (error.code === 3) message = "Location request timed out.";
                    showToast(message);
                },
                { enableHighAccuracy: true, timeout: 10000, maximumAge: 60000 }
            );
        });

        document.getElementById("changeLocationButton").addEventListener("click", function () {
            openLocationMenu();
            locationInput.focus();
        });

        document.addEventListener("click", function (event) {
            const wrapper = document.querySelector(".location-wrapper");
            if (!wrapper.contains(event.target)) closeLocationMenu();
            const discover = document.querySelector(".discover-dropdown");
            if (discover && !discover.contains(event.target)) {
                document.getElementById("discoverMenu").classList.remove("show");
            }
        });

        const searchInput = document.getElementById("restaurantSearch");
        const restaurantCards = document.querySelectorAll(".restaurant-card");
        const noResults = document.getElementById("noResults");
        let activeFilters = new Set();

        function searchRestaurants(query) {
            const normalized = query.trim().toLowerCase();
            let visibleCount = 0;

            restaurantCards.forEach((card) => {
                const searchData = (card.dataset.search || "").toLowerCase();
                const rating = parseFloat(card.dataset.rating || "0");
                const tags = card.dataset.tags || "";
                let matches = normalized === "" || searchData.includes(normalized);

                if (matches && activeFilters.has("rating") && rating < 4.5) matches = false;
                if (matches && activeFilters.has("offers") && !tags.includes("offers")) matches = false;
                if (matches && activeFilters.has("pet") && !tags.includes("pet")) matches = false;
                if (matches && activeFilters.has("outdoor") && !tags.includes("outdoor")) matches = false;
                if (matches && activeFilters.has("alcohol") && !tags.includes("alcohol")) matches = false;
                if (matches && activeFilters.has("open") && !tags.includes("open")) matches = false;

                card.style.display = matches ? "" : "none";
                if (matches) visibleCount++;
            });

            noResults.style.display = visibleCount === 0 ? "block" : "none";
        }

        function showCollection(collectionCard) {
            const collection = collectionCard.dataset.collection;
            const collectionName = collectionCard.querySelector("h3").textContent;
            let visibleCount = 0;

            searchInput.value = "";
            activeFilters.clear();
            document.querySelectorAll(".filter-pill").forEach((pill) => pill.classList.remove("active"));
            document.querySelector('.filter-pill[data-filter="all"]').classList.add("active");

            restaurantCards.forEach((card) => {
                const belongsToCollection = card.dataset.collection && card.dataset.collection.split(" ").includes(collection);
                card.style.display = belongsToCollection ? "" : "none";
                if (belongsToCollection) visibleCount++;
            });

            noResults.style.display = visibleCount === 0 ? "block" : "none";
            document.getElementById("restaurantsSection").scrollIntoView({ behavior: "smooth" });
            showToast(collectionName + " selected.");
        }

        document.querySelectorAll(".collection-card").forEach((card) => {
            card.addEventListener("click", function () {
                showCollection(this);
            });

            card.addEventListener("keydown", function (event) {
                if (event.key !== "Enter" && event.key !== " ") return;
                event.preventDefault();
                showCollection(this);
            });
        });

        searchInput.addEventListener("input", function () {
            searchRestaurants(this.value);
        });

        document.getElementById("restaurantSearchForm").addEventListener("submit", function (event) {
            event.preventDefault();
            searchRestaurants(searchInput.value.trim());
            document.getElementById("restaurantsSection").scrollIntoView({ behavior: "smooth" });
        });

        const restaurantModal = document.getElementById("restaurantModal");
        const restaurantModalTitle = document.getElementById("restaurantModalTitle");

        // View links are normal links to the existing MenuController (/menu?restaurantId=...).
        // Do not override the link with the standalone reference HTML route.


        const exploreModal = document.getElementById("exploreModal");
        const exploreModalTitle = document.getElementById("exploreModalTitle");
        const exploreModalText = document.getElementById("exploreModalText");

        document.querySelectorAll(".explore-card").forEach((card) => {
            card.addEventListener("click", function () {
                const name = this.dataset.explore;
                exploreModalTitle.textContent = name;
                exploreModalText.textContent = "Explore " + name.toLowerCase() + " restaurants and food spots around you.";
                exploreModal.classList.add("show");
            });
        });

        document.querySelectorAll("[data-modal]").forEach((button) => {
            button.addEventListener("click", function () {
                const modal = document.getElementById(this.dataset.modal);
                if (modal) modal.classList.add("show");
            });
        });

        document.querySelectorAll("[data-close-modal]").forEach((button) => {
            button.addEventListener("click", function () {
                const modal = this.closest(".modal");
                if (modal) modal.classList.remove("show");
            });
        });

        document.querySelectorAll(".modal").forEach((modal) => {
            modal.addEventListener("click", function (event) {
                if (event.target === modal) modal.classList.remove("show");
            });
        });

        document.addEventListener("keydown", function (event) {
            if (event.key !== "Escape") return;
            document.querySelectorAll(".modal.show").forEach((modal) => modal.classList.remove("show"));
            closeLocationMenu();
            document.getElementById("discoverMenu").classList.remove("show");
        });

        document.getElementById("loginForm").addEventListener("submit", function (event) {
            event.preventDefault();
            this.closest(".modal").classList.remove("show");
            showToast("Login submitted successfully.");
        });

        document.getElementById("signupForm").addEventListener("submit", function (event) {
            event.preventDefault();
            this.closest(".modal").classList.remove("show");
            showToast("Account creation submitted successfully.");
        });

        const directoryItems = document.querySelectorAll(".directory-item");
        directoryItems.forEach((item) => {
            const question = item.querySelector(".directory-question");
            const answer = item.querySelector(".directory-answer");
            question.addEventListener("click", function () {
                const isOpen = item.classList.contains("open");
                directoryItems.forEach((otherItem) => {
                    if (otherItem !== item) {
                        otherItem.classList.remove("open");
                        otherItem.querySelector(".directory-answer").style.maxHeight = null;
                    }
                });
                if (isOpen) {
                    item.classList.remove("open");
                    answer.style.maxHeight = null;
                } else {
                    item.classList.add("open");
                    answer.style.maxHeight = answer.scrollHeight + "px";
                }
            });
        });

        document.querySelectorAll("[data-jump='search']").forEach((btn) => {
            btn.addEventListener("click", function () {
                searchInput.value = this.dataset.query || "";
                searchRestaurants(searchInput.value);
                document.getElementById("restaurantsSection").scrollIntoView({ behavior: "smooth" });
            });
        });

        document.querySelectorAll("[data-city]").forEach((btn) => {
            btn.addEventListener("click", function () {
                setLocation(this.dataset.city);
            });
        });

        document.querySelectorAll("[data-fun]").forEach((btn) => {
            btn.addEventListener("click", function () {
                exploreModalTitle.textContent = this.dataset.fun;
                exploreModalText.textContent = "Discover " + this.dataset.fun.toLowerCase() + " around your selected location.";
                exploreModal.classList.add("show");
            });
        });

        document.querySelectorAll(".filter-pill").forEach((pill) => {
            pill.addEventListener("click", function () {
                const key = this.dataset.filter;
                if (key === "all") {
                    activeFilters.clear();
                    document.querySelectorAll(".filter-pill").forEach((p) => p.classList.remove("active"));
                    this.classList.add("active");
                    searchRestaurants(searchInput.value);
                    document.getElementById("restaurantsSection").scrollIntoView({ behavior: "smooth" });
                    showToast("Filters cleared.");
                    return;
                }
                document.querySelector('.filter-pill[data-filter="all"]').classList.remove("active");
                this.classList.toggle("active");
                if (this.classList.contains("active")) activeFilters.add(key);
                else activeFilters.delete(key);
                searchRestaurants(searchInput.value);
                document.getElementById("restaurantsSection").scrollIntoView({ behavior: "smooth" });
            });
        });

        document.getElementById("discoverToggle").addEventListener("click", function (event) {
            event.stopPropagation();
            document.getElementById("discoverMenu").classList.toggle("show");
        });

        document.getElementById("countryButton").addEventListener("click", function () {
            showToast("India is the current country.");
        });

        document.getElementById("languageButton").addEventListener("click", function () {
            showToast("English is the current language.");
        });

        document.querySelectorAll(".footer-col button, .social-btn, .footer-store").forEach((btn) => {
            if (btn.id === "countryButton" || btn.id === "languageButton") return;
            if (btn.dataset.fun || btn.dataset.city || btn.dataset.jump) return;
            btn.addEventListener("click", function () {
                const label = this.innerText.replace(/\s+/g, " ").trim();
                if (!label) return;
                showToast(label + " — coming soon.");
            });
        });

        searchRestaurants("");
    </script>
</body>
</html>
