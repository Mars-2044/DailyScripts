#!/usr/bin/env python
#-*- coding:utf-8 -*-

import os
import sys
from volcengine.example.cdn import ak, sk
from volcengine.cdn.service import CDNService

Host = "cdn.volcengineapi.com"
AK = "AKLTZDliNmJjZjliNTE2NDNlOTliZDFiMzBhZDA4MTlmZDk"
SK = "TTJObE1HUmtNR1ZrWlRobU5EVTBNbUU0Wm1ZeU1tTmlabU0yT1RWbU9Uaw=="
sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/../../../")

if len(sys.argv) < 3:
    print("\033[91mScript usage:")
    print("python hs_refresh_cdn.py [dir] [url]\033[0m")
    sys.exit(1)

Type = sys.argv[1]
Url = sys.argv[2]

if __name__ == '__main__':
    svc = CDNService()
    svc.set_ak(AK)
    svc.set_sk(SK)

    body = {
        "Type": Type,
        "Urls": Url,
    }

    try:
      resp = svc.submit_refresh_task(body)
      print(resp)
    except:
      print("刷新{u}报错".format(u=Url))
