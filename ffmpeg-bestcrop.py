#!/usr/bin/env python3

import re
import sys
import subprocess

try:
  file_to_crop = sys.argv[1]
except:
  print("Please provide a video file.")
  sys.exit(1)

output = []
best_crop = {}

# regex for extracting only the crop value
regex = r"\d{1,4}:\d{1,4}:\d{1,4}:\d{1,4}"

print("Starting cropdetect on '" + file_to_crop + "'.")

# capturing ffmpeg cropdetect output
command_output = subprocess.run([
    "ffmpeg", "-i", file_to_crop,
    #debug    "-t", "1000",
    "-vf", "cropdetect",
    "-f", "null", "-"
    ],
    capture_output=True)

# converting bytes to str to list
output = str(command_output.stderr)
output = output.split('\\n')
#debug print(output)
# debug counter=1
# for line in output:
#   print("Line " + str(counter) + ": " + line)
#   counter += 1

print("Searching and sorting the most detected crops.")

for line in output:
  search_crop = re.search(regex, line)
  if search_crop is not None:
    #debug print(search_crop.group())
    crop = search_crop.group()
    if crop in best_crop:
        best_crop[crop] +=1
    else:
        best_crop[crop] = 1

# sorting list from highest to lowest value
sorted_best_crop = sorted(best_crop.items(), key=lambda x: x[1], reverse=True)

print()

# printing the most common crops
for i in range(0, len(sorted_best_crop)):
  key = sorted_best_crop[i][0]
  val = sorted_best_crop[i][1]
  print("Crop {:>15} detected {:<6} times.".format(key, val))

print()
