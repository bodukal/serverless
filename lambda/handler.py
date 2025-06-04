def lambda_handler(event, context):
    html_body = """
    <html>
      <head>
        <style>
          body { font-family: Arial, sans-serif; background-color: #f0f8ff; color: #333; }
          .message { 
            font-weight: bold; 
            color: #2a9d8f; 
            font-size: 20px; 
            padding: 20px; 
            border: 2px solid #264653; 
            border-radius: 8px;
            background-color: #e0f7f5;
            width: fit-content;
            margin: 40px auto;
            text-align: center;
          }
        </style>
      </head>
      <body>
        <div class="message">File processed successfully!</div>
      </body>
    </html>
    """

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/html",
            "Access-Control-Allow-Origin": "*"
        },
        "body": html_body
    }
