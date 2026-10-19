<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Replace Cart - Cravora</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f5f5f5;
            color: #333;
        }

        /* Bottom confirmation panel */
        .replace-cart-box {
            position: fixed;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);

            width: 100%;
            max-width: 600px;

            background: white;
            padding: 25px 30px;

            border-radius: 16px 16px 0 0;

            box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.18);

            z-index: 1000;
        }

        .replace-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 12px;
        }

        .replace-message {
            color: #666;
            font-size: 15px;
            line-height: 1.5;
            margin-bottom: 22px;
        }

        .button-container {
            display: flex;
            gap: 12px;
        }

        .cart-button {
            flex: 1;
            padding: 12px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        /* Keep existing cart */
        .keep-button {
            background: white;
            color: #333;
            border: 1px solid #ccc;
        }

        .keep-button:hover {
            background: #f5f5f5;
        }

        /* Replace cart */
        .replace-button {
            background: #60b246;
            color: white;
            border: 1px solid #60b246;
        }

        .replace-button:hover {
            background: #519d3c;
        }

        /* Mobile view */
        @media (max-width: 600px) {

            .replace-cart-box {
                padding: 22px 20px;
            }

            .button-container {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

    <!-- Bottom confirmation panel -->
    <div class="replace-cart-box">

        <div class="replace-title">
            Replace your cart?
        </div>

        <div class="replace-message">
            Your cart contains items from another restaurant.
            If you continue, your existing cart will be cleared
            and replaced with the new item.
        </div>

        <div class="button-container">

            <!-- Keep the existing cart -->
            <form action="cart" method="post">
                <input type="hidden" name="action" value="keep">
                <button type="submit" class="cart-button keep-button">
                    KEEP EXISTING CART
                </button>
            </form>

            <!-- Replace the existing cart -->
            <form action="cart" method="post">
                <input type="hidden" name="action" value="replace">
                <button type="submit" class="cart-button replace-button">
                    REPLACE CART
                </button>
            </form>

        </div>

    </div>

</body>
</html>