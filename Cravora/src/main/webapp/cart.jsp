<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.DaoImple.RestaurantDaoImpl" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cravora | Cart</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/cart.css">
</head>
<body>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    boolean hasItems = cart != null && !cart.isEmpty();
    Restaurant selectedRestaurant = null;
    if (hasItems) {
        Iterator<CartItem> restaurantIterator = cart.getItems().values().iterator();
        if (restaurantIterator.hasNext()) {
            Menu firstMenu = restaurantIterator.next().getMenu();
            selectedRestaurant = new RestaurantDaoImpl().getRestaurant(firstMenu.getRestaurantId());
        }
    }
    String restaurantName = selectedRestaurant != null ? selectedRestaurant.getName() : "Your Restaurant";
    String restaurantImage = selectedRestaurant != null && selectedRestaurant.getImagePath() != null
            ? selectedRestaurant.getImagePath() : "";
%>
<header class="checkout-header">
  <div class="checkout-header-inner">
    <div class="checkout-brand">
      <a href="<%=request.getContextPath()%>/restaurant" class="checkout-logo" aria-label="Cravora home">CRAV<span>O</span>RA</a>
      <div class="checkout-divider" aria-hidden="true"></div>
      <div class="secure-checkout"><span class="secure-icon">✓</span> Secure Checkout</div>
    </div>
    <div class="checkout-actions">
      <button type="button" class="checkout-action help-action" id="helpButton" aria-label="Help"><span class="checkout-action-icon">?</span><span>Help</span></button>
      <button type="button" class="checkout-action profile-action" id="profileButton" aria-label="Profile"><svg class="profile-svg" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="8" r="3.2"></circle><path d="M5.5 20c.7-4 3-6 6.5-6s5.8 2 6.5 6"></path></svg></button>
    </div>
  </div>
</header>

<main class="cart-page">
  <div class="container">
    <div class="page-kicker">03 / YOUR ORDER</div>
    <h1 class="page-title">YOUR <span>CART.</span></h1>
    <div class="cart-layout">
      <section class="panel" id="cartPanel">
        <% if (hasItems) { %>
        <div class="restaurant-card">
          <% if (!restaurantImage.isEmpty()) { %><img class="restaurant-thumb" src="<%=restaurantImage%>" alt="<%=restaurantName%>"><% } else { %><div class="restaurant-thumb restaurant-thumb-placeholder" aria-hidden="true">🍽</div><% } %>
          <div>
            <div class="restaurant-name"><%=restaurantName%></div>
            <div class="restaurant-meta">Your selected dishes · Ready for checkout</div>
          </div>
          <a class="restaurant-change" href="<%=request.getContextPath()%>/restaurant">Add more</a>
        </div>
        <div class="cart-list" id="cartList">
          <% Map<Integer, CartItem> items = cart.getItems();
             for (CartItem cartItem : items.values()) {
                 Menu menu = cartItem.getMenu();
                 int quantity = cartItem.getQuantity();
                 double subtotal = cartItem.getSubtotal(); %>
          <div class="cart-row">
            <img class="item-thumb" src="<%=menu.getImagePath()%>" alt="<%=menu.getItemName()%>">
            <div class="item-details">
              <div class="item-name"><%=menu.getItemName()%></div>
              <div class="item-price">₹<%=String.format("%.2f", menu.getPrice())%> each</div>
              <div class="item-total">₹<%=String.format("%.2f", subtotal)%></div>
            </div>
            <div class="qty" aria-label="Quantity controls">
              <form action="<%=request.getContextPath()%>/cart" method="post"><input type="hidden" name="action" value="update"><input type="hidden" name="menuId" value="<%=menu.getMenuId()%>"><input type="hidden" name="quantity" value="<%=quantity - 1%>"><button type="submit" aria-label="Decrease quantity" <%=quantity <= 1 ? "disabled" : ""%>>−</button></form>
              <span><%=quantity%></span>
              <form action="<%=request.getContextPath()%>/cart" method="post"><input type="hidden" name="action" value="update"><input type="hidden" name="menuId" value="<%=menu.getMenuId()%>"><input type="hidden" name="quantity" value="<%=quantity + 1%>"><button type="submit" aria-label="Increase quantity">+</button></form>
            </div>
            <div class="remove-section"><form action="<%=request.getContextPath()%>/cart" method="post"><input type="hidden" name="action" value="remove"><input type="hidden" name="menuId" value="<%=menu.getMenuId()%>"><button type="submit" class="remove-button">Remove</button></form></div>
          </div>
          <% } %>
        </div>
        <div class="cart-note" id="cartNote">Prices shown are for the selected items. Delivery charges and taxes are calculated during checkout.</div>
        <div class="cart-clear-wrap"><form action="<%=request.getContextPath()%>/cart" method="post" onsubmit="return confirm('Remove all items from your cart?');"><input type="hidden" name="action" value="clear"><button type="submit" class="secondary">Clear Cart</button></form></div>
        <% } else { %>
        <div class="empty" id="emptyState"><div class="empty-icon">🛒</div><h2>Your cart is empty.</h2><p>Add something delicious from one of the Cravora restaurants and it will appear here.</p><a href="<%=request.getContextPath()%>/restaurant" class="primary" id="browseButton">Browse restaurants</a></div>
        <% } %>
      </section>

      <aside class="right-stack">
        <section class="panel">
          <div class="card-title">Delivery address</div>
          <div class="address-body"><div class="address-icon">⌖</div><div><div class="address-label" id="addressLabel">Delivery address</div><div class="address-text" id="addressText">Your saved address will be used during checkout.</div></div><button type="button" class="address-change" id="changeAddress">Change</button></div>
        </section>
        <section class="panel">
          <div class="card-title">Offers &amp; Benefits</div>
          <div class="offer-body"><div class="offer-line"><div class="offer-icon">%</div><div class="offer-text"><strong id="couponTitle">Save on this order</strong><span id="couponText">Check available offers during checkout.</span></div><button type="button" class="apply-btn" id="applyCoupon">View</button></div></div>
        </section>
        <section class="panel">
          <div class="card-title">Add a tip</div>
          <div class="tip-body"><div class="tip-buttons"><button type="button" class="tip-btn active" data-tip="0">No tip</button><button type="button" class="tip-btn" data-tip="20">₹20</button><button type="button" class="tip-btn" data-tip="30">₹30</button><button type="button" class="tip-btn" data-tip="50">₹50</button></div><p class="tip-note">Choose a tip preference. It is a visual selection here and is not added to the server-side cart total.</p></div>
        </section>
        <section class="panel">
          <div class="card-title">Bill details <span class="bill-count"><%=hasItems ? cart.getItemCount() : 0%> items</span></div>
          <div class="bill-body">
            <div class="bill-row"><span>Item total</span><strong>₹<%=String.format("%.2f", hasItems ? cart.getTotal() : 0.0)%></strong></div>
            <div class="bill-row"><span>Coupon discount</span><strong>—</strong></div>
            <div class="bill-row"><span>Delivery fee</span><strong>Calculated at checkout</strong></div>
            <div class="bill-row"><span>Platform fee</span><strong>Calculated at checkout</strong></div>
            <div class="bill-row"><span>Taxes &amp; charges</span><strong>Calculated at checkout</strong></div>
            <div class="bill-row"><span>Delivery tip</span><strong id="tipAmount">₹0</strong></div>
            <div class="bill-divider"></div>
            <div class="pay-row"><span class="pay-label">Item Total</span><strong class="pay-total">₹<%=String.format("%.2f", hasItems ? cart.getTotal() : 0.0)%></strong></div>
          </div>
          <div class="place-wrap"><form action="<%=request.getContextPath()%>/checkout" method="get"><button class="place-btn" type="submit" <%=!hasItems ? "disabled" : ""%>>Proceed to Checkout</button></form></div>
          <div class="small-help">Review your items before proceeding. Delivery charges, taxes and payment options depend on checkout.</div>
        </section>
      </aside>
    </div>
  </div>
</main>

<div class="overlay" id="addressModal" role="dialog" aria-modal="true" aria-labelledby="addressModalTitle"><div class="modal"><div class="modal-head"><h3 id="addressModalTitle">Delivery Address</h3><button type="button" class="close" data-close="addressModal" aria-label="Close">×</button></div><div class="modal-body"><p class="modal-message">Your delivery address can be confirmed or updated during checkout.</p><div class="modal-actions"><button type="button" class="primary" data-close="addressModal">Got it</button></div></div></div></div>
<div class="overlay" id="couponModal" role="dialog" aria-modal="true" aria-labelledby="couponModalTitle"><div class="modal"><div class="modal-head"><h3 id="couponModalTitle">Offers &amp; Benefits</h3><button type="button" class="close" data-close="couponModal" aria-label="Close">×</button></div><div class="modal-body"><div class="coupon"><div><div class="coupon-code">AVAILABLE AT CHECKOUT</div><div class="coupon-desc">Coupon eligibility and discounts are handled by checkout, not the cart page.</div></div></div><div class="modal-actions"><button type="button" class="primary" data-close="couponModal">Got it</button></div></div></div></div>
<div class="overlay" id="helpModal" role="dialog" aria-modal="true" aria-labelledby="helpModalTitle"><div class="modal"><div class="modal-head"><h3 id="helpModalTitle">Need Help?</h3><button type="button" class="close" data-close="helpModal" aria-label="Close">×</button></div><div class="modal-body"><p class="modal-message">You can update quantities, remove dishes, or clear the cart here. Select Proceed to Checkout to continue.</p><div class="modal-actions"><button type="button" class="primary" data-close="helpModal">Got it</button></div></div></div></div>
<div class="overlay" id="profileModal" role="dialog" aria-modal="true" aria-labelledby="profileModalTitle"><div class="modal"><div class="modal-head"><h3 id="profileModalTitle">Your Account</h3><button type="button" class="close" data-close="profileModal" aria-label="Close">×</button></div><div class="modal-body"><p class="modal-message">Your account details and order history are available through the Cravora account pages.</p><div class="modal-actions"><button type="button" class="primary" data-close="profileModal">Close</button></div></div></div></div>
<div class="toast" id="toast" role="status" aria-live="polite"></div>
<script>
(function(){
  const toast = document.getElementById('toast');
  let toastTimer;
  function showToast(message){ toast.textContent=message; toast.classList.add('show'); clearTimeout(toastTimer); toastTimer=setTimeout(()=>toast.classList.remove('show'),2400); }
  function openModal(id){ const modal=document.getElementById(id); if(modal) modal.classList.add('show'); }
  function closeModal(id){ const modal=document.getElementById(id); if(modal) modal.classList.remove('show'); }
  document.getElementById('helpButton').addEventListener('click',()=>openModal('helpModal'));
  document.getElementById('profileButton').addEventListener('click',()=>openModal('profileModal'));
  document.getElementById('changeAddress').addEventListener('click',()=>openModal('addressModal'));
  document.getElementById('applyCoupon').addEventListener('click',()=>openModal('couponModal'));
  document.querySelectorAll('[data-close]').forEach(button=>button.addEventListener('click',()=>closeModal(button.dataset.close)));
  document.querySelectorAll('.overlay').forEach(overlay=>overlay.addEventListener('click',event=>{if(event.target===overlay) overlay.classList.remove('show');}));
  document.addEventListener('keydown',event=>{if(event.key==='Escape') document.querySelectorAll('.overlay.show').forEach(modal=>modal.classList.remove('show'));});
  document.querySelectorAll('[data-tip]').forEach(button=>button.addEventListener('click',()=>{
    document.querySelectorAll('[data-tip]').forEach(item=>item.classList.remove('active'));
    button.classList.add('active');
    const amount=Number(button.dataset.tip)||0;
    document.getElementById('tipAmount').textContent='₹'+amount;
    showToast(amount===0?'No tip selected':'₹'+amount+' tip selected');
  }));
})();
</script>
</body>
</html>
