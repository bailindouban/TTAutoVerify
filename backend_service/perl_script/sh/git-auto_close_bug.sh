#!/bin/sh -e

path_base="/home/junzheng_zhang/Documents/DevelopeTools/TTAutoVerify/backend_service/perl_script"
echo Start... >> $path_base/LOG.txt

# For team tag
path_vendor="/home/junzheng_zhang/Desktop/codebase/amax-prebuilt/clock"
path_out="/home/junzheng_zhang/Desktop/codebase/4.4-clock/packages/apps"

# For Out
for project in AsusDeskClock ASUSAccount AsusFlashLight AsusSoundRecorder
do

    cd $path_out/$project
    project_deal=${project/Asus/}
        echo "******* Out --- "$project" ********"
    perl $path_base/get_tag_format.pl $project_deal
done

# For Vendor
for project2 in DeskClock ASUSAccount FlashLight SoundRecorder
do
    echo "******* Vendor --- "$project2" ********"
    cd $path_vendor
    perl $path_base/get_tag_format.pl $project2
done

# For Team Combine
perl $path_base/team_tag_combine.pl

# For Hangzhou Project
path_vendor="/home/junzheng_zhang/Desktop/codebase/amax-prebuilt/clock"
cd $path_vendor
perl $path_base/get_tag_format_hz.pl
perl $path_base/tt_auto_operate.pl

# Update Selector for rd_manager & developer
echo Update Selector for rd_manager and developer >> $path_base/LOG.txt
perl $path_base/rd_manager_developer.pl

echo Finished! >> $path_base/LOG.txt
