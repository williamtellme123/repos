-- -----------------------------------------------------------------------------
-- 1. Rename the primary key in Customers
-- 2. Rename the primary key in Orders
-- 3. Create FK on child (orders) to parent (customers)
-- 4. Create conctenated primary key on orderitems
-- 5. Create FK on child (orderitems) to parent (orders)
-- 6. Rename primary key on books
-- 7. Create FK on child (orderitems) to parent (books)
-- 8. Add new concatenated primary key on bookauthor
-- 9. Add new primary key on author
-- -----------------------------------------------------------------------------
-- 1. Rename the primary key in Customers
alter table customers rename constraint SYS_C006987 to customers_pk;
-- -----------------------------------------------------------------------------
-- 2. Rename the primary key in Orders
alter table orders rename constraint SYS_C006988 to orders_pk;
-- -----------------------------------------------------------------------------
-- 3. Create FK on child (orders) to parent (customers)
--    One parent(customer) to many children(orders)
--    alter table add constraint child_parent_fk foreign key (child_customer#) references customers(parent_customer#);
alter table orders add constraint orders_customers_fk foreign key (customer#) references customers(customer#);
-- -----------------------------------------------------------------------------
-- 4. Create conctenated primary key on orderitems
alter table orderitems add constraint orderitems_pk primary key (order#,item#);
-- -----------------------------------------------------------------------------
-- 5. Create FK on child (orderitems) to parent (orders)
-- alter table add constraint child_parent_fk foreign key (child_customer#) references customers(parent_customer#);
alter table orderitems add constraint orderitem_orders_fk foreign key (order#) references orders(order#);
-- -----------------------------------------------------------------------------
-- 6. Rename primary key on books
alter table books rename constraint SYS_C006989 to books_pk;
-- -----------------------------------------------------------------------------
-- 7. Create FK on child (orderitems) to parent (books)
alter table orderitems add constraint orderitem_books_fk foreign key (isbn) references books(isbn);
-- -----------------------------------------------------------------------------
-- 8. Add new concatenated primary key on bookauthor
alter table bookauthor add constraint book_author_pk primary key (authorid,isbn);
-- -----------------------------------------------------------------------------
-- 9. Add new primary key on author
alter table author add constraint author_pk primary key (authorid);
-- -----------------------------------------------------------------------------
-- 10. Create FK on child (bookauthor) to parent (books)
--     alter table add constraint child_parent_fk foreign key (child_customer#) references customers(parent_customer#);
alter table bookauthor add constraint bookauthor_books_fk foreign key (isbn) references books(isbn);
-- -----------------------------------------------------------------------------
-- 11. Create FK on child (bookauthor) to parent (author)
alter table bookauthor add constraint bookauthor_author_fk foreign key (authorid) references author(authorid);
-- -----------------------------------------------------------------------------
-- 12. Add new primary key publisher
alter table publisher add constraint publisher_pk primary key (pubid);
-- -----------------------------------------------------------------------------
-- 13. Create FK on child (books) to parent (publisher)
alter table books add constraint book_pub_fk foreign key (pubid) references publisher(pubid);






