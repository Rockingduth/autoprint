# Order AutoPrint

A WooCommerce auto-printing tool for thermal receipt printers (ESC/POS), written in Java 17 with **no external
dependencies** (JDK only: Swing, `com.sun.net.httpserver`, `javax.print`).

## Run
- Prebuilt: `java -jar order-autoprint.jar` (add `--hidden` to start in the tray, `--headless` for server-only).
- Build the .exe: run `build.bat` on Windows with a JDK 17+ (output: `out\package\Order AutoPrint\Order AutoPrint.exe`), or push this folder to GitHub and run the "Build Windows exe" workflow to download a ready zip.

## WooCommerce setup
WooCommerce > Settings > Advanced > Webhooks > Add webhook:
- Topic: **Order created** (add a second one for **Order updated**)
- Delivery URL: `http://<this-pc-ip>:8765/order`
- Secret: same value as in Settings > Server (optional but recommended; signatures are verified with HMAC-SHA256)
- Status: Active

## Features
- Local webhook server (port, bind address and secret configurable); answers WooCommerce's form-encoded ping.
- Parses orders: items, add-ons (item meta), fees, shipping, discount, tax, customer, phone, address, note,
  delivery/pickup type, scheduled time (from configurable order-meta keys), payment state (PAID / COD / PENDING).
- Receipt printing over ESC/POS: network printer (TCP 9100) or an installed Windows printer; 58/80 mm paper,
  copies, paper cut, cash-drawer pulse, code page 858 (Euro/accents).
- Print queue with 3 attempts per order; per-order **Print** button; double-click a row for a receipt preview.
- Duplicate protection: a persistent ledger ensures repeated webhooks never reprint an order automatically.
- Auto-print rules: on/off, allowed statuses, skip online orders still awaiting payment.
- Settings dialog, test print, live log, order history (last 300, survives restarts).
- System tray: closing the window hides it, double-click the icon to reopen, right-click > Exit to quit.
- Optional start with Windows (HKCU Run key, launches hidden in the tray).
- Single-instance guard.

Data (settings, logs, order history, ledger) lives in `%LOCALAPPDATA%\Order AutoPrint`.
The app name is a single constant in `AppInfo.java`.

Not included: a license/activation system.
