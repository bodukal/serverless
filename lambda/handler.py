import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        logger.info("Event received: %s", json.dumps(event))
        
        # Your business logic here (e.g., process the file)
        
        response_body = {
            "status": "success",
            "message": "File processed successfully",
            "details": {
                "processed_records": 42,   # example detail, adjust as needed
                "timestamp": context.aws_request_id
            }
        }
        
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps(response_body)
        }
    
    except Exception as e:
        logger.error("Error processing file: %s", str(e))
        
        return {
            "statusCode": 500,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({
                "status": "error",
                "message": "Failed to process file",
                "error": str(e)
            })
        }
