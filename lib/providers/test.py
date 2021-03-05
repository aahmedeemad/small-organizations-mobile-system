
import requests


userId=''

res =  requests.get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/usersTasks/'+userId+'.json')

if res.status_code == 200:
    print(res.content)