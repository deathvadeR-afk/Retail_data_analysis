# Retail Customer Analysis and RFM Segmentation

## Overview

This project analyzes customer transaction data from a retail dataset to understand customer behavior and perform Recency, Frequency, Monetary (RFM) segmentation. The analysis involves loading raw transaction and customer response data, cleaning and preprocessing the data, engineering relevant features (including RFM metrics), and segmenting customers based on their RFM scores. The primary goal is to identify distinct customer groups to enable targeted marketing strategies or other business decisions.

The analysis is performed using Python with the pandas library within a Jupyter Notebook (`data_cleaning_preprocessing.ipynb`). Intermediate and final datasets are saved as CSV files.

## Data

The analysis utilizes the following data files:

*   **`Retail_Data_Transactions.csv`**: Contains raw customer transaction records.
    *   `customer_id`: Unique identifier for each customer.
    *   `trans_date`: Date of the transaction.
    *   `tran_amount`: Amount of the transaction.
*   **`Retail_Data_Response.csv`**: Contains customer response information (likely related to a campaign or survey).
    *   `customer_id`: Unique identifier for each customer.
    *   `response`: Binary indicator of customer response (0 or 1).

The analysis generates the following files:

*   **`MainData.csv`**: Merged and preprocessed data containing transactions linked with customer responses and added date features.
    *   Includes original columns plus `month` and `month_year` extracted from `trans_date`.
*   **`AddAnlys.csv`**: Contains the results of the RFM analysis.
    *   `customer_id`: Unique identifier for each customer.
    *   `recency`: Number of days since the customer's last transaction (relative to a reference date).
    *   `frequency`: Total number of transactions made by the customer.
    *   `monetary`: Total monetary value of transactions made by the customer.
    *   `Segment`: RFM segment assigned to the customer (e.g., P0, P1, P2 based on quantile analysis).

## Methodology / Workflow

The analysis workflow is detailed in the `data_cleaning_preprocessing.ipynb` notebook and involves the following key steps:

1.  **Data Loading:** The `Retail_Data_Transactions.csv` and `Retail_Data_Response.csv` files are loaded into pandas DataFrames.
2.  **Merging:** The transaction and response DataFrames are merged using a left join on `customer_id` to combine transaction details with response information.
3.  **Data Cleaning:**
    *   Missing values in the merged DataFrame (specifically in the `response` column after the left join) are handled by removing rows with nulls (`dropna()`).
    *   The `trans_date` column is converted to the datetime data type.
    *   The `response` column is converted to the integer data type.
4.  **Outlier Detection:** The Z-score method is applied to the `tran_amount` and `response` columns to check for potential outliers (values more than 3 standard deviations from the mean). *Note: The notebook checks for outliers but does not appear to remove them based on this check.*
5.  **Feature Engineering:**
    *   Date-based features (`month`, `month_year`) are extracted from the `trans_date` column.
    *   **RFM Metrics Calculation:**
        *   **Recency:** Calculated as the number of days between a reference date (the day after the latest transaction date in the dataset) and the customer's most recent transaction date.
        *   **Frequency:** Calculated as the total count of transactions for each customer.
        *   **Monetary:** Calculated as the sum of `tran_amount` for each customer.
6.  **RFM Segmentation:**
    *   Customers are segmented based on their Recency, Frequency, and Monetary scores.
    *   Quantiles are used to define thresholds for R, F, and M scores (e.g., dividing customers into groups based on score ranges).
    *   Segments (labeled P0, P1, P2 in the notebook) are assigned based on these quantile-based scores. *Interpretation of these segments (e.g., P0 might be high-value, P2 low-value, or vice-versa depending on score assignment) would require further analysis of the segment characteristics.*
7.  **Saving Results:** The main processed DataFrame is saved to `MainData.csv`, and the DataFrame containing RFM scores and segments is saved to `AddAnlys.csv`.

## Files in Repository

*   `data_cleaning_preprocessing.ipynb`: The Jupyter Notebook containing all the Python code for the analysis.
*   `SQLQueries.sql`: SQL script for creating a MySQL database schema and loading the initial CSV data. *Note: This is optional for running the Python analysis but useful for database replication.*
*   `Retail_Data_Transactions.csv`: Raw transaction data.
*   `Retail_Data_Response.csv`: Raw customer response data.
*   `MainData.csv`: Output file containing the cleaned, merged, and feature-engineered data.
*   `AddAnlys.csv`: Output file containing the RFM analysis results and customer segments.
*   `README.md`: This file, providing an overview and instructions.

## How to Run

1.  **Prerequisites:**
    *   Python 3.x
    *   Jupyter Notebook or JupyterLab
    *   Required Python libraries: `pandas`, `numpy`, `scipy`. You can install these using pip:
        ```bash
        pip install pandas numpy scipy jupyterlab
        ```
    *   It is recommended to use a virtual environment.

2.  **Clone the Repository (if applicable):**
    ```bash
    git clone https://github.com/deathvadeR-afk/Retail_data_analysis.git
    cd <repository-directory>
    ```

3.  **Ensure Data Files are Present:** Make sure the `Retail_Data_Transactions.csv` and `Retail_Data_Response.csv` files are in the same directory as the notebook, or update the file paths within the notebook accordingly.

4.  **Run the Jupyter Notebook:**
    *   Start JupyterLab or Jupyter Notebook:
        ```bash
        jupyter lab
        # or
        jupyter notebook
        ```
    *   Open the `data_cleaning_preprocessing.ipynb` file.
    *   Run the cells sequentially from top to bottom.

5.  **View Outputs:** The notebook will generate `MainData.csv` and `AddAnlys.csv` in the same directory upon successful execution.

## Database Setup (Optional)

The `SQLQueries.sql` file contains commands to set up a MySQL database, create tables (`Sales_Data_Transaction`, `Sales_Data_Response`), and load the data from the CSV files. 

*   You will need a running MySQL server.
*   You may need to adjust the `LOAD DATA INFILE` path in the script based on your MySQL server's secure file upload directory configuration.
*   Execute the script using a MySQL client or tool.

This database setup is not required to run the analysis in the Jupyter notebook, which reads directly from the CSV files.
