<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.tap.model.Cart,com.tap.model.CartItem,com.tap.model.Menu,com.tap.model.User,java.util.Map,java.util.Collection"%>
<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
Cart cart = (Cart) session.getAttribute("cart");
if (loggedInUser == null) {
	response.sendRedirect(request.getContextPath() + "/login");
	return;
}
if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
	response.sendRedirect(request.getContextPath() + "/cart");
	return;
}
double itemTotal = cart.getTotal();
// These fees are presentation defaults only until the project has a confirmed server-side fee calculation.
double deliveryFee = 40.0;
double platformFee = 20.0;
double taxes = 0.0;
double discount = 0.0;
double grandTotal = itemTotal + deliveryFee + platformFee + taxes - discount;
String savedAddress = loggedInUser.getAddress() == null ? "" : loggedInUser.getAddress();
String displayName = loggedInUser.getUsername() == null ? "Customer" : loggedInUser.getUsername();
String phone = loggedInUser.getPhone() == null ? "" : loggedInUser.getPhone();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cravora | Payment</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/checkout.css">
</head>
<body>
	<header class="header">
		<div class="header-inner">
			<a class="logo" href="<%=request.getContextPath()%>/restaurant"
				aria-label="Cravora home">CRAV<span>O</span>RA
			</a>
			<div class="secure">
				<span class="lock">✓</span> Secure Checkout
			</div>
			<button class="header-help" id="helpButton" type="button">Help</button>
		</div>
	</header>
	<main class="page">
		<div class="title">
			<div class="eyebrow">CRAVORA CHECKOUT</div>
			<h1>Choose Payment</h1>
			<p>Review your delivery details and choose how you would like to
				pay.</p>
		</div>
		<div class="payment-shell">
			<section class="panel">
				<div class="panel-head">
					<h2>Payment Methods</h2>
					<p>Choose a payment method to continue</p>
				</div>
				<div class="address-card">
					<div class="address-head">
						<h3>Delivery Address</h3>
						<button class="text-action" type="button" id="editAddress">Edit</button>
					</div>
					<div class="address-copy" id="addressDisplay">
						<strong><%=displayName%></strong>
						<%
						if (!phone.isEmpty()) {
						%>
						·
						<%=phone%>
						<%
						}
						%><br><%=savedAddress.isEmpty() ? "No address saved to your account." : savedAddress%></div>
					<div class="address-edit" id="addressEditor">
						<label for="deliveryAddress">Update delivery address</label>
						<textarea id="deliveryAddress" rows="3"
							placeholder="Enter complete delivery address"><%=savedAddress%></textarea>
						<button class="text-action" type="button" id="saveAddress">Use
							this address</button>
						<p class="coupon-message">This address is attached to this
							checkout request. Saving it to your profile requires backend
							support.</p>
					</div>
				</div>
				<div class="methods">
					<button class="method active" data-method="UPI" type="button">
						<span class="method-icon">UPI</span><span class="method-copy"><span
							class="method-name">UPI</span><span class="method-desc">Google
								Pay · PhonePe · Paytm · Any UPI app</span></span><span class="radio"></span>
					</button>
					<button class="method" data-method="Card" type="button">
						<span class="method-icon">CARD</span><span class="method-copy"><span
							class="method-name">Cards</span><span class="method-desc">Credit
								card · Debit card</span></span><span class="radio"></span>
					</button>
					<button class="method" data-method="Netbanking" type="button">
						<span class="method-icon">₹</span><span class="method-copy"><span
							class="method-name">Netbanking</span><span class="method-desc">Select
								your bank and continue</span></span><span class="radio"></span>
					</button>
					<button class="method" data-method="Wallet" type="button">
						<span class="method-icon">W</span><span class="method-copy"><span
							class="method-name">Wallets</span><span class="method-desc">Available
								wallet options</span></span><span class="radio"></span>
					</button>
					<button class="method" data-method="COD" type="button">
						<span class="method-icon">COD</span><span class="method-copy"><span
							class="method-name">Cash on Delivery</span><span
							class="method-desc">Pay when your order arrives</span></span><span
							class="radio"></span>
					</button>
				</div>
				<form class="checkout-area form-wrap"
					action="<%=request.getContextPath()%>/order" method="post"
					id="paymentForm">
					<input type="hidden" name="paymentMode" id="paymentMode"
						value="UPI"><input type="hidden" name="deliveryAddress"
						id="addressForOrder" value="<%=savedAddress%>">
					<div id="upiForm">
						<div class="field">
							<label for="upiId">UPI ID (optional for current order
								flow)</label><input id="upiId" name="upiId" type="text"
								placeholder="example@upi" autocomplete="off">
						</div>
					</div>
					<div id="cardForm" style="display: none">
						<div class="field">
							<label for="cardNumber">Card Number</label><input id="cardNumber"
								inputmode="numeric" maxlength="19"
								placeholder="1234 5678 9012 3456" autocomplete="off">
						</div>
						<div class="card-row">
							<div class="field">
								<label for="expiry">Expiry</label><input id="expiry"
									inputmode="numeric" maxlength="5" placeholder="MM/YY"
									autocomplete="off">
							</div>
							<div class="field">
								<label for="cvv">CVV</label><input id="cvv" inputmode="numeric"
									maxlength="3" placeholder="•••" autocomplete="off">
							</div>
						</div>
						<p class="coupon-message">Do not enter real card details here.
							This project does not currently connect to a payment gateway.</p>
					</div>
					<div id="bankForm" style="display: none">
						<div class="field">
							<label for="bank">Bank</label><input id="bank" type="text"
								placeholder="Choose your bank">
						</div>
						<p class="coupon-message">Bank payment is not processed until
							a payment gateway is integrated.</p>
					</div>
					<div id="walletForm" style="display: none">
						<div class="field">
							<label for="wallet">Wallet</label><input id="wallet" type="text"
								placeholder="Choose wallet">
						</div>
						<p class="coupon-message">Wallet payment is not processed
							until a payment gateway is integrated.</p>
					</div>
					<div id="codForm" style="display: none">
						<p
							style="color: var(--muted); font-size: 12px; margin-bottom: 14px">Pay
							the delivery partner in cash when your order arrives.</p>
					</div>
					<button class="pay-btn" id="payButton" type="submit">
						Place Order · ₹<%=String.format("%.2f", grandTotal)%></button>
					<div class="note">
						🔒 <b>Checkout</b> · Online payments are not processed by this
						page.
					</div>
				</form>
			</section>
			<aside class="panel">
				<div class="panel-head">
					<h2>Order Summary</h2>
					<p>Review your cart before continuing</p>
				</div>
				<div class="summary">
					<h3>Your order</h3>
					<ul class="item-list">
						<%
						for (CartItem cartItem : cart.getItems().values()) {
							Menu menu = cartItem.getMenu();
						%><li
							class="item-line"><span><strong><%=menu.getItemName()%></strong>
								× <%=cartItem.getQuantity()%></span><span>₹<%=String.format("%.2f", cartItem.getSubtotal())%></span></li>
						<%
						}
						%>
					</ul>
					<div class="coupon-card">
						<div class="coupon-head">
							<h3>Discount Coupon</h3>
						</div>
						<div class="coupon-row">
							<input id="couponCode" name="couponCode" form="paymentForm"
								type="text" placeholder="Enter coupon code">
							<button id="applyCoupon" type="button">Apply</button>
						</div>
						<div class="coupon-message" id="couponMessage">Apply a
							coupon if your order controller supports coupon validation.</div>
					</div>
					<div class="bill-row">
						<span>Item total</span><span>₹<%=String.format("%.2f", itemTotal)%></span>
					</div>
					<div class="bill-row">
						<span>Delivery fee</span><span>₹<%=String.format("%.2f", deliveryFee)%></span>
					</div>
					<div class="bill-row">
						<span>Platform fee</span><span>₹<%=String.format("%.2f", platformFee)%></span>
					</div>
					<div class="bill-row">
						<span>Taxes</span><span>₹<%=String.format("%.2f", taxes)%></span>
					</div>
					<div class="bill-row discount-row" id="discountRow"
						style="display: none">
						<span>Discount</span><span id="discountAmount">−₹0.00</span>
					</div>
					<div class="bill-row total">
						<span>Total</span><span id="grandTotal">₹<%=String.format("%.2f", grandTotal)%></span>
					</div>
					<div class="secure-card">
						<strong>Secure checkout</strong>This page submits your order to
						Cravora's existing order controller. Online payment processing
						requires a configured payment gateway.
					</div>
				</div>
			</aside>
		</div>
	</main>
	<div class="overlay" id="helpModal">
		<div class="success">
			<h2 style="margin-bottom: 10px">Cravora Help</h2>
			<p>Review your delivery address and order total. Cash on Delivery
				can be selected if supported by your order controller. Online
				payment methods are interface options only until a gateway is
				integrated.</p>
			<div class="success-actions">
				<button class="primary" id="closeHelp" type="button">Got it</button>
			</div>
		</div>
	</div>
	<div class="toast" id="toast"></div>
	<script>
(()=>{'use strict';const $=id=>document.getElementById(id);let selected='UPI';
function toast(m){const t=$('toast');t.textContent=m;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2400)}
function setForm(){['upiForm','cardForm','bankForm','walletForm','codForm'].forEach(id=>$(id).style.display='none');const map={UPI:'upiForm',Card:'cardForm',Netbanking:'bankForm',Wallet:'walletForm',COD:'codForm'};$(map[selected]).style.display='block';$('paymentMode').value=selected==='COD'?'Cash on Delivery':selected==='Card'?'Credit/Debit Card':selected;$('payButton').textContent=(selected==='COD'?'Place Order · ':'Continue · ')+$('grandTotal').textContent;}
document.querySelectorAll('.method').forEach(b=>b.addEventListener('click',()=>{document.querySelectorAll('.method').forEach(x=>x.classList.remove('active'));b.classList.add('active');selected=b.dataset.method;setForm()}));
$('editAddress').onclick=()=>{$('addressEditor').classList.toggle('show');$('deliveryAddress').focus()};$('saveAddress').onclick=()=>{const a=$('deliveryAddress').value.trim();if(!a){toast('Please enter a delivery address.');return}$('addressDisplay').textContent=a;$('addressForOrder').value=a;$('addressEditor').classList.remove('show');toast('Address updated for this order.')};
$('applyCoupon').onclick=()=>{const code=$('couponCode').value.trim();if(!code){$('couponMessage').textContent='Enter a coupon code first.';return}$('couponMessage').textContent='Coupon entered, but it cannot be validated or discounted until coupon validation is implemented in the order backend.';toast('Coupon needs server-side validation.');};
$('helpButton').onclick=()=>$('helpModal').classList.add('show');$('closeHelp').onclick=()=>$('helpModal').classList.remove('show');$('helpModal').onclick=e=>{if(e.target===$('helpModal'))$('helpModal').classList.remove('show')};
$('paymentForm').addEventListener('submit',e=>{if(selected!=='COD'){e.preventDefault();toast('Online payments are not enabled yet. Choose Cash on Delivery or integrate a payment gateway.');return}if(!$('addressForOrder').value.trim()){e.preventDefault();toast('Please enter a delivery address before placing the order.');return}});setForm();})();
</script>
</body>
</html>