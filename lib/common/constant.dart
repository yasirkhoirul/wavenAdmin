class Constant {
  const Constant._();
  static final List<String> timeSlots = [
    "05:30-06:30",
    "06:30-07:30",
    "07:30-08:30",
    "08:30-09:30",
    "09:30-10:30",
    "10:30-11:30",
    "11:30-12:30",
    "12:30-13:30",
    "13:00-14:00",
    "14:00-15:00",
    "15:00-16:00",
    "16:00-17:00",
    "17:00-18:00",
  ];
}

enum Sort{
  asc,
  desc
}

enum AksiBooking{
  waclient,
  wafotografer,
  detail,
  verifikasi,
  hapus
}

enum RequestState{
  init,
  loading,
  error,
  succes
}

enum Status{
  aktif,
  tidakaktif
}
enum SortPhotographer{
  id,
  name,
  phone_number,
  account_number,
  bank_account,
  fee_per_hour,
  gears,
  instagram,
  location,
}

enum SortAdmin{
  name,
  email,
  is_active,
  type
}

enum SortUser{
  username,
  name,
  email,
  type,
  university_name
}

enum VerificationStatus{
  PENDING,
  REJECTED,
  APPROVED
}

enum StatusBooking{
  PENDING,
  DP,
  LUNAS,
  CANCELLED
}

enum VerifyStatus{
  approved,
  rejected
}

enum TransactionPayType{
  lunas,
  pelunasan,
  dp
}
enum TransactionPayMethod{
  va,
  qris,
  transfer,
  cash
}

enum Platform{
  web,
  android,
  ios
}
