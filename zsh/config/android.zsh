alias adpaste="adb -e shell input text"

# Define the sdk home var used by some command line tools 
# and add the execs like monkey and sdkmanager to path 
export ANDROID_HOME=/usr/local/share/android-sdk
export ANDROID_SDK_HOME=$ANDROID_HOME
export ANDROID_AVD_HOME=$HOME/.android/avd/
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
