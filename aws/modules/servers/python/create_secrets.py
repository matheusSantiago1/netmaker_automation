import boto3
import os
from dotenv import load_dotenv

load_dotenv()

def create_secret():
    token = os.getenv('TOKEN')

    if token is None:
        raise ValueError("Token value is empty.")
    
    client = boto3.client('secretsmanager',
                          aws_access_key_id=os.environ.get('AWS_ACCESS_KEY'),
                          aws_secret_access_key=os.environ.get('AWS_SECRET_KEY'),
                          region_name=os.getenv('AWS_REGION'))
    
    secret_name = os.getenv('SECRET_NAME')
    secret_value = token
    secret_description = "Secret of Netmaker"
    

    response = client.create_secret(
        Name=secret_name,
        Description=secret_description,
        SecretString=secret_value
    )
    

    print("Secret created succesfully:")
    print(response)

if __name__ == "__main__":
    create_secret()
