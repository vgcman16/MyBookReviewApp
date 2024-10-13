import { Injectable } from '@angular/core'

import { Book } from './book'

@Injectable({
  providedIn: 'root',
})
export class BookService {
  private books = new Array<Book>(
    { id: 1, title: 'To Kill a Mockingbird', author: 'Harper Lee', rating: 5, review: 'A classic that explores racial injustice and loss of innocence in the American South.' },
    { id: 2, title: '1984', author: 'George Orwell', rating: 4, review: 'A dystopian novel that paints a chilling picture of a totalitarian future.' },
    { id: 3, title: 'Pride and Prejudice', author: 'Jane Austen', rating: 5, review: 'A witty and romantic novel about the relationship between Elizabeth Bennet and Mr. Darcy.' },
    { id: 4, title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', rating: 4, review: 'A critique of the American Dream set in the Roaring Twenties.' },
    { id: 5, title: 'One Hundred Years of Solitude', author: 'Gabriel García Márquez', rating: 5, review: 'A multi-generational saga that blends reality with magic.' }
  )

  getBooks(): Array<Book> {
    return this.books
  }

  getBook(id: number): Book {
    return this.books.filter((book) => book.id === id)[0]
  }
}