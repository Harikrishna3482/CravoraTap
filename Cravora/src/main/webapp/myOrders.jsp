<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List,java.util.Map,com.tap.model.Order,com.tap.model.OrderItem,com.tap.model.Menu,com.tap.model.Restaurant"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cravora | Orders</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/myOrders.css">
</head>
<body>
	<header class="navbar">
		<div class="nav-inner">
			<a class="brand" href="<%=request.getContextPath()%>/restaurant">CRAVORA<span
				class="brand-dot"></span></a>
			<form class="nav-search" id="orderSearchForm">
				<div class="search-icon">⌕</div>
				<input id="orderSearch" type="search"
					placeholder="Search your orders" aria-label="Search your orders">
				<button type="submit" aria-label="Search">→</button>
			</form>
			<a class="nav-action" href="<%=request.getContextPath()%>/cart">Cart
				<span id="cartCount"><%=session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0%></span>
			</a>
			<button class="nav-action" id="helpButton" type="button">Help</button>
		</div>
	</header>
	<main class="page">
		<div class="container">
			<div class="page-head">
				<div>
					<div class="eyebrow">CRAVORA ACCOUNT</div>
					<h1>Your Orders</h1>
				</div>
				<p class="head-note">Track recent orders, view order details and
					order your favourites again.</p>
			</div>
			<div class="tabs">
				<button class="tab active" data-filter="all" type="button">All</button>
				<button class="tab" data-filter="active" type="button">Active</button>
				<button class="tab" data-filter="delivered" type="button">Delivered</button>
				<button class="tab" data-filter="cancelled" type="button">Cancelled</button>
			</div>
			<%
			List<Order> orders = (List<Order>) request.getAttribute("orders");
			Map<Integer, List<OrderItem>> orderItemsMap = (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");
			Map<Integer, Menu> menuMap = (Map<Integer, Menu>) request.getAttribute("menuMap");
			Map<Integer, Restaurant> restaurantMap = (Map<Integer, Restaurant>) request.getAttribute("restaurantMap");
			%>
			<section class="orders-list" id="ordersList">
				<%
				if (orders != null && !orders.isEmpty()) {
					for (Order order : orders) {
						List<OrderItem> orderItems = orderItemsMap != null ? orderItemsMap.get(order.getOrderId()) : null;
						Restaurant restaurant = restaurantMap != null ? restaurantMap.get(order.getRestaurantId()) : null;
						String rawStatus = order.getStatus() == null ? "active" : order.getStatus().trim().toLowerCase();
						String statusClass = rawStatus.contains("deliver")
						? "delivered"
						: rawStatus.contains("cancel") ? "cancelled" : "active";
						String statusLabel = statusClass.equals("delivered")
						? "Delivered"
						: statusClass.equals("cancelled") ? "Cancelled"
						: (order.getStatus() == null || order.getStatus().trim().isEmpty() ? "Active" : order.getStatus());
				%>
				<article class="order-card" data-status="<%=statusClass%>">
					<div class="order-top">
						<div class="restaurant-info">
							<%
							if (restaurant != null && restaurant.getImagePath() != null && !restaurant.getImagePath().trim().isEmpty()) {
							%>
							<img class="restaurant-logo" src="<%=restaurant.getImagePath()%>"
								alt="<%=restaurant.getName()%>">
							<%
							} else {
							%><div class="restaurant-logo" aria-hidden="true"></div>
							<%
							}
							%>
							<div>
								<div class="restaurant-name"><%=restaurant != null ? restaurant.getName() : "Restaurant unavailable"%></div>
								<div class="restaurant-meta"><%=restaurant != null && restaurant.getAddress() != null
		? restaurant.getAddress()
		: "Restaurant ID: " + order.getRestaurantId()%></div>
							</div>
						</div>
						<div class="status <%=statusClass%>"><%=statusLabel%></div>
					</div>
					<div class="order-body">
						<div class="order-line">
							<div class="order-items">
								<%
								if (orderItems != null && !orderItems.isEmpty()) {
									boolean firstItem = true;
									for (OrderItem orderItem : orderItems) {
										Menu menu = menuMap != null ? menuMap.get(orderItem.getMenuId()) : null;
										if (menu != null) {
									if (!firstItem) {
								%>
								·
								<%
								}
								%><%=menu.getItemName()%>
								×
								<%=orderItem.getQuantity()%>
								<%
								firstItem = false;
								}
								}
								if (firstItem) {
								%>No item details available<%
								}
								} else {
								%>No item
								details available<%
								}
								%>
							</div>
							<div class="order-total">
								₹<%=String.format("%.2f", order.getTotalAmount())%></div>
						</div>
						<div class="order-date"><%=order.getOrderDate()%>
							· Order #<%=order.getOrderId()%></div>
						<div class="order-actions">
							<button class="action" type="button" data-details="true"
								data-order-id="<%=order.getOrderId()%>"
								data-restaurant="<%=restaurant != null
		? restaurant.getName().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;")
		: "Restaurant unavailable"%>"
								data-status="<%=statusLabel%>"
								data-date="<%=order.getOrderDate()%>"
								data-payment="<%=order.getPaymentMode() != null
		? order.getPaymentMode().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;")
		: "Not available"%>"
								data-total="<%=String.format("%.2f", order.getTotalAmount())%>"
								data-items="<%if (orderItems != null) {
	boolean f = true;
	for (OrderItem oi : orderItems) {
		Menu m = menuMap != null ? menuMap.get(oi.getMenuId()) : null;
		if (m != null) {
			if (!f) {
				out.print(" | ");
			}
			out.print(m.getItemName().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">",
					"&gt;") + " x " + oi.getQuantity());
			f = false;
		}
	}
}%>"
								data-address="">View details</button>
							<%
							if (statusClass.equals("delivered")) {
							%><a
								class="action primary"
								href="<%=request.getContextPath()%>/menu<%=restaurant != null ? "?restaurantId=" + restaurant.getRestaurantId() : ""%>">Reorder</a>
							<%
							}
							%>
							<%
							if (statusClass.equals("active")) {
							%><button
								class="action primary" type="button" data-track="true">Track
								order</button>
							<%
							}
							%>
						</div>
					</div>
				</article>
				<%
				}
				}
				%>
			</section>
			<section class="empty" id="emptyState">
				<div class="empty-icon">🍽</div>
				<h2 id="emptyTitle">No orders here</h2>
				<p id="emptyMessage">Looks like this section is empty. Explore
					the menu and start your next Cravora order.</p>
				<a class="action primary"
					href="<%=request.getContextPath()%>/restaurant">Browse
					restaurants</a>
			</section>
		</div>
	</main>
	<div class="overlay" id="detailsModal">
		<div class="modal">
			<div class="modal-head">
				<h3>Order Details</h3>
				<button class="close" data-close="detailsModal" type="button"
					aria-label="Close">×</button>
			</div>
			<div class="modal-body" id="detailsBody"></div>
		</div>
	</div>
	<div class="overlay" id="helpModal">
		<div class="modal">
			<div class="modal-head">
				<h3>Cravora Help</h3>
				<button class="close" data-close="helpModal" type="button"
					aria-label="Close">×</button>
			</div>
			<div class="modal-body">
				<p style="color: var(--muted); font-size: 13px">For help with an
					order, please use the contact details provided by your Cravora
					project or support team.</p>
				<div class="modal-actions">
					<button class="action primary" data-close="helpModal" type="button">Got
						it</button>
				</div>
			</div>
		</div>
	</div>
	<div class="toast" id="toast"></div>
<script>
(function () {
    "use strict";

    const $ = function (id) {
        return document.getElementById(id);
    };

    let activeFilter = "all";
    let searchQuery = "";
    const cards = Array.from(document.querySelectorAll(".order-card"));

    function showToast(message) {
        const toastElement = $("toast");
        toastElement.textContent = message;
        toastElement.classList.add("show");
        window.setTimeout(function () {
            toastElement.classList.remove("show");
        }, 2200);
    }

    function renderOrders() {
        let visibleCount = 0;

        cards.forEach(function (card) {
            const filterMatches =
                activeFilter === "all" ||
                card.dataset.status === activeFilter;

            const searchMatches =
                !searchQuery ||
                card.textContent.toLowerCase().includes(searchQuery.toLowerCase());

            card.hidden = !(filterMatches && searchMatches);

            if (!card.hidden) {
                visibleCount++;
            }
        });

        $("emptyState").style.display = visibleCount > 0 ? "none" : "block";
        $("emptyTitle").textContent =
            cards.length === 0 ? "No orders yet" : "No matching orders";
        $("emptyMessage").textContent =
            cards.length === 0
                ? "Once you place an order, it will appear here."
                : "Try another search or choose a different order filter.";
    }

    document.querySelectorAll(".tab").forEach(function (button) {
        button.addEventListener("click", function () {
            document.querySelectorAll(".tab").forEach(function (tab) {
                tab.classList.remove("active");
            });

            button.classList.add("active");
            activeFilter = button.dataset.filter;
            renderOrders();
        });
    });

    $("orderSearchForm").addEventListener("submit", function (event) {
        event.preventDefault();
        searchQuery = $("orderSearch").value.trim();
        renderOrders();
    });

    $("orderSearch").addEventListener("input", function () {
        searchQuery = $("orderSearch").value.trim();
        renderOrders();
    });

    function closeModal(id) {
        const modal = $(id);
        if (modal) {
            modal.classList.remove("show");
        }
    }

    function escapeHtml(value) {
        return String(value || "Not available").replace(/[&<>"']/g, function (character) {
            return {
                "&": "&amp;",
                "<": "&lt;",
                ">": "&gt;",
                '"': "&quot;",
                "'": "&#039;"
            }[character];
        });
    }

    document.querySelectorAll("[data-details]").forEach(function (button) {
        button.addEventListener("click", function () {
            const data = button.dataset;
            const escapedItems = escapeHtml(data.items).split(" | ").join("<br>");

            $("detailsBody").innerHTML =
                '<div class="detail-grid">' +
                    '<div class="detail"><small>Restaurant</small><strong>' + escapeHtml(data.restaurant) + '</strong></div>' +
                    '<div class="detail"><small>Status</small><strong>' + escapeHtml(data.status) + '</strong></div>' +
                    '<div class="detail"><small>Order ID</small><strong>' + escapeHtml(data.orderId) + '</strong></div>' +
                    '<div class="detail"><small>Date</small><strong>' + escapeHtml(data.date) + '</strong></div>' +
                    '<div class="detail"><small>Payment</small><strong>' + escapeHtml(data.payment) + '</strong></div>' +
                    '<div class="detail"><small>Total</small><strong>₹' + escapeHtml(data.total) + '</strong></div>' +
                '</div>' +
                '<div class="detail items-detail" style="margin-top:12px">' +
                    '<small>Items</small><strong>' + escapedItems + '</strong>' +
                '</div>' +
                '<div class="modal-actions">' +
                    '<button class="action primary" data-close="detailsModal" type="button">Close</button>' +
                '</div>';

            $("detailsModal").classList.add("show");

            $("detailsBody").querySelector("[data-close]").addEventListener("click", function () {
                closeModal("detailsModal");
            });
        });
    });

    document.querySelectorAll("[data-track]").forEach(function (button) {
        button.addEventListener("click", function () {
            const status = button.closest(".order-card").querySelector(".status").textContent.trim();
            showToast("Current order status: " + status);
        });
    });

    $("helpButton").addEventListener("click", function () {
        $("helpModal").classList.add("show");
    });

    document.querySelectorAll("[data-close]").forEach(function (button) {
        button.addEventListener("click", function () {
            closeModal(button.dataset.close);
        });
    });

    document.querySelectorAll(".overlay").forEach(function (overlay) {
        overlay.addEventListener("click", function (event) {
            if (event.target === overlay) {
                closeModal(overlay.id);
            }
        });
    });

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape") {
            document.querySelectorAll(".overlay.show").forEach(function (overlay) {
                closeModal(overlay.id);
            });
        }
    });

    renderOrders();
})();
</script>
</body>
</html>
