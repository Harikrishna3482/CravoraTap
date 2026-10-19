<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    Object orderId = request.getAttribute("orderId");
    Object totalAmount = request.getAttribute("totalAmount");
    Object paymentMode = request.getAttribute("paymentMode");

    String orderIdText = orderId != null ? String.valueOf(orderId) : "Not available";
    String paymentModeText = paymentMode != null ? String.valueOf(paymentMode) : "Not available";
    String totalAmountText = "0.00";
    if (totalAmount instanceof Number) {
        totalAmountText = String.format(java.util.Locale.US, "%.2f", ((Number) totalAmount).doubleValue());
    } else if (totalAmount != null) {
        try {
            totalAmountText = String.format(java.util.Locale.US, "%.2f", Double.parseDouble(String.valueOf(totalAmount)));
        } catch (NumberFormatException ignored) {
            totalAmountText = String.valueOf(totalAmount);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cravora | Order Successful</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/orderSuccess.css">
</head>
<body>
    <header class="navbar">
        <div class="nav-inner">
            <a class="brand" href="<%=request.getContextPath()%>/restaurant">CRAVORA<span class="brand-dot"></span></a>
            <div class="secure-note"><span class="secure-mark">✓</span> ORDER CONFIRMATION</div>
            <a class="nav-action" href="<%=request.getContextPath()%>/myOrders">My Orders</a>
        </div>
    </header>

    <main class="success-page">
        <div class="success-container">
            <div class="success-kicker"><span class="success-kicker-line"></span> THANK YOU FOR CHOOSING CRAVORA</div>
            <div class="success-icon" aria-hidden="true">
                <svg viewBox="0 0 64 64" role="img" aria-label="Success">
                    <circle cx="32" cy="32" r="27"></circle>
                    <path d="M19 32.5 27.5 41 45 23"></path>
                </svg>
            </div>
            <h1 class="success-title">ORDER <span>PLACED.</span></h1>
            <p class="success-message">Your order has been placed successfully. We’re getting things ready for you.</p>

            <section class="order-details" aria-label="Order summary">
                <div class="summary-heading">
                    <div>
                        <span class="summary-eyebrow">CONFIRMATION</span>
                        <h2>Order summary</h2>
                    </div>
                    <span class="confirmed-badge"><span></span> CONFIRMED</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Order ID</span>
                    <strong class="detail-value">#<%=orderIdText%></strong>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Total amount</span>
                    <strong class="detail-value amount">₹<%=totalAmountText%></strong>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment method</span>
                    <strong class="detail-value"><%=paymentModeText%></strong>
                </div>
                <div class="confirmation-note"><span class="note-icon">✓</span><span>Keep your order ID handy if you need help with this order.</span></div>
            </section>

            <div class="success-actions">
                <a class="button orders-button" href="<%=request.getContextPath()%>/myOrders">VIEW MY ORDERS <span aria-hidden="true">→</span></a>
                <a class="button restaurants-button" href="<%=request.getContextPath()%>/restaurant">BROWSE RESTAURANTS</a>
            </div>
            <p class="footer-note">GOOD FOOD. GOOD MOOD. THE CRAVORA WAY.</p>
        </div>
    </main>
</body>
</html>
