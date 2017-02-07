place=woods
curl 'http://maps.googleapis.com/maps/api/directions/json?origin=canastota&destination=woodsvalley&sensor=false' > $place.json
jq  -r ".routes |.[] | .legs | .[0] | [\"$place\", .distance.text,.duration.text]|@tsv" < $place.json 
