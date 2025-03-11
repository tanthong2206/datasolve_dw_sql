import pandas as pd
from faker import Faker
import random

# Initialize Faker
fake = Faker('en_AU')

# Number of records to generate
num_records = 1000
records_generated = 0

# Helper function to create realistic product names and categories
product_catalog = [
    {"ProductName": "Dell XPS 13", "Category": "Electronics", "ProductPrice": 1500},
    {"ProductName": "iPhone 13", "Category": "Electronics", "ProductPrice": 1200},
    {"ProductName": "Levi's 501 Jeans", "Category": "Clothing", "ProductPrice": 100},
    {"ProductName": "Nike T-Shirt", "Category": "Clothing", "ProductPrice": 25},
    {"ProductName": "LG Washing Machine", "Category": "Home Appliances", "ProductPrice": 800},
    {"ProductName": "Samsung Refrigerator", "Category": "Home Appliances", "ProductPrice": 1800},
    {"ProductName": "Harry Potter Book", "Category": "Books", "ProductPrice": 20},
    {"ProductName": "Adidas Running Shoes", "Category": "Footwear", "ProductPrice": 70},
]

# Generate Data
data = []

while records_generated < num_records:
    # Generate customer info
    customer = {
        "FirstName": fake.first_name(),
        "LastName": fake.last_name(),
        "Email": fake.email(),
        "Phone": fake.phone_number(),
        "Address": fake.street_address(),
        "City": fake.city(),
        "State": fake.state(),
        "ZipCode": fake.postcode(),
        "Country": "Australia",
    }

    # Generate multiple orders for the same customer
    num_orders = min(random.randint(1, 5), num_records - records_generated)  # Ensure we don't exceed the total num_records
    transaction_id = fake.uuid4()  # Same transaction ID for all orders of this customer
    selected_products = random.sample(product_catalog, num_orders)  # Ensure unique product names per transaction

    for product in selected_products:
        order = {
            **customer,
            "OrderDate": "26/12/2023",
            "Time": fake.time(),
            "ShippingAddress": fake.street_address(),
            "OrderStatus": "Pending",
            "ProductName": product["ProductName"],
            "ProductPrice": product["ProductPrice"],
            "Category": product["Category"],
            "Quantity": fake.random_int(min=1, max=3),
            "TransactionID": transaction_id
        }
        data.append(order)
        records_generated += 1
        if records_generated >= num_records:
            break

# Create DataFrame
df = pd.DataFrame(data)

# Save to CSV, overwriting if it exists
csv_path = r"C:\Users\kingk\Desktop\datwarehouse_blog\sourceData\eCommerceDummyData.csv"
df.to_csv(csv_path, index=False)

print(f"Data generated and saved to {csv_path}")
