alias adpaste="adb -e shell input text"

# Define the sdk home var used by some command line tools 
# and add the execs like monkey and sdkmanager to path 
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_AVD_HOME=$HOME/.android/avd/
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
