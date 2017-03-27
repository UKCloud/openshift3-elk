# ELK-Stack on Openshift v3

**Under construction**

These are modified dockerfiles from the official docker images. I removed the gosu stuff and made sure relevant files are world readable.

## Usage
There is a docker-compose and a openshift template file in the `example` directory.
### Local
```
docker run -it --rm --name elasticsearch lbischof/elasticsearch
docker run -it --rm --link elasticsearch:elasticsearch -p 5601:5601 lbischof/kibana
s2i build https://github.com/lbischof/openshift3-elk.git lbischof/logstash logstash --context-dir=example
docker run -it --rm --link elasticsearch:elasticsearch logstash
```
### Openshift
```
oc new-project elk
oc new-app lbischof/kibana
oc new-app lbischof/elasticsearch
oc new-app https://github.com/ukcloud/openshift3-elk.git#vcloud-metrics --context-dir=vcloud-metrics -name vcloud-metrics
oc new-app lbischof/logstash~https://github.com/ukcloud/openshift3-elk.git#vcloud-metrics --context-dir config --name logstash-git --env-file=vcloud-creds.txt
oc expose service kibana
```

