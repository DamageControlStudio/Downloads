import os, urllib3, zipfile

if not os.path.exists("da.zip"):
	http = urllib3.PoolManager()
	url = "http://cgs.ohso.ga/upload/da.zip"
	r = http.request("GET", url)
	with open("da.zip", "wb") as f:
		f.write(r.data)

zip_file = zipfile.ZipFile("da.zip")
zip_file.extractall()
