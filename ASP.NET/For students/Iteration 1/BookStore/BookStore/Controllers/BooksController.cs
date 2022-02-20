using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml;

namespace BookStore.Controllers
{
    public class BooksController : Controller
    {
        private readonly XmlDocument _booksDocument;
        public BooksController()
        {
            _booksDocument = new XmlDocument();
            _booksDocument.Load("Data/Books.xml");
        }

        public ViewResult AllBooks()
        {
            ViewData["Title"] = "All Books";
            return View(_booksDocument.DocumentElement.SelectNodes("book"));
        }

        [Route("Books/AllBooks/{status}")]
        public ViewResult AllBooks(string status)
        {
            string xpath;
            if (string.Equals(status, "available", StringComparison.InvariantCultureIgnoreCase))
            {
                xpath = "book[status='available']";
                ViewData["Title"] = "Available Books";
            }
            else if (string.Equals(status, "programming", StringComparison.InvariantCultureIgnoreCase))
            {
                xpath = "book[category='Programming']";
                ViewData["Title"] = "Books about Programming";
            }
            else if (string.Equals(status, "less50", StringComparison.InvariantCultureIgnoreCase))
            {
                xpath = "book[price<50]";
                ViewData["Title"] = "Books cheaper than 50$";
            }
            else
            {
                xpath = "book";
                ViewData["Title"] = "All Books";
            }

            return View(_booksDocument.DocumentElement.SelectNodes(xpath));
        }

        public ViewResult AllAuthors()
        {
            ViewData["Title"] = "All Authors";
            return View(_booksDocument.DocumentElement.SelectNodes("book"));
        }

    }
}
