alias adpaste="adb -e shell input text"

# Define the sdk home var used by some command line tools 
# and add the execs like monkey and sdkmanager to path 
export ANDROID_SDK_HOME=/usr/local/Cellar/android-sdk/24.4.1_1
export ANDROID_AVD_HOME=`whoami`/.android/avd/
export PATH=$PATH:$ANDROID_SDK_HOME/tools/bin
