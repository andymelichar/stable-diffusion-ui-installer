import schedule
import time
import os

def job():
    os.system('rclone copy /workspace/stable-diffusion-webui/outputs gcp:stable-diff')

schedule.every(30).seconds.do(job)

while True:
    schedule.run_pending()
    time.sleep(1)
