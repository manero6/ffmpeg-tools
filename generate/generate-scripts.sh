#!/bin/bash

# Script to automatically generate scripts with different crf values and extension substitution

# Setting crf values
CRF_RANGE="18 19 20 21 22 23 24 25"
# Default conversion to .mp4 container
EXTENSION_TO=".mp4"

# avi2mp4
# convert avi videos to mp4
avi2mp4 () {
  CONVERSION="avi2mp4"
  SCRIPT_NAME="ffmpeg-$CONVERSION-crf"
  for CRF in $CRF_RANGE
  do
    cat <<EOF > ../$SCRIPT_NAME$CRF
#!/bin/bash
# Script automatically generated by "./generate/generate-scripts.sh"
VIDEOS="\$@"
for VIDEO in "\$VIDEOS"
do
  ffmpeg -i "\$VIDEO" -crf $CRF "\${VIDEO::-3}$CONVERSION-crf$CRF$EXTENSION_TO}"
done
EOF
    chmod +x ../$SCRIPT_NAME$CRF
  done
}

# webm2mp4
# convert webm videos to mp4

main () {
  avi2mp4
}

main