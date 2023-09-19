class Book {
  String title;
  String description;
  Author author;
  String score;
  String image;

  Book(this.title, this.description, this.author, this.score, this.image);
}

List<Book> getBookList() {
  return <Book>[
    Book(
      "ላስብበት",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ፍሬዓለም ሺባባው",
        90,
        "assets/authors/ፍሬዓለምሺባባው.jpg",
      ),
      " ",
      "assets/books/ላስብበት.jpg",
    ),
    Book(
      "ስቅታ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ሮማን አፈወርቅ",
        123,
        "assets/authors/ፍሬዓለምሺባባው.jpg",
      ),
      " ",
      "assets/books/ስቅታ.jpg",
    ),
    Book(
      "እስረኞቹ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "እንዳለጌታ ከበደ",
        99,
        "assets/authors/እንዳለጌታከበደ.jpg",
      ),
      " ",
      "assets/books/እስረኞቹ.jpg",
    ),
    Book(
      "ሀብት ያለው አእምሮህ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "መለሰ እሸቱ",
        134,
        "assets/authors/መለሰእሸቱ.jpg",
      ),
      " ",
      "assets/books/ሀብት_ያለው_አእምሮህ.jpg",
    ),
    Book(
      "ቴሎስ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ናሁሰናይ ፀዳሉ",
        87,
        "assets/authors/መለሰእሸቱ.jpg",
      ),
      " ",
      "assets/books/ቴሎስ.jpg",
    ),
    Book(
      "ልጅነት",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ዘነበ ወላ",
        108,
        "assets/authors/ዘነበወላ.jpg",
      ),
      " ",
      "assets/books/ልጅነት.jpg",
    ),
    Book(
      "ወንጀለኛው ዳኛ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ሀዲስ አለማየሁ ",
        77,
        "assets/authors/ ሀዲስ አለማየሁ.jpeg",
      ),
      " ",
      "assets/books/ወንጀለኛው_ዳኛ.jpg",
    ),
    Book(
      "ማሃትማ ጋንዲ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ሙሉቀን ታሪኩ",
        112,
        "assets/authors/ዘነበወላ.jpg",
      ),
      " ",
      "assets/books/ማሃትማ_ጋንዲ.jpg",
    ),
    Book(
      "ጠበሳ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ጥቁማለት",
        65,
        "assets/authors/መለሰእሸቱ.jpg",
      ),
      " ",
      "assets/books/ጠበሳ.jpg",
    ),
    Book(
      "ለምትኬ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ደረጀ ለማ ደገፉ",
        75,
        "assets/authors/መለሰእሸቱ.jpg",
      ),
      " ",
      "assets/books/ለምትኬ.jpg",
    ),
    Book(
      "ግርምተ ሳይቴክ",
      "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
      Author(
        "ሰለሞን ሙሉጌታ ካሳ",
        70,
        "assets/authors/ሰለሞንሙሉጌታካሳ.jpg",
      ),
      " ",
      "assets/books/ግርምተ_ሳይቴክ.jpg",
    ),
  ];
}

class Author {
  String fullname;
  int books;
  String image;

  Author(this.fullname, this.books, this.image);
}

List<Author> getAuthorList() {
  return <Author>[
    Author(
      "ፍሬዓለም ሺባባው",
      18,
      "assets/authors/ፍሬዓለምሺባባው.jpg",
    ),
    Author(
      "እንዳለጌታከበደ",
      12,
      "assets/authors/እንዳለጌታከበደ.jpg",
    ),
    Author(
      "ዘነበ ወላ",
      9,
      "assets/authors/ዘነበወላ.jpg",
    ),
    Author(
      " ሀዲስ አለማየሁ",
      7,
      "assets/authors/ ሀዲስአለማየሁ.jpeg",
    ),
    Author(
      "ሰለሞን ሙሉጌታ ካሳ",
      3,
      "assets/authors/ሰለሞንሙሉጌታካሳ.jpg",
    ),
    Author(
      "በዓሉ ግርማ",
      5,
      "assets/authors/bealu.jpeg",
    ),
    Author(
      "መለሰ እሸቱ",
      10,
      "assets/authors/መለሰእሸቱ.jpg",
    ),
    Author(
      "አለማየሁ ዋሴ",
      15,
      "assets/authors/ አለማየሁዋሴ.jpg",
    ),
  ];
}

class Filter {
  String title;

  Filter(this.title);
}

List<Filter> getFilterListHome() {
  return <Filter>[
    Filter("CLASSICS"),
    Filter("NEW"),
    Filter("UPCOMING"),
  ];
}

List<Filter> getFilterListExplore() {
  return <Filter>[
    Filter("AUDIOBOOKS"),
    Filter("PODCASTS"),
  ];
}

const booksExplore = [
  {
    "genre": "Children",
    "subGenre": "folk tales, fairy tales, fables",
    "length": "34:49",
    "image": "ልጅነት.jpg"
  },
  {
    "genre": "Fiction / Folklore",
    "subGenre": "Short stories",
    "length": "22:49",
    "image": "ላስብበት.jpg"
  },
  {
    "genre": "Telenovela",
    "subGenre": "Romantic comedy",
    "length": "64:11",
    "image": "ስቅታ.jpg"
  },
  {
    "genre": "Comedic Literature ",
    "subGenre": "Satire",
    "length": "51:49",
    "image": "እስረኞቹ.jpg"
  },
  {
    "genre": "Adult",
    "subGenre": "Erotica",
    "length": "72:19",
    "image": "ሀብት_ያለው_አእምሮህ.jpg"
  },
  {
    "genre": "Poetry",
    "subGenre": "Sonnets",
    "length": "19:49",
    "image": "ቴሎስ.jpg"
  },
  {
    "genre": "Journal",
    "subGenre": "Memoir",
    "length": "17:99",
    "image": "ወንጀለኛው_ዳኛ.jpg"
  },
  {
    "genre": "Biography",
    "subGenre": "Political biography",
    "length": "82:29",
    "image": "ማሃትማ_ጋንዲ.jpg"
  },
  {
    "genre": "Fantasy",
    "subGenre": "High fantasy",
    "length": "46:49",
    "image": "ጠበሳ.jpg"
  },
  {
    "genre": "Thriller",
    "subGenre": "Police procedural",
    "length": "34:49",
    "image": "ልጅነት.jpg"
  },
  {
    "genre": "Philosophy",
    "subGenre": "Political philosophy",
    "length": "22:49",
    "image": "ላስብበት.jpg"
  },
];

class CourseModel {
  String name;
  String description;
  String author;
  String duration;
  String chapters;
  String episodes;
  String thumbnail;

  CourseModel(
      {required this.name,
      required this.description,
      required this.duration,
      required this.author,
      required this.chapters,
      required this.episodes,
      required this.thumbnail});
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        name: "ላስብበት",
        description:
            "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
        author: "ፍሬዓለም ሺባባው",
        duration: "210 minutes",
        chapters: "12 chapters",
        episodes: "56 Episodes",
        thumbnail: "assets/books/ላስብበት.jpg"),
    CourseModel(
        name: "ስቅታ",
        description:
            "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
        author: "ሮማን አፈወርቅ",
        duration: "210 minutes",
        chapters: "12 chapters",
        episodes: "56 Episodes",
        thumbnail: "assets/books/ስቅታ.jpg"),
    CourseModel(
        name: "እስረኞቹ",
        description:
            "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
        author: "እንዳለጌታ ከበደ",
        duration: "210 minutes",
        chapters: "12 chapters",
        episodes: "56 Episodes",
        thumbnail: "assets/books/እስረኞቹ.jpg"),
    CourseModel(
        name: "ልጅነት",
        description:
            "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
        author: "ፍሬዓለም ሺባባው",
        duration: "210 minutes",
        chapters: "12 chapters",
        episodes: "56 Episodes",
        thumbnail: "assets/books/ልጅነት.jpg"),
    CourseModel(
        name: "ሀብት ያለው አእምሮህ",
        description:
            "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
        author: "ሮማን አፈወርቅ",
        duration: "210 minutes",
        chapters: "12 chapters",
        episodes: "56 Episodes",
        thumbnail: "assets/books/ሀብት_ያለው_አእምሮህ.jpg"),
    CourseModel(
        name: "ቴሎስ",
        description:
            "የመንገድ ሠራተኛ ታክሢውን አስቁሞ ገባ እሱ በገባበት ቅስበት ታክሢውን የሽንት ቤት ሽታ ሞላው ሁሉም ሠው ተገርሞ ግማሹ መስኮት ይከፋታል ግማሹ ኡፋ ኡፉ እያለ ወያላው ወደ ቻይናው እያየ ሄሎ ቻይንዬ ፈሣሽ እንዴ?እሥቲ ሂሣብ አለ ?..",
        author: "እንዳለጌታ ከበደ",
        duration: "210 minutes",
        chapters: "12 chapters",
        episodes: "56 Episodes",
        thumbnail: "assets/books/ቴሎስ.jpg"),
  ];
}
