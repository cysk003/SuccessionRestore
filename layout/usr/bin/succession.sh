#!/bin/bash
#We are going to create a resources folder in the User’s var directory 
mkdir /var/mobile/Media/Succession/
#Contact helper tool to get iOS version and device model
ProductVersion=`SuccessionCLIhelper --deviceVersion`
#we are now going to get the product buildversion for example, 17c54 and set it as a variable   
ProductBuildVersion=`SuccessionCLIhelper --deviceBuildNumber`
#we now get the machine ID, (for example iPhone9,4), and store it as a variable
DeviceIdentifier=`SuccessionCLIhelper --deviceModel`
#We’ll print these values that we have retrieved  
echo your $DeviceIdentifier is running iOS version $ProductVersion build $ProductBuildVersion
echo please make sure this information is accurate before continuing

echo succession will download the correct IPSW for your device: press enter to proceed
read varblank2

#print a warning message 

echo once you press enter again, succession will begin the download 
echo  DO NOT LEAVE TERMINAL 
echo   DO NOT POWER OFF YOUR DEVICE 
read varblank2   
#we tell bash where to save the IPSW 
cd /var/mobile/Media/Succession/
echo preparing to download IPSW...
#we now get the FileName of the ipsw from apple’s servers  through ipsw.me’s api 
curl -# -LO  http://api.ipsw.me/v2.1/$DeviceIdentifier/$ProductBuildVersion/filename
echo downloading IPSW...
#we download the ipsw from apple’s servers through ipsw.me’s api    
curl  -# -LO  http://api.ipsw.me/v2.1/$DeviceIdentifier/$ProductBuildVersion/url/dl
#we’re now going to rename our file correctly
#we call the cat command in order to get the contents of /var/mobile/Media/Succession/filename as the downloaded ipsw is just called dl

#we create a variable with the contents of the file
IpswName=`cat /var/mobile/Media/Succession/filename`
#we now use the rename command

mv /var/mobile/Media/Succession/dl $IpswName.zip
#we create a new directory to put the ipsw that is going to be extracted   
mkdir /var/mobile/Media/Succession/ipsw/
echo extracting IPSW...
#we now navigate to the directory that we just created in order to save our extracted ipsw there after unzipping it   
cd /var/mobile/Media/Succession/ipsw/
unzip /var/mobile/Media/Succession/iPad_64bit_TouchID_13.3_17C54_Restore.ipsw.zip
#we create a variable called dmg as we need to find and use the largest dmg later   
 echo moving extracted files... 
 
dmg=`ls -S | head -1`
mv /var/mobile/Media/Succession/ipsw/$dmg /var/mobile/Media/Succession 
#needs completing 
