
import json

# Load the JSON contract from an external file
def load_contract_from_file(file_path):
    try:
        with open(file_path, 'r') as file:
            contract_json = json.load(file)
        return contract_json
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return None
    except json.JSONDecodeError:
        print(f"Error decoding JSON from file: {file_path}")
        return None

# Access contract information
def access_contract_info(contract_data):
    if contract_data is None:
        return

    contract_title = contract_data.get("contractTitle", "N/A")
    print("Contract Title:", contract_title)

    articles = contract_data.get("articles", [])
    for article in articles:
        article_number = article.get("articleNumber", "N/A")
        article_title = article.get("articleTitle", "N/A")
        print(f"Article {article_number}: {article_title}")

        sections = article.get("sections", [])
        for section in sections:
            section_number = section.get("sectionNumber", "N/A")
            section_title = section.get("sectionTitle", "N/A")
            print(f"Section {section_number}: {section_title}")

            clauses = section.get("clauses", [])
            for clause in clauses:
                clause_number = clause.get("clauseNumber", "N/A")
                clause_text = clause.get("clauseText", "N/A")
                print(f"Clause {clause_number}: {clause_text}")

                subclauses = clause.get("subclauses", [])
                for subclause in subclauses:
                    subclause_number = subclause.get("subclauseNumber", "N/A")
                    subclause_text = subclause.get("subclauseText", "N/A")
                    print(f"Subclause {subclause_number}: {subclause_text}")

if __name__ == "__main__":
    # File path to the JSON contract
    file_path = "contract.json"  # Replace with your file path

    # Load the JSON contract from the external file
    contract_data = load_contract_from_file(file_path)

    # Access and print contract information
    access_contract_info(contract_data)
