<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donate Now</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .payment-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 30px;
            width: 400px;
            text-align: center;
        }
        .payment-header {
            margin-bottom: 20px;
        }
        .payment-details {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <div class="payment-header">
            <h2>Complete Your Donation</h2>
            <p>Secure Payment with Razorpay</p>
        </div>

        <div class="payment-details">
            <h4>Donation Amount</h4>
            <p class="h3 text-primary">₹ ${amount}</p>
        </div>

        <button id="rzp-button1" class="btn btn-success btn-lg w-100">
            Pay Now with Razorpay
        </button>
    </div>

    <!-- Razorpay JavaScript SDK -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
        var options = {
            "key": "${razorpayKeyId}",
            "amount": "${amount * 100}",
            "currency": "${currency}",
            "name": "NGO Donation ",
            "description": "Donation Support",
            "image": "https://example.com/your_logo.png",
            "order_id": "${orderId}",
            "handler": function (response) {

                window.location.href = "verify" +
                    "?razorpay_payment_id=" + response.razorpay_payment_id +
                    "&razorpay_order_id=" + response.razorpay_order_id +
                    "&razorpay_signature=" + response.razorpay_signature;
            },
            "prefill": {
                "name": "",
                "email": "",
                "contact": ""
            },
            "notes": {
                "type": "donation"
            },
            "theme": {
                "color": "#3399cc"
            }
        };
        var rzp1 = new Razorpay(options);


        rzp1.open();


        document.getElementById('rzp-button1').onclick = function(e){
            rzp1.open();
            e.preventDefault();
        }
    </script>
</body>
</html>