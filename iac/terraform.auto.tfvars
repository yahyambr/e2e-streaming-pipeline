# general
project_tag="y1"
region="us-east-1"

# monitoring
log_group_retention_days=1


# storage
hash_key="price_date"
range_key="estimated_price"
hash_key_type="N"
range_key_type="S"
raw_data_bucket_name="y1-btc-market-raw"
table_name="y1-btc-market-transformed"
read_capacity=5
write_capacity=5

# ingestion
delivery_stream="y1-btc-market-data"
firehose_role="y1-btc-marketdata-delivery-role"
firehole_role_inline_policy="y1-btc-marketdata-delivery-policy"

# compute
lambda_transformer_source_file="../src/transform_btc_market_data/main.py"
lambda_transformer_output_path="../src/transform_btc_market_data/lambda_func.zip"
lambda_transformer_archive_type="zip"
lambda_transformer_filename="../src/transform_btc_market_data/lambda_func.zip"
lambda_transformer_function_name="y1-btc-market-data-transformer"
lambda_transformer_handler_name="main.lambda_handler"
runtime="python3.7"
lambda_transformer_role="y1-btc-marketdata-lambda-transformer-role"
lambda_transformer_role_inline_policy="y1-btc-marketdata-lambda-transformer-policy"
lambda_transformer_layers = [ "arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python37:5" ]

# scheduling
lambda_extractor_source_file = "../src/push_btc_market_data/main.py"
lambda_extractor_output_path = "../src/push_btc_market_data/lambda_func.zip"
lambda_extractor_filename = "../src/push_btc_market_data/lambda_func.zip"
lambda_extractor_handler_name = "main.lambda_handler"
lambda_extractor_archive_type = "zip"
lambda_extractor_function_name = "y1-btc-market-data-extractor"
lambda_extractor_role = "y1-btc-marketdata-lambda-extractor-role"
lambda_extractor_role_inline_policy = "y1-btc-market-data-lambda-extractor-policy"
flexible_time = "OFF"
scheduler_name = "y1-btc-market-data-extraction"
schedule_expression = "rate(15 minutes)"
scheduler_role_inline_policy = "y1-btc-market-data-scheduler-policy"
