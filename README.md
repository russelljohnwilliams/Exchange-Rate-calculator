FreeAgent-Code-Test

FX-u-like is a Exchange Rate app, you can select an amount you would like to convert and choose the <i>'from'</i> currency and  <i>'to'</i> currency. You can select a date to check, the default is the current rate, but you can go back and check the last 90 days worth of exchange rates. 

The feed used for the rates is parsed from European Central Bank's XML feed ('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'), however, the file is stored locally in a data.xml file and it is this data the apps runs from. If the ecb site is down, the last backed up file will be used instead of a fresh rendering of the feed.


This is the front page of the FX-u-like Web App
![screen shot 2016-10-18 at 21 31 50](https://cloud.githubusercontent.com/assets/18755619/19495244/81663e28-957a-11e6-8cc3-822f154a2ec1.png)


This is the Results page of the FX-u-like Web App
![screen shot 2016-10-18 at 21 32 05](https://cloud.githubusercontent.com/assets/18755619/19495267/94f1f41e-957a-11e6-9519-fa8fc7ac9237.png)


To start the app just download the file, then in terminal go inside the downloaded folder ('FreeAgent-Code-Test-master'). From inside this folder you may need to type: 

$ bundle install

or:

$ sudo bundle install

if all seems well, they you can type:

$ ruby controller.rb   

This should start the server, now in the browser go to:

localhost:4567
