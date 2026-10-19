javascript
document.addEventListener("DOMContentLoaded", function () {

    /* =========================
       LOCATION
    ========================= */

    const locationArrow =
        document.getElementById("locationArrow");

    const locationMenu =
        document.getElementById("locationMenu");

    const locationInput =
        document.getElementById("locationInput");

    const locationWrapper =
        document.querySelector(".location-wrapper");


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

        closeLocationMenu();
    }


    /* OPEN / CLOSE LOCATION DROPDOWN */

    locationArrow.addEventListener("click", function (event) {

        event.stopPropagation();

        if (locationMenu.classList.contains("show")) {
            closeLocationMenu();
        } else {
            openLocationMenu();
        }

    });


    /* OPEN WHEN INPUT IS CLICKED */

    locationInput.addEventListener("focus", function () {
        openLocationMenu();
    });


    /* LOCATION OPTIONS */

    document
        .querySelectorAll(".location-option[data-location]")
        .forEach(function (option) {

            option.addEventListener("click", function () {

                setLocation(this.dataset.location);

            });

        });


    /* LOCATION ENTER */

    locationInput.addEventListener("keydown", function (event) {

        if (event.key !== "Enter") {
            return;
        }

        event.preventDefault();

        const value = locationInput.value.trim();

        if (value === "") {
            return;
        }

        closeLocationMenu();

    });


    /* CURRENT LOCATION */

    const currentLocationButton =
        document.getElementById("useCurrentLocation");


    currentLocationButton.addEventListener("click", function () {

        if (!navigator.geolocation) {

            alert(
                "Location services are not supported by this browser."
            );

            return;
        }


        navigator.geolocation.getCurrentPosition(

            function (position) {

                const latitude =
                    position.coords.latitude.toFixed(4);

                const longitude =
                    position.coords.longitude.toFixed(4);


                const locationText =
                    "Current location (" +
                    latitude +
                    ", " +
                    longitude +
                    ")";


                locationInput.value = locationText;

                closeLocationMenu();

            },


            function (error) {

                if (error.code === 1) {
                    alert("Location permission was denied.");
                }
                else if (error.code === 2) {
                    alert(
                        "Your location could not be determined."
                    );
                }
                else if (error.code === 3) {
                    alert(
                        "Location request timed out."
                    );
                }
                else {
                    alert(
                        "Unable to get your location."
                    );
                }

            },

            {
                enableHighAccuracy: true,
                timeout: 10000,
                maximumAge: 60000
            }

        );

    });


    /* CLOSE LOCATION DROPDOWN WHEN CLICKING OUTSIDE */

    document.addEventListener("click", function (event) {

        if (
            locationWrapper &&
            !locationWrapper.contains(event.target)
        ) {
            closeLocationMenu();
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

        const normalizedQuery =
            query.trim().toLowerCase();


        /*
         * This searches the actual text
         * already present inside your backend
         * restaurant cards.
         */

        const restaurantCards =
            document.querySelectorAll(".restaurant-card");


        let visibleCount = 0;


        restaurantCards.forEach(function (card) {

            const cardText =
                card.textContent.toLowerCase();


            const matches =
                normalizedQuery === "" ||
                cardText.includes(normalizedQuery);


            card.style.display =
                matches ? "" : "none";


            if (matches) {
                visibleCount++;
            }

        });


        /*
         * If there are no matching restaurants,
         * show the existing empty-state element
         * if your restaurant.jsp contains one.
         */

        const emptyState =
            document.querySelector(".empty-state");


        if (emptyState) {

            emptyState.style.display =
                visibleCount === 0 ? "block" : "none";

        }

    }


    /* SEARCH WHILE TYPING */

    searchInput.addEventListener(
        "input",
        function () {

            searchRestaurants(this.value);

        }
    );


    /* SEARCH BUTTON */

    searchForm.addEventListener(
        "submit",
        function (event) {

            event.preventDefault();

            searchRestaurants(
                searchInput.value
            );


            const restaurantSection =
                document.querySelector(
                    ".restaurants-section"
                );


            if (restaurantSection) {

                restaurantSection.scrollIntoView({
                    behavior: "smooth"
                });

            }

        }
    );

});