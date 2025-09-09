# Practical 1: Online Retail Business Database

## Objective

Design and implement a normalized relational database for an online retail business including customers, orders, suppliers, products, inventory, order items, and payments.

## Tools / Software Required

- MySQL Workbench / MySQL Server  
- VS Code or PyCharm  
- dbdiagram.io (optional)  

## Theory / Background

Retail businesses require structured data storage to manage customers, orders, and suppliers efficiently.  

- Normalization avoids redundancy  
- Foreign keys maintain referential integrity  
- Constraints (CHECK, ENUM) ensure data validity  

## Procedure

- Identify entities: Customers, Orders, Suppliers, Products, Inventory, Order_Items, Payments  

- Define relationships:  
  - Customers ↔ Orders (1:N)  
  - Orders ↔ Order_Items ↔ Products (M:N)  
  - Products ↔ Inventory (1:1)  
  - Orders ↔ Payments (1:N)  

- Apply 3NF normalization  

- Create tables with primary/foreign keys and constraints  

- Insert sample data  

- Execute queries for analytics (total revenue, stock levels, orders by status)  

## Result

The ONLINE_RETAIL_BUSINESS database was successfully created with normalized tables and relationships. Sample queries returned accurate business insights including customer orders, inventory status, and payment summaries.

## Conclusion

This practical demonstrated the end-to-end design and implementation of a normalized retail database. Data integrity, normalization, and complex query execution were successfully achieved.
