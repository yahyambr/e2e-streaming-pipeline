import json
import urllib.parse
import boto3
import datetime
import pandas as pd
from decimal import Decimal


s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('y1-btc-market-transformed')

def lambda_handler(event, context):
    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    try:
        response = s3.get_object(Bucket=bucket, Key=key)
        body = json.loads(response['Body'].read().decode())
        price_date = datetime.date.today().strftime('%Y%m%d')

        asks = body['result']['XXBTZUSD']['asks']
        bids = body['result']['XXBTZUSD']['bids']

        asks_df = pd.to_numeric(pd.DataFrame(asks)[0], errors='coerce')
        bids_df = pd.to_numeric(pd.DataFrame(bids)[0], errors='coerce')

        asks_avg = asks_df.mean()
        asks_median = asks_df.median()
        asks_max = asks_df.max()
        asks_min = asks_df.min()

        bids_avg = bids_df.mean()
        bids_median = bids_df.median()
        bids_max = bids_df.max()
        bids_min = bids_df.min()

        estimated_price = (bids_max + asks_min)/2
        spread = asks_max - bids_min

        item = {'price_date': int(price_date), 
                'estimated_price': str(estimated_price),
                'asks_avg': asks_avg, 
                'asks_median': asks_median, 
                'asks_max': asks_max,
                'asks_min': asks_min,
                'bids_avg': bids_avg,
                'bids_median': bids_median,
                'bids_max': bids_max,
                'bids_min': bids_min,
                'spread': spread,
                'asks': asks,
                'bids': bids }
        
        item = json.loads(json.dumps(item), parse_float=Decimal)
        table.put_item(Item = item)
    except Exception as e:
        print(e)
        raise e
              