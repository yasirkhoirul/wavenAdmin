# Quick Setup Guide - Payment Callback Deep Link

## 📱 Android Setup (Sudah Selesai ✅)
Konfigurasi sudah ditambahkan di `android/app/src/main/AndroidManifest.xml`

**Testing:**
```bash
adb shell am start -W -a android.intent.action.VIEW \
  -d "wavenadmin://payment-result/?order_id=test123&transaction_status=settlement&status_code=200"
```

## 🪟 Windows Setup

### Step 1: Build aplikasi
```bash
flutter build windows --release
```

### Step 2: Register URL Scheme
1. Buka file: `windows/register_url_scheme.reg`
2. Edit baris terakhir, ganti path dengan lokasi `wavenadmin.exe` yang sudah di-build:
   ```
   @="\"D:\\BelajarFlutter\\Projek\\waven\\wavenadmin\\wavenadmin\\build\\windows\\x64\\runner\\Release\\wavenadmin.exe\" \"%1\""
   ```
3. Double-click file `.reg` untuk register
4. Klik "Yes" pada konfirmasi

### Step 3: Test
Buka browser dan akses:
```
wavenadmin://payment-result/?order_id=test123&transaction_status=settlement&status_code=200
```

Aplikasi akan terbuka dan menerima parameter.

## 🌐 Backend Configuration

Backend harus redirect ke:
```
wavenadmin://payment-result/?order_id={orderId}&transaction_status={status}&status_code={code}
```

**Transaction Status (Midtrans standard):**
- `settlement` atau `capture` → Pembayaran berhasil
- `pending` → Menunggu pembayaran
- `deny` atau `expire` → Pembayaran gagal/kadaluarsa
- `cancel` → Dibatalkan user

**Example Midtrans Snap Configuration:**
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

## 📋 Cara Kerja

1. User submit booking → App kirim data ke backend
2. Backend return redirect URL (Midtrans/payment gateway)
3. App buka payment page di browser/webview
4. User selesai bayar
5. Payment gateway callback ke backend
6. **Backend redirect ke `wavenadmin://payment-result?...`**
7. **OS buka/switch ke app** (Android) atau **launch app** (Windows)
8. **App terima parameter** (booking_id, status, dll)
9. App update UI / show dialog / navigate ke detail

## 🔍 Monitoring

Cek log untuk debug:
```
Logger: Deep link handler initialized
Logger: Received deep link: wavenadmin://payment-result?booking_id=xxx&status=success
Logger: Payment result received - Booking: xxx, Status: success
Logger: Payment callback received in BookingForm - Booking: xxx, Status: success
```

## ⚠️ Important Notes

- **Android**: Deep link otomatis bekerja, tidak perlu setup tambahan
- **Windows**: Harus register .reg file sekali setelah install aplikasi
- **Web**: Deep link tidak bekerja, gunakan tab baru (existing behavior)
- URL scheme: `wavenadmin://` (sudah terdaftar di AndroidManifest dan Registry)

## 🐛 Troubleshooting

### Android tidak menerima deep link
```bash
# Check if intent filter registered
adb shell dumpsys package | grep -A 5 wavenadmin
```

### Windows tidak membuka app
1. Pastikan .reg file sudah di-execute
2. Check registry: `HKEY_CLASSES_ROOT\wavenadmin`
3. Pastikan path exe sudah benar di registry

### App crash saat menerima deep link
Check log untuk error di `DeepLinkHandler._handleDeepLink()`

---

📖 **Dokumentasi lengkap:** `DEEP_LINK_SETUP.md`
