#!/bin/sh -e

# For team tag
path_vendor="/home/junzheng_zhang/Desktop/codebase/amax-prebuilt/clock"
path_out="/home/junzheng_zhang/Desktop/codebase/4.4-clock/packages/apps"

# For Out
for project in AsusDeskClock ASUSAccount AsusFlashLight AsusSoundRecorder
do
    echo "******* Out --- "$project" ********"
    cd $path_out/$project
    project_deal=${project/Asus/}

    perl $path_base/get_tag_format.pl $project_deal
done

# For Vendor
for project2 in DeskClock ASUSAccount FlashLight SoundRecorder
do
    echo "******* Vendor --- "$project2" ********"
    cd $path_vendor
    perl $path_base/get_tag_format.pl $project2
done
