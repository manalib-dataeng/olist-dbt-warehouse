# Olist E-commerce Analytics Warehouse (dbt + DuckDB)

An ELT project that turns the Olist Brazilian e-commerce dataset (9 raw CSV tables) into a tested star schema with dbt Core and DuckDB, plus a small Streamlit dashboard.

## What this project demonstrates

- Layered dbt project: sources, staging, intermediate, marts
- Star schema: 2 fact tables and 4 dimensions, with explicit grain for each
- Incremental model with a lookback window for late-arriving updates
- SCD Type 2 snapshot on sellers
- data tests: generic, custom SQL, and `dbt_expectations`
- Auto-generated docs and lineage, a dbt exposure, and CI with GitHub Actions


Lineage graph:

docs/images/lineage_graph.png

## Tech stack

dbt Core, DuckDB (dbt-duckdb adapter), Python, Streamlit, GitHub Actions

## How to run it

1. Clone the repo and create an environment:
   ```bash
   git clone https://github.com/manalib-dataeng/olist-dbt-warehouse.git
   cd olist-dbt-warehouse
   python -m venv .venv
   # Windows PowerShell: .venv\Scripts\Activate.ps1   |   Mac/Linux: source .venv/bin/activate
   pip install -r requirements.txt
   ```
2. Download the dataset from Kaggle ("Brazilian E-Commerce Public Dataset by Olist") and unzip the 9 CSVs into a `data/` folder. The data is not stored in this repo; check the dataset's license on Kaggle.
3. Load the raw tables into DuckDB:
   ```bash
   python load_raw.py
   ```
4. Build and test the project:
   ```bash
   cd olist
   dbt deps
   dbt build
   ```
5. Generate and view the docs:
   ```bash
   dbt docs generate
   dbt docs serve
   ```
6. (Optional) Run the dashboard from the repo root:
   ```bash
   streamlit run app.py
   ```

## Testing

<N> tests run on every `dbt build`:

- Generic: `unique`, `not_null`, `relationships`, `accepted_values`
- Custom SQL tests: delivery date after purchase date, non-negative payments, no orphan order items
- `dbt_expectations`: row-count bounds, value ranges

## Dashboard

docs/images/monthly_revenue.pdf
docs/images/late-delivery.pdf
docs/images/repeat_purchase_rate.pdf


## Data source

Brazilian E-Commerce Public Dataset by Olist, on Kaggle. Not redistributed here.