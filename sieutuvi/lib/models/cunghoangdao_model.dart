enum EnumCungHoangDao {
  bachDuong("Aries", "♈ Bạch Dương", "Tử vi hằng ngày cung Bạch Dương"),
  kimNguu("Taurus", "♉ Kim Ngưu", "Tử vi hằng ngày cung Kim Ngưu"),
  songTu("Gemini", "♊ Song Tử", "Tử vi hằng ngày cung Song Tử"),
  cuGiai("Cancer", "♋ Cự Giải", "Tử vi hằng ngày cung Cự Giải"),
  suTu("Leo", "♌ Sư Tử", "Tử vi hằng ngày cung Sư Tử"),
  xuNu("Virgo", "♍ Xử Nữ", "Tử vi hằng ngày cung Xử Nữ"),
  thienBinh("Libra", "♎ Thiên Bình", "Tử vi hằng ngày cung Thiên Bình"),
  boCap("Scorpio", "♏ Bọ Cạp", "Tử vi hằng ngày cung Bọ Cạp"),
  nhanMa("Sagittarius", "♐ Nhân Mã", "Tử vi hằng ngày cung Nhân Mã"),
  maKet("Capricorn", "♑ Ma Kết", "Tử vi hằng ngày cung Ma Kết"),
  baoBinh("Aquarius", "♒ Bảo Bình", "Tử vi hằng ngày cung Bảo Bình"),
  songNgu("Pisces", "♓ Song Ngư", "Tử vi hằng ngày cung Song Ngư");

  final String name;
  final String vnName;
  final String prompt;

  const EnumCungHoangDao(this.name, this.vnName, this.prompt);
}

enum Enum12ConGiap {
  ty("Rat", "🐀 Tý", "Tử vi hằng ngày tuổi Tý"),
  suu("Ox", "🐂 Sửu", "Tử vi hằng ngày tuổi Sửu"),
  dan("Tiger", "🐅 Dần", "Tử vi hằng ngày tuổi Dần"),
  mao("Rabbit", "🐇 Mão", "Tử vi hằng ngày tuổi Mão"),
  thin("Dragon", "🐉 Thìn", "Tử vi hằng ngày tuổi Thìn"),
  tyMui("Snake", "🐍 Tỵ", "Tử vi hằng ngày tuổi Tỵ"),
  ngo("Horse", "🐎 Ngọ", "Tử vi hằng ngày tuổi Ngọ"),
  mui("Goat", "🐐 Mùi", "Tử vi hằng ngày tuổi Mùi"),
  than("Monkey", "🐒 Thân", "Tử vi hằng ngày tuổi Thân"),
  dau("Rooster", "🐓 Dậu", "Tử vi hằng ngày tuổi Dậu"),
  tuat("Dog", "🐕 Tuất", "Tử vi hằng ngày tuổi Tuất"),
  hoi("Pig", "🐖 Hợi", "Tử vi hằng ngày tuổi Hợi");

  final String name; // Tên tiếng Anh
  final String vnName; // Tên tiếng Việt
  final String prompt; // Text prompt

  const Enum12ConGiap(this.name, this.vnName, this.prompt);
}
