import os
from dotenv import load_dotenv
import boto3

load_dotenv()

def create_dns_records(records):
    client = boto3.client('route53',
                          aws_access_key_id=os.environ.get('AWS_ACCESS_KEY'),
                          aws_secret_access_key=os.environ.get('AWS_SECRET_KEY'))

    for record in records:
        domain_name = record['name']
        server_ip = record['ip']
        hosted_zone_id = os.getenv("HOSTED_ZONE_ID")
        
        response = client.change_resource_record_sets(
            HostedZoneId=hosted_zone_id,
            ChangeBatch={
                'Changes': [
                    {
                        'Action': 'UPSERT',
                        'ResourceRecordSet': {
                            'Name': domain_name,
                            'Type': 'A',
                            'TTL': 300,  
                            'ResourceRecords': [
                                {
                                    'Value': server_ip
                                },
                            ]
                        }
                    },
                ]
            }
        )

        print(f"Register DNS for {domain_name} created.")

records = [
    {'name': os.getenv('DOMAIN'), 'ip': os.getenv('SERVER_IP')},
    {'name': f"api.{os.getenv('DOMAIN')}", 'ip': os.getenv('SERVER_IP')},
    {'name': f"dashboard.{os.getenv('DOMAIN')}", 'ip': os.getenv('SERVER_IP')},
    {'name': f"broker.{os.getenv('DOMAIN')}", 'ip': os.getenv('SERVER_IP')}
]

create_dns_records(records)