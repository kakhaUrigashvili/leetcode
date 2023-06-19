
#!/bin/bash

for row in $(cat .problemSiteData.json | jq -r '.[] | @base64')
do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }
    link="https://www.youtube.com/watch?v=$(_jq '.video')" 
    output="videos/$(_jq '.code')-$(_jq '.video')"
    if [ -f $output.webm ] || [ -f $output.mkv ]
    then
        echo "skipping $output"
    else
        echo "downloading $link to $output"
        yt-dlp "$link" -o $output
    fi
done

