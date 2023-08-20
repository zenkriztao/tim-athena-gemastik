class PlanetInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  PlanetInfo(
    this.position, {
    required this.name,
    required this.iconImage,
    required this.description,
    required this.images,
  });
}

List<PlanetInfo> planets = [
  
  PlanetInfo(1,
      name: 'Buku tentang - Highly Sensitive Person',
      iconImage: 'assets/HSP_parent.png',
      description:
          "Blog ini tentang sensitivitas tinggi dan pencarian sensasi tinggi karena kami menerbitkan artikel terbaru tentang masalah ini. oleh Bianca Acevedo, Art Aron dan saya, Tracy Cooper, dan Robert Marhenke: “Sensitivitas pemrosesan sensorik dan hubungannya dengan pencarian sensasi,” dalam Current Research in Behavioral Sciences edisi 2023, 4, 100100. Baca artikel selengkapnya di sini.",
      images: [
        "https://images.gr-assets.com/authors/1401536347p5/89949.jpg"
      ]),
  PlanetInfo(2,
      name: 'Buku tentang - Highly Sensitive Child',
      iconImage: 'assets/HSP_child.png',
      description:
          "Penulis buku laris dan psikolog yang bukunya mencapai 240.000 eksemplar sekarang mengatasi sifat pada anak-anak-dan menawarkan terobosan buku panduan pengasuhan untuk anak-anak yang sangat sensitif dan pengasuh mereka.",
      images: [
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1320565354i/923949.jpg",
      ]),
  PlanetInfo(3,
      name: 'Akson Multiple Literacies',
      iconImage: 'assets/book.png',
      description:
          "Definisi Literasi: kompetensi atau pengetahuan, kefasihan, pemahaman yang begitu mendasar, krusial & mendasar sehingga tanpanya, kehidupan seseorang akan sangat kurang optimal.",
      images: [
        "https://www.researchgate.net/publication/277832873/figure/fig1/AS:669477951782934@1536627390774/Multiple-literacies-a-conceptual-framework.png",
      ]),
  PlanetInfo(4,
      name: 'Buku Thrivers pada Orang tua',
      iconImage: 'assets/thrivers_parent.png',
      description:
          "Michele Borba telah menjadi guru, konsultan pendidikan, dan orang tua selama 40 tahun -- dan dia tidak pernah lebih khawatir daripada dirinya tentang generasi anak-anak saat ini. Siswa berprestasi tinggi yang dia ajak bicara setiap hari lebih berprestasi, berpendidikan lebih baik, dan lebih diistimewakan daripada sebelumnya. Mereka juga lebih stres, tidak bahagia, dan bergumul dengan kecemasan, depresi, dan kelelahan pada usia yang semakin muda -- kata seorang remaja muda.Thrivers berbeda: mereka berkembang di dunia kita yang serba cepat, didorong oleh digital, dan seringkali tidak pasti. Mengapa? Dr. Borba menyisir studi ilmiah tentang ketahanan, berbicara dengan puluhan peneliti/ahli di lapangan dan mewawancarai lebih dari 100 anak muda dari semua lapisan masyarakat, dan dia menemukan sesuatu yang mengejutkan: perbedaan antara mereka yang berjuang dan mereka yang berhasil semakin berkurang. bukan untuk nilai atau skor ujian, tetapi untuk tujuh ciri karakter yang membedakan Thrivers (dan mengaturnya untuk kebahagiaan dan pencapaian yang lebih besar di kemudian hari). Ciri-ciri ini--kepercayaan diri, empati, pengendalian diri, integritas, rasa ingin tahu, ketekunan, dan optimisme--akan memungkinkan anak-anak untuk mengatasi pukulan dan berhasil dalam hidup. Dan berita yang lebih baik lagi: sifat-sifat ini dapat diajarkan kepada anak-anak pada usia berapa pun...bahkan, orang tua dan pendidikan harus melakukannya. Dalam Thrivers, Dr. Borba menawarkan cara-cara yang praktis dan dapat ditindaklanjuti untuk mengembangkan sifat-sifat ini pada anak-anak dari prasekolah hingga sekolah menengah, menunjukkan cara mengajari anak-anak cara mengatasi hari ini sehingga mereka dapat berkembang di masa depan.",
      images: [
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1612802561i/56997619.jpg"
      ]),

];
