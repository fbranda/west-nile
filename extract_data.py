import tabula
import pandas as pd
import requests

# Replace with the URL of the PDF file on GitHub
pdf_url = 'https://raw.githubusercontent.com/fbranda/west-nile/main/...'

# Specify the local file path where you want to save the downloaded PDF
local_pdf_path = '...'

# Send a GET request to download the PDF
response = requests.get(pdf_url)

# Check if the request was successful (HTTP status code 200)
if response.status_code == 200:
    # Open the local file and write the PDF content to it
    with open(local_pdf_path, 'wb') as pdf_file:
        pdf_file.write(response.content)
    
    print(f'The PDF has been downloaded and saved to {local_pdf_path}')
else:
    print('Failed to download the PDF from GitHub. Check the URL and your internet connection.')


# Define a list of configurations for extracting data from different PDFs and pages.
extraction_config = [
    {'pdf_path': local_pdf_path, 'page': 3, 'data_type': 'humans'},
    {'pdf_path': local_pdf_path, 'page': 4, 'data_type': 'equids'},
    {'pdf_path': local_pdf_path, 'page': 5, 'data_type': 'target-birds'},
    {'pdf_path': local_pdf_path, 'page': 6, 'data_type': 'wild-birds'},
    {'pdf_path': local_pdf_path, 'page': 7, 'data_type': 'mosquitoes'}
]

# Create a dictionary to group data by type.
data_dict = {}

# Loop through the list of configurations
for config in extraction_config:
    pdf_file_path = config['pdf_path']
    page_to_extract = config['page']
    data_type = config['data_type']

    # Perform data extraction from the specified PDF.
    dfs = tabula.read_pdf(pdf_file_path, pages=page_to_extract)

    # Make sure there is extracted data
    if dfs:
        # Concatenates DataFrames into one by data type.
        if data_type in data_dict:
            data_dict[data_type] = pd.concat([data_dict[data_type]] + dfs, ignore_index=True)
        else:
            data_dict[data_type] = pd.concat(dfs, ignore_index=True)

# Create an Excel writer to write data to separate sheets.
excel_writer = pd.ExcelWriter('extracted_data.xlsx', engine='xlsxwriter')

# Write the data in separate sheets in the Excel file.
for data_type, df in data_dict.items():
    df.to_excel(excel_writer, sheet_name=data_type, index=False)

# Save the Excel file
excel_writer.save()

print("All extracted data were saved in an Excel file with separate sheets.")
