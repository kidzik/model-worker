import requests
import urllib
import os
import json
import time
from requests_toolbelt.multipart.encoder import MultipartEncoder
from requests.auth import HTTPBasicAuth
import localsettings as settings

api_root = 'http://medmod.kidzinski.com/api/'

while(1):
    r = requests.get(api_root + 'submissions/dequeue/?model=knee', auth=HTTPBasicAuth('admin', settings.PASS))

    if len(r.text) < 10:
        time.sleep(5)
        continue

    print(r)
    print(r.text)
    toprocess = r.json()

    # if toprocess['status'] == 'empty':
    #     print("Nothing to do, sleep for 10 sec")
    #     time.sleep(10)
    #     continue

    filename = "uploads/" + os.path.basename(toprocess['video'])
    submission_id = toprocess['id']
    print(submission_id)

    print(toprocess['video'])
    urllib.urlretrieve (toprocess['video'], filename)
    os.system("./process.sh %s %s" % (filename, submission_id)) 

    # analysis = None
    # analysis_file = "analysis/%s/analysis.json" % submission_id
    # if os.path.exists(analysis_file):
    #     with open(analysis_file, 'r') as data_file:
    #         analysis = data_file.read()
    analysis = "test"
    
    url = api_root + "submissions/%s/" % submission_id

    processed_video = None
    if analysis:
        processed_video = (submission_id + ".jpg", open(filename), 'image/jpeg')
    fields = {
        'processed_video': processed_video,
        'analysis': analysis,
        'status': 'd' if analysis else 'e',
    }

    m = MultipartEncoder(fields = fields)

    r = requests.patch(url, data=m,
                    headers={'Content-Type': m.content_type}, auth=HTTPBasicAuth('admin', settings.PASS))
    print(r)
    print(r.text)
