📦 Project Title: Global Logistics and Supply Chain Management System
📄 1. Project Overview
The Global Logistics and Supply Chain Management System (GLSCMS) is designed to manage and monitor the flow of goods, carriers, employees, warehouses, and clients across a global logistics network. It supports shipment tracking, warehouse storage, cross-docking, customs clearance, and multi-leg carrier routing. This system enhances transparency, efficiency, and coordination in logistics and distribution channels.

🎯 2. Objectives
Track shipments across multiple routes and carriers.

Monitor warehouse storage and cross-docking activities.

Maintain sender and receiver details for each shipment.

Manage carrier types (air, land, sea) and their assignments.

Record customs clearance for international shipments.

Assign employees to either carriers or warehouses (but not both).

Handle real-time data on storage, transfers, and delays.

📊 3. Entity-Relationship Design
🔹 Entities & Attributes:
Clients

client_id (PK)

name

address

Carriers

carrier_id (PK)

name

type (Air, Land, Sea)

contact_info

Warehouses

warehouse_id (PK)

location

capacity

Employees

employee_id (PK)

name

role

assigned_warehouse_id (FK to Warehouses)

assigned_carrier_id (FK to Carriers)

Constraint: Assigned to only one — warehouse or carrier.

Shipments

shipment_id (PK)

origin

destination

weight

content_description

shipment_date

Shipment_Carriers

shipment_id (FK)

carrier_id (FK)

leg_number (PK component for sequencing)

Shipment_Clients

shipment_id (FK)

client_id (FK)

role (Sender / Receiver)

Shipment_Warehouses

shipment_id (FK)

warehouse_id (FK)

storage_start

storage_end

Customs_Clearance

clearance_id (PK)

shipment_id (FK)

country

clearance_date

status (Pending / Cleared / Held)

Cross_Docking

operation_id (PK)

shipment_id (FK)

from_warehouse_id (FK)

to_warehouse_id (FK)

transfer_time

🧱 4. Constraints and Rules
A shipment can pass through multiple warehouses but be stored in only one at a time.

Shipments can have multiple carriers across legs but one carrier per leg.

Employees must be exclusively assigned to either a warehouse or a carrier.

Customs clearance is tracked for international shipments.

Cross-docking enables rapid shipment movement between warehouses.

🗃️ 5. Database Schema
The project includes 10 main tables:

Clients, Carriers, Warehouses, Employees, Shipments,

Shipment_Carriers, Shipment_Clients, Shipment_Warehouses,

Customs_Clearance, Cross_Docking.

Each table is normalized and indexed by primary and foreign keys to maintain referential integrity and optimize queries.

🧪 6. Sample Data
All tables are populated with at least 7 realistic rows using India-specific names, locations, and companies to simulate a regional logistics network.

🧾 7. Use Cases
Shipment Tracking: Know the route, carriers used, and storage warehouses.

Client Management: View shipments sent and received by each client.

Employee Allocation: Manage workforce distribution between warehouses and carriers.

Cross-Docking Operations: Log and trace fast-moving shipment transfers.

Compliance & Clearance: Monitor customs processing for international freight.

📌 8. Future Enhancements
Integrate GPS and real-time tracking APIs.

Automate customs documents generation.

Add UI dashboard for logistics managers.

Introduce notifications for shipment delays or clearance holds.

Implement analytics on carrier performance and storage optimization.

👨‍💻 9. Technologies Used
Database: MySQL

Tools: MySQL Workbench / phpMyAdmin

Platform: Windows/Linux

📚 10. Conclusion
The Global Logistics and Supply Chain Management System provides a scalable and robust foundation for managing complex logistics operations. It centralizes shipment, warehouse, employee, and carrier data into a unified, easily accessible relational model — facilitating timely and effective decision-making.

