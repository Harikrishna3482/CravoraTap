<%-- Shared Cravora navbar: session-based rendering --%>
<%
    Object cravoraLoggedInUser = session.getAttribute("loggedInUser");
    String cravoraContextPath = request.getContextPath();
%>

<% if (cravoraLoggedInUser != null) { %>
<header class="cravora-member-navbar">
    <div class="cravora-member-inner">
        <a class="cravora-member-logo" href="<%= cravoraContextPath %>/restaurant">
            CRAVORA<span></span>
        </a>

        <nav class="cravora-member-links" aria-label="Main navigation">
            <a href="<%= cravoraContextPath %>/restaurant">Restaurants</a>
            <a href="<%= cravoraContextPath %>/restaurant">Explore Menu</a>
        </nav>

        <div class="cravora-member-actions">
            <a class="cravora-member-cart" href="<%= cravoraContextPath %>/cart.jsp">My Cart</a>
            <div class="cravora-profile">
                <button type="button" class="cravora-profile-button"
                        id="cravoraProfileButton" aria-expanded="false"
                        aria-controls="cravoraProfileMenu">
                    <span class="cravora-profile-icon" aria-hidden="true">●</span>
                    <span>Profile</span>
                    <span class="cravora-profile-arrow" aria-hidden="true">⌄</span>
                </button>
                <div class="cravora-profile-menu" id="cravoraProfileMenu">
                    <a href="<%= cravoraContextPath %>/restaurant">Browse Restaurants</a>
                    <a href="<%= cravoraContextPath %>/cart.jsp">My Cart</a>
                    <a href="<%= cravoraContextPath %>/logout">Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
(function () {
    const button = document.getElementById("cravoraProfileButton");
    const menu = document.getElementById("cravoraProfileMenu");
    if (!button || !menu) return;

    button.addEventListener("click", function (event) {
        event.stopPropagation();
        const open = menu.classList.toggle("is-open");
        button.setAttribute("aria-expanded", String(open));
    });

    document.addEventListener("click", function (event) {
        if (!menu.contains(event.target) && !button.contains(event.target)) {
            menu.classList.remove("is-open");
            button.setAttribute("aria-expanded", "false");
        }
    });

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape") {
            menu.classList.remove("is-open");
            button.setAttribute("aria-expanded", "false");
        }
    });
})();
</script>

<% } else { %>

<header class="navbar">

    <div class="nav-inner">

        <!-- LOGO -->
        <a href="restaurant" class="brand">
            CRAVORA<span class="brand-dot"></span>
        </a>


        <!-- LOCATION -->
        <div class="location-wrapper">

            <div class="location-control">

                <div class="location-pin">
                    <img src="images/location.svg" alt="Location">
                </div>

                <input
                    type="text"
                    id="locationInput"
                    class="location-input"
                    placeholder="Search your location"
                    autocomplete="off"
                >

                <button
                    type="button"
                    class="location-arrow"
                    id="locationArrow"
                    aria-label="Open location options"
                >
                    <span>
                        <img
                            src="images/down-arrow-svgrepo-com (2).svg"
                            alt="Location"
                        >
                    </span>
                </button>

            </div>


            <!-- LOCATION PLACES -->
            <div class="location-menu" id="locationMenu">

                <button
                    type="button"
                    class="location-option current-location"
                    id="useCurrentLocation"
                >
                    <img src="images/location.svg" alt="Location">
                    Use current location
                </button>

                <button
                    type="button"
                    class="location-option"
                    data-location="Bengaluru, Karnataka">
                    Bengaluru, Karnataka
                </button>

                <button
                    type="button"
                    class="location-option"
                    data-location="Mumbai, Maharashtra">
                    Mumbai, Maharashtra
                </button>

                <button
                    type="button"
                    class="location-option"
                    data-location="Pune, Maharashtra">
                    Pune, Maharashtra
                </button>

                <button
                    type="button"
                    class="location-option"
                    data-location="Hyderabad, Telangana">
                    Hyderabad, Telangana
                </button>

                <button
                    type="button"
                    class="location-option"
                    data-location="Delhi, India">
                    Delhi, India
                </button>

                <button
                    type="button"
                    class="location-option"
                    data-location="Nagpur, Maharashtra">
                    Nagpur, Maharashtra
                </button>

            </div>

        </div>


        <!-- SEARCH -->
        <form class="nav-search" id="restaurantSearchForm">

            <div class="search-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
</svg>
            </div>

            <input
                type="search"
                id="restaurantSearch"
                placeholder="Search for restaurant, cuisine or a dish"
                autocomplete="off"
            >

            <button type="submit" aria-label="Search">
                &#x2192;
            </button>

        </form>


        <!-- LOGIN -->
        <a class="nav-action" href="login.jsp">

            <span class="nav-action-inner">

                <span class="nav-action-text original">
                    Log in
                </span>

                <span class="nav-action-text clone">
                    Log in
                </span>

            </span>

        </a>


        <!-- SIGN UP -->
        <a href="signup.jsp" class="nav-action nav-signup">

            <span class="nav-action-inner">

                <span class="nav-action-text original">
                    Sign up
                </span>

                <span class="nav-action-text clone">
                    Sign up
                </span>

            </span>

        </a>

    </div>

</header>


<!-- NAVBAR JAVASCRIPT -->
<script>

document.addEventListener("DOMContentLoaded", function () {

    const locationArrow =
        document.getElementById("locationArrow");

    const locationMenu =
        document.getElementById("locationMenu");

    const locationInput =
        document.getElementById("locationInput");

    const locationWrapper =
        document.querySelector(".location-wrapper");


    /* =========================
       OPEN / CLOSE LOCATION
    ========================= */

    locationArrow.addEventListener("click", function (event) {

        event.stopPropagation();

        locationMenu.classList.toggle("show");

        locationArrow.classList.toggle("open");

    });


    /* =========================
       INPUT CLICK
    ========================= */

    locationInput.addEventListener("focus", function () {

        locationMenu.classList.add("show");

        locationArrow.classList.add("open");

    });


    /* =========================
       LOCATION OPTIONS
    ========================= */

    document
        .querySelectorAll(".location-option[data-location]")
        .forEach(function (option) {

            option.addEventListener("click", function () {

                locationInput.value =
                    this.getAttribute("data-location");

                locationMenu.classList.remove("show");

                locationArrow.classList.remove("open");

            });

        });


    /* =========================
       CURRENT LOCATION
    ========================= */

    document
        .getElementById("useCurrentLocation")
        .addEventListener("click", function () {

            if (!navigator.geolocation) {

                alert(
                    "Location services are not supported by your browser."
                );

                return;
            }


            navigator.geolocation.getCurrentPosition(

                function (position) {

                    const latitude =
                        position.coords.latitude.toFixed(4);

                    const longitude =
                        position.coords.longitude.toFixed(4);


                    locationInput.value =
                        "Current location (" +
                        latitude +
                        ", " +
                        longitude +
                        ")";


                    locationMenu.classList.remove("show");

                    locationArrow.classList.remove("open");

                },

                function (error) {

                    if (error.code === 1) {

                        alert(
                            "Location permission was denied."
                        );

                    } else if (error.code === 2) {

                        alert(
                            "Your location could not be determined."
                        );

                    } else if (error.code === 3) {

                        alert(
                            "Location request timed out."
                        );

                    } else {

                        alert(
                            "Unable to get your location."
                        );

                    }

                }

            );

        });


    /* =========================
       CLOSE WHEN CLICKING OUTSIDE
    ========================= */

    document.addEventListener("click", function (event) {

        if (
            !locationWrapper.contains(event.target)
        ) {

            locationMenu.classList.remove("show");

            locationArrow.classList.remove("open");

        }

    });


    /* =========================
       RESTAURANT SEARCH
    ========================= */

    const searchForm =
        document.getElementById("restaurantSearchForm");

    const searchInput =
        document.getElementById("restaurantSearch");


    function searchRestaurants(query) {

        const searchText =
            query.trim().toLowerCase();

        const restaurantCards =
            document.querySelectorAll(".restaurant-card");


        let visibleCount = 0;


        restaurantCards.forEach(function (card) {

            const cardText =
                card.textContent.toLowerCase();


            const matches =
                searchText === "" ||
                cardText.includes(searchText);


            card.style.display =
                matches ? "" : "none";


            if (matches) {
                visibleCount++;
            }

        });

    }


    searchInput.addEventListener("input", function () {

        searchRestaurants(this.value);

    });


    searchForm.addEventListener("submit", function (event) {

        event.preventDefault();

        searchRestaurants(searchInput.value);

    });

});

</script>

<% } %>
