import json
import boto3 
import os
import time
from decimal import Decimal
from boto3.dynamodb.conditions import Key, Attr

# Removing Currency Symbols and Converting to a Decimal from a String, however the input JSON could also just be only allowed in a Number vs. a String
def balance_format(source):
    currency_characters = ['$','€','¥','₿', '£']
    
    for char in currency_characters: 
        source = source.replace(char,'')
    
    return Decimal(source)
    
def identity_format(source):
    source = source.split("::")
    source = source[1]

    return source
    
def lambda_handler(event, context):
    
    body = json.loads(event['body'])
    #Parsing for Caller Identity and fetching user arn
    identity = identity_format(event['requestContext']['identity']['userArn'])

    account_type    = body['account_type']
    # Running function to cleanup posted value
    initial_balance = balance_format(body['initial_balance'])


    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('accounts')
    
    #Scan is being used to populate a list of Rows, as well as used to fetch the Rows for checking ammount of Current Accounts
    account_types = table.scan(
        FilterExpression=Attr('caller').eq(identity)
    ) 
    length = len(account_types['Items'])
    if length >= 10:
        return {
          'statusCode': 400,
          'body': "Limit has been reached for account_types"
        }
    else:
        accounts = account_types['Items']
        for account in accounts:
            if account['account_type'] == account_type:
                return {
                  'statusCode': 409,
                  'body': "account_type already exists"
                }
        print("creating account")
        
        Item = {
            "account_type": f"{account_type}",
            "caller":f"{identity}",
            "balance": initial_balance
        }
        table.put_item(Item=Item)
 
       
    return {
       'statusCode': 200,
       'body': f"New Account for {account_type} with balance of ${initial_balance} has successfully been created"
    }
