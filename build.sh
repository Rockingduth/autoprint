#!/bin/sh
# Requires JDK 17+ (javac, jar). Produces out/order-autoprint.jar; run with: java -jar out/order-autoprint.jar
set -e
rm -rf out && mkdir -p out/classes
javac --release 17 -d out/classes src/com/orderautoprint/*.java
jar --create --file out/order-autoprint.jar --main-class com.orderautoprint.Main -C out/classes .
