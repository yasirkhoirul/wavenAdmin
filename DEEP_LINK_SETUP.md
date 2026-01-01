# Payment Callback Deep Link Configuration

## Overview
Setelah pembayaran selesai, backend harus redirect ke custom URL scheme aplikasi untuk mengirim payment result ke admin app.

## URL Format
```
wavenadmin://payment-result/?order_id=xxx&transaction_status=settlement&status_code=200
```

### Required Parameters:
- `order_id` (string): ID booking/order yang telah dibuat
- `transaction_status` (string): Status transaksi dari payment gateway

### Transaction Status Values (Midtrans):
- `settlement` atau `capture`: Pembayaran berhasil
- `pending`: Pembayaran pending/menunggu
- `deny` atau `expire`: Pembayaran gagal/kadaluarsa
- `cancel`: Pembayaran dibatalkan oleh user

### Optional Parameters:
- `status_code` (string): HTTP status code dari payment gateway
- `transaction_id` (string): ID transaksi payment gateway
- `payment_type` (string): Tipe pembayaran (gopay, bank_transfer, dll)
- `gross_amount` (string): Total amount yang dibayar

## Example URLs

### Success Payment (Settlement):
```
wavenadmin://payment-result/?order_id=019b7308-f99d-7384-9dde-1b9e5872fab9&transaction_status=settlement&status_code=200
```

### Pending Payment:
```
wavenadmin://payment-result/?order_id=book123&transaction_status=pending&status_code=201
```

### Failed Payment:
```
wavenadmin://payment-result/?order_id=book123&transaction_status=deny&status_code=400
```

### Cancelled Payment:
```
wavenadmin://payment-result/?order_id=book123&transaction_status=cancel&status_code=200
```

## Platform-Specific Behavior

### Android
- App akan otomatis terbuka (atau kembali ke foreground jika sudah buka)
- Payment browser akan tertutup otomatis
- Parameter akan langsung ter-capture oleh app

### Windows
- Jika app masih running: akan kembali ke app dengan parameter
- Jika app tertutup: akan membuka app dengan parameter

### Web Browser
- Deep link tidak bekerja di web
- Web tetap menggunakan tab baru, user manual close tab

## Backend Implementation Example

### Midtrans Finish URL Configuration:
Saat create Snap transaction, set finish_url:
```go
snapReq := &snap.Request{
    TransactionDetails: midtrans.TransactionDetails{
        OrderID:  bookingID,
        GrossAmt: int64(amount),
    },
    Callbacks: &snap.Callbacks{
        Finish: fmt.Sprintf(
            "wavenadmin://payment-result/?order_id=%s",
            bookingID,
        ),
    },
}
```

### Alternative: Custom Finish URL Handler
Jika perlu validasi backend dulu sebelum redirect:
```go
// Set finish URL ke backend endpoint
Finish: "https://yourdomain.com/payment/finish"

// Handler
func HandlePaymentFinish(w http.ResponseWriter, r *http.Request) {
    orderID := r.URL.Query().Get("order_id")
    transactionStatus := r.URL.Query().Get("transaction_status")
    statusCode := r.URL.Query().Get("status_code")
    
    // Optional: Validate with Midtrans API
    // Optional: Update database
    
    // Redirect to app
    redirectURL := fmt.Sprintf(
        "wavenadmin://payment-result/?order_id=%s&transaction_status=%s&status_code=%s",
        orderID,
        transactionStatus,
        statusCode,
    )
    
    http.Redirect(w, r, redirectURL, http.StatusSeeOther)
}
```

## Testing

### Android:
```bash
# Test deep link via ADB
adb shell am start -W -a android.intent.action.VIEW \
  -d "wavenadmin://payment-result/?order_id=test123&transaction_status=settlement&status_code=200"

# Test dengan status lain
adb shell am start -W -a android.intent.action.VIEW \
  -d "wavenadmin://payment-result/?order_id=test123&transaction_status=pending&status_code=201"
```

### Windows:
1. Register URL scheme: Double-click `windows/register_url_scheme.reg`
2. Update path in .reg file to actual wavenadmin.exe path
3. Test: Open browser and navigate to:
   ```
   wavenadmin://payment-result/?order_id=test123&transaction_status=settlement&status_code=200
   ```

## App Handling

Saat deep link diterima, app akan:
1. Parse URL parameters
2. Log payment result
3. Update UI state
4. (Optional) Show dialog konfirmasi
5. (Optional) Navigate to booking detail page
6. (Optional) Refresh booking list

## Notes

- URL encoding dihandle otomatis oleh app
- Parameters case-insensitive untuk status
- Semua parameter disimpan di Map untuk akses tambahan
- Deep link handler di-initialize di `main.dart`
- Payment callback listener di-setup di `booking_form_state.dart`
