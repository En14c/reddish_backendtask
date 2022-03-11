## Deploy the service's containers, run migrations and create the elastic search index.

```
./manage_service.sh deploy && sleep 20 && ./manage_service.sh migrations && sleep 10 && ./manage_service.sh elastic_search_index 
```

sleep(1) is there to give the mysql server and the elastic search server time to start up and to avoid the "connection refused" errors.

## kill the service's running container

```
./manage_service.sh kill
```


the following dummy python script demonstrates how the service's RESTful endpoints should be used.
```
import sys
import traceback

import requests


BASE_URL = "http://localhost:8000/api/v1"

def showcase():
    try:
        # create new app
        response = requests.post(f"{BASE_URL}/apps", json={"name": "Reddish App 1"})
        app = response.json()
        # create new chat for this app
        response = requests.post(f"{BASE_URL}/apps/{app['token']}/chats")
        chat_number = response.json()["chat_number"]
        # get metadata about the chat we just created
        response = requests.get(f"{BASE_URL}/apps/{app['token']}/chats/{chat_number}")
        # create new message for this chat
        response = requests.post(f"{BASE_URL}/apps/{app['token']}/chats/{chat_number}/messages", json={"content": "redd ish test"})
        message_number = response.json()["message_number"]
        # get metadata about the message we just created
        requests.get(f"{BASE_URL}/apps/{app['token']}/chats/{chat_number}/messages/{message_number}")
        # search trough the messages of a specific chat with ElasticSearch
        requests.get(f"{BASE_URL}/apps/{app['token']}/chats/{chat_number}/search", params={"q": "ish"})
    except (Exception,):
        traceback.print_exc()
        sys.exit(-1)

if __name__ == "__main__":
    showcase()
```