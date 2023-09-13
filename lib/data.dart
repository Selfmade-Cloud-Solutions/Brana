
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
      108,
      "assets/authors/ፍሬዓለምሺባባው.jpg",
    ),
    Author(
      "እንዳለጌታከበደ",
      99,
      "assets/authors/እንዳለጌታከበደ.jpg",
    ),
    Author(
      "ዘነበ ወላ",
      90,
      "assets/authors/ዘነበወላ.jpg",
    ),
    Author(
      " ሀዲስ አለማየሁ",
      87,
      "assets/authors/ ሀዲስአለማየሁ.jpeg",
    ),
    Author(
      "ሰለሞን ሙሉጌታ ካሳ",
      77,
      "assets/authors/ሰለሞንሙሉጌታካሳ.jpg",
    ),
    Author(
      "በዓሉ ግርማ",
      75,
      "assets/authors/bealu.jpeg",
    ),
    Author(
      "መለሰ እሸቱ",
      70,
      "assets/authors/መለሰእሸቱ.jpg",
    ),
    Author(
      "አለማየሁ ዋሴ",
      65,
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
    "title":"ላስብበት",
    "author":"ፍሬዓለም ሺባባው",
    "length":"22:49",
    "image":"ላስብበት.jpg"
  },{
    "title":"ስቅታ",
    "author":"ሮማን አፈወርቅ",
    "length":"64:11",
    "image":"ስቅታ.jpg"
  },
  {
    "title":"እስረኞቹ",
    "author":"እንዳለጌታ ከበደ",
    "length":"51:49",
    "image":"እስረኞቹ.jpg"
  },
  {
    "title":"ሀብት ያለው አእምሮህ",
    "author":"መለሰ እሸቱ",
    "length":"72:19",
    "image":"ሀብት_ያለው_አእምሮህ.jpg"
  },
  {
    "title":"ቴሎስ",
    "author":"ናሁሰናይ ፀዳሉ",
    "length":"19:49",
    "image":"ቴሎስ.jpg"
  },
  {
    "title":"ልጅነት",
    "author":"ዘነበ ወላ",
    "length":"34:49",
    "image":"ልጅነት.jpg"
  },
  {
    "title":"ወንጀለኛው ዳኛ",
    "author":"ሀዲስ አለማየሁ ",
    "length":"17:99",
    "image":"ወንጀለኛው_ዳኛ.jpg"
  },
  {
    "title":"ማሃትማ ጋንዲ",
    "author":"ሙሉቀን ታሪኩ",
    "length":"82:29",
    "image":"ማሃትማ_ጋንዲ.jpg"
  },
  {
    "title":"ጠበሳ",
    "author":"ጥቁማለት",
    "length":"46:49",
    "image":"ጠበሳ.jpg"
  }
];