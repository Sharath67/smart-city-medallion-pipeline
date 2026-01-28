#!/bin/bash

echo "ETL started at $(date)" >> /home/nineleaps/Desktop/smart_city_project/logs/etl.log

/usr/bin/python3 /home/nineleaps/Desktop/smart_city_project/src/etl.py \
>> /home/nineleaps/Desktop/smart_city_project/logs/etl.log 2>&1

echo "ETL finished at $(date)" >> /home/nineleaps/Desktop/smart_city_project/logs/etl.log
echo "----------------------------" >> /home/nineleaps/Desktop/smart_city_project/logs/etl.log
