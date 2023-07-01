import boto3
import requests
import json

market_data_api = "https://api.kraken.com/0/public/Depth"
params = {"pair":"XBTUSD"}
delivery_stream_name = "y1-btc-market-data"
region = "us-east-1"

def lambda_handler(event, context):
    try :
        resp = requests.get(market_data_api, params=params)
    except requests.exceptions.HTTPError as errh:
        print("HTTP Error:", errh)
    except requests.exceptions.ConnectionError as errc:
        print("Error Connecting:", errc)
    except requests.exceptions.Timeout as errt:
        print("Timeout Error:", errt)
    except requests.exceptions.RequestException as err:
        print("An error occurred:", err)
    
    firehose_client = boto3.client('firehose', region_name=region)
    firehose_client.put_record(DeliveryStreamName=delivery_stream_name, Record={'Data': json.dumps(resp.json())})

