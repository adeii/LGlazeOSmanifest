GlazeOS
===========

Getting Started - experimental
---------------

To get started with Android/Glaze OS, you'll need to get
familiar with [Repo](https://source.android.com/source/using-repo.html) and [Version Control with Git](https://source.android.com/source/version-control.html).

To initialize your local repository using the GlazeOS trees, use a command like this:

    repo init -u git://github.com/GlazeOS/manifest.git -b ng7.1
    
Add local_manifest to .repo/local_manifests

    mkdir .repo/local_manifests
    cd .repo/local_manifests
    wget https://raw.githubusercontent.com/adeii/LGlazeOSmanifest/ng7.1/local_manifest.xml
    cd ../..
   
Then to sync up:

    repo sync --force-sync --no-tags --no-clone-bundle
   
Then overwrite files with patched ones from *.zip and setup, breakfast, brunch vee7 or u8833 and God bless you!

    . build/envsetup.sh
    breakfast vee7
    brunch vee7
    
 Good luck! Project is not tested or successfully built yet!!!
