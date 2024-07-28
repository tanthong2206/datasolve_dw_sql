# Data Warehouse T-SQL Scripts

Youtube Video: https://www.youtube.com/watch?v=R_O02ZHGPto

This repository contains T-SQL scripts for setting up and managing a data warehouse. The scripts are organized into different folders for schemas, tables, stored procedures, and other related SQL components.

## Structure

- **schema/**: Scripts to create database schemas.
- **create_tables/**: Scripts to create database tables.
- **stored_proc/**: Scripts for stored procedures.
- **extra/**: Miscellaneous scripts.

## Usage

To set up the data warehouse, follow these steps:

1. **Create Schemas**:
   - Navigate to the `schema/` directory and run the scripts to create the necessary schemas.
   - Example:
     ```sql
     -- Run in SSMS or using sqlcmd
     :r schema\create_schema1.sql
     :r schema\create_schema2.sql
     ```

2. **Create Tables**:
   - Navigate to the `create_tables/` directory and run the scripts to create the tables.
   - Example:
     ```sql
     -- Run in SSMS or using sqlcmd
     :r create_tables\create_table1.sql
     :r create_tables\create_table2.sql
     ```

3. **Create Stored Procedures**:
   - Navigate to the `stored_proc/` directory and run the scripts to create the stored procedures.
   - Example:
     ```sql
     -- Run in SSMS or using sqlcmd
     :r stored_proc\create_stored_proc1.sql
     :r stored_proc\create_stored_proc2.sql
     ```

## Contributing

If you wish to expand or update anything in this repository, please follow these steps:

1. **Fork the Repository**: Create a fork of this repository to your own GitHub account.
2. **Make Your Changes**: Make the necessary updates or additions in your fork.
3. **Submit a Pull Request**: Submit a pull request with a clear description of the changes you've made.

All contributions will need to be approved before they are merged into the main repository. This ensures that all changes are reviewed for quality and consistency.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Thank you for contributing to this project!
