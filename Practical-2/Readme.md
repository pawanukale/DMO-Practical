# **Practical 2: E-Commerce Database**
## Objective

Design and implement a normalized database schema for an online retail (e-commerce) business. The schema should handle users, products, orders, order items, and reviews with proper relationships and constraints.

## Tools / Software Required

- Python 3.x

- MySQL Server / MySQL Workbench

- VS Code or PyCharm

- mysql-connector-python

- dbdiagram.io 

## Theory / Background

Data modeling ensures a structured representation of entities, their attributes, and relationships. Normalization up to 3NF avoids redundancy and maintains data integrity. In an e-commerce system:

- Users can place multiple orders

- Orders can contain multiple products

- Users can review products
- Relationships are enforced using primary and foreign keys, and constraints maintain data quality.

## Procedure

- Identify entities: Users, Products, Orders, Order_Items, Reviews

- Define relationships:

- Users ↔ Orders (1:N)

- Orders ↔ Products (M:N via Order_Items)

- Users ↔ Reviews ↔ Products (1:M, M:1)

- Normalize tables up to 3NF

- Create database and tables using Python and SQL

- Insert sample data and validate relationships

- Verify schema and constraints in MySQL Workbench

## Result

The ecommerce_db schema was successfully created with normalized tables, primary/foreign keys, and constraints. Queries validated user orders, product reviews, and order details.

## Conclusion

This practical demonstrated designing a relational database schema, implementing normalization, and creating tables programmatically using Python and SQL. Relationships between users, orders, products, and reviews were enforced effectively.
