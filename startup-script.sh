#!/bin/bash

# Update system
apt-get update
apt-get install -y nginx

# Create Venmo-enabled web page
cat > /var/www/html/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #008CFF 0%, #00C4FF 100%);
            padding: 20px;
        }
        .container {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }
        h1 {
            color: #008CFF;
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        .amount-input {
            width: 100%;
            padding: 1rem;
            font-size: 1.5rem;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            margin: 1rem 0;
            text-align: center;
        }
        .note-input {
            width: 100%;
            padding: 0.8rem;
            font-size: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            margin: 1rem 0;
        }
        .venmo-btn {
            background: #008CFF;
            color: white;
            border: none;
            padding: 1rem 2rem;
            font-size: 1.2rem;
            font-weight: 600;
            border-radius: 12px;
            cursor: pointer;
            width: 100%;
            margin: 0.5rem 0;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .venmo-btn:hover {
            background: #0077d9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,140,255,0.3);
        }
        .venmo-logo {
            font-size: 1.5rem;
            font-weight: 700;
        }
        .info {
            margin-top: 1.5rem;
            padding: 1rem;
            background: #f5f5f5;
            border-radius: 10px;
            font-size: 0.9rem;
            color: #666;
        }
        .username {
            color: #008CFF;
            font-weight: 600;
        }
        .qr-section {
            margin-top: 1.5rem;
            padding: 1rem;
            background: #f9f9f9;
            border-radius: 10px;
        }
        .qr-code {
            width: 200px;
            height: 200px;
            margin: 1rem auto;
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>💸 Quick Payment</h1>
        
        <input type="number" class="amount-input" id="amount" placeholder="$0.00" min="0" step="0.01">
        <input type="text" class="note-input" id="note" placeholder="What's this for? (optional)">
        
        <button class="venmo-btn" onclick="openVenmo()">
            <span class="venmo-logo">V</span>
            Pay with Venmo
        </button>
        
        <div class="info">
            <p>Or send directly to:</p>
            <p class="username">@your-venmo-username</p>
        </div>
        
        <div class="qr-section">
            <p style="color: #666; margin-bottom: 0.5rem;">Scan to pay:</p>
            <div class="qr-code" id="qrcode">
                <!-- QR code will be generated here -->
            </div>
        </div>
    </div>
    
    <!-- Include QR code library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
    
    <script>
        const VENMO_USERNAME = 'your-venmo-username'; // Replace with your Venmo username
        
        function openVenmo() {
            const amount = document.getElementById('amount').value;
            const note = document.getElementById('note').value;
            
            // Build Venmo deep link
            let venmoUrl = `venmo://paycharge?txn=pay&recipients=${VENMO_USERNAME}`;
            
            if (amount) {
                venmoUrl += `&amount=${amount}`;
            }
            if (note) {
                venmoUrl += `&note=${encodeURIComponent(note)}`;
            }
            
            // For mobile: Opens Venmo app directly
            // For desktop: Falls back to web version
            const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
            
            if (isMobile) {
                window.location.href = venmoUrl;
            } else {
                // Desktop fallback: open Venmo web
                window.open(`https://venmo.com/${VENMO_USERNAME}`, '_blank');
            }
        }
        
        // Generate QR code for Venmo profile
        window.onload = function() {
            new QRCode(document.getElementById("qrcode"), {
                text: `https://venmo.com/${VENMO_USERNAME}`,
                width: 180,
                height: 180,
                colorDark: "#008CFF",
                colorLight: "#ffffff",
            });
        }
    </script>
</body>
</html>
EOF

# Start nginx
systemctl restart nginx
systemctl enable nginx