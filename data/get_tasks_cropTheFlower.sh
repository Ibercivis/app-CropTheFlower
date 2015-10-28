#!/bin/bash
#Remove existing files that will be recreated
rm ../cropTheFlower_tasks.json
#Initialize
let id=1

#Json format
echo -n "["  >> ../cropTheFlower_tasks.json

url_to_change="/home/eduardo/caffe_flora/data/images/"
new_url="http://pybossa.ibercivis.es/cropFlowerPics_app/"

#Go through the files containing the images
cat train.txt test.txt valid.txt | while read line
do
  #Extract the url (remove the id for training)
  extracted_url=$(echo $line | awk -F" " '{print $1}')
  #Update the url with the new address to the folder
  updated_url="${extracted_url/$url_to_change/$new_url}"
  #Check if it is necessary to add the puntuaction mark and a space (it is not the first element)
  if [ $id -gt 1 ]
  then

    echo -ne ", {\"link\":\""$updated_url"\"}"  >> ../cropTheFlower_tasks.json
    #echo -n ', {"link" : "'$updated_url'"}' >> ../cropTheFlower_tasks.json
  else
    #echo -n '{"link" : "'$updated_url'"}'  >> ../cropTheFlower_tasks.json
    echo -ne "{\"link\":\""$updated_url"\"}"  >> ../cropTheFlower_tasks.json
  fi
  let id+=1
done
#Json format
echo -n "]"  >> ../cropTheFlower_tasks.json
