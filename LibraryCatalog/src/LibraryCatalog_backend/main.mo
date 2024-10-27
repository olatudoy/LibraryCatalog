import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Nat "mo:base/Nat";

actor {
  type BookId = Nat;
  
  type Book = {
    id : BookId;
    title : Text;
    author : Text;
    genre : Text;
  };

  var books = Buffer.Buffer<Book>(0);

  public func addBook(title : Text, author : Text, genre : Text) : async BookId {
    let bookId = books.size();
    let newBook : Book = {
      id = bookId;
      title = title;
      author = author;
      genre = genre;
    };
    books.add(newBook);
    bookId;
  };

  public query func getBook(bookId : BookId) : async ?Book {
    if (bookId < books.size()) {
      ?books.get(bookId);
    } else {
      null;
    };
  };

  public query func getAllBooks() : async [Book] {
    Buffer.toArray(books);
  };

  public query func searchByGenre(genre : Text) : async [Book] {
    let results = Buffer.Buffer<Book>(0);
    for (book in books.vals()) {
      if (Text.equal(book.genre, genre)) {
        results.add(book);
      };
    };
    Buffer.toArray(results);
  };

  public query func searchByAuthor(author : Text) : async [Book] {
    let results = Buffer.Buffer<Book>(0);
    for (book in books.vals()) {
      if (Text.equal(book.author, author)) {
        results.add(book);
      };
    };
    Buffer.toArray(results);
  };
};